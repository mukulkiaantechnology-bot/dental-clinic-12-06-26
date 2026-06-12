'use strict';
const prisma = require('../../config/db');
const alertService = require('../alerts/alert.service');

/**
 * List appointments — clinic-scoped, optionally filtered by date/role
 */
const listAppointments = async ({ clinicId, role, userId, date }) => {
  const where = { clinicId };

  // Date filter (expects 'YYYY-MM-DD')
  if (date) {
    const start = new Date(date);
    start.setHours(0, 0, 0, 0);
    const end = new Date(date);
    end.setHours(23, 59, 59, 999);
    where.date = { gte: start, lte: end };
  }

  // Hygienist: sees appointments assigned to them
  if (role === 'hygienist') {
    where.OR = [
      { assignedHygienistId: userId },
      { hygienistName: { not: null } }
    ];
  }

  // Dentist: sees only their own appointments
  if (role === 'dentist') {
    where.OR = [
      { assignedDoctorId: userId },
      { dentistId: userId }
    ];
  }

  // Assistant: sees only appointments assigned to them
  if (role === 'dental_assistant' || role === 'assistant') {
    where.assignedAssistantId = userId;
  }

  // Patient: sees only their own appointments
  if (role === 'patient') {
    const patient = await prisma.patient.findFirst({ where: { userId } });
    if (patient) {
      where.patientId = patient.id;
    } else {
      return [];
    }
  }

  const appointments = await prisma.appointment.findMany({
    where,
    orderBy: [{ date: 'asc' }, { time: 'asc' }],
    include: {
      patient: {
        select: { id: true, name: true, age: true, phone: true, email: true },
      },
      dentist: {
        select: { id: true, name: true, email: true },
      },
      assignedDoctor: {
        select: { id: true, name: true, email: true },
      },
      assignedAssistant: {
        select: { id: true, name: true, email: true },
      },
      assignedHygienist: {
        select: { id: true, name: true, email: true },
      },
    },
  });

  return appointments.map(formatAppointment);
};

/**
 * Create appointment
 */
const createAppointment = async ({ clinicId, body }) => {
  const {
    patientId,
    dentistId,
    patientName,
    dentistName,
    hygienistName,
    date,
    time,
    duration,
    type,
    notes,
    assignedTo,
    assignedDoctorId,
    assignedAssistantId,
    assignedHygienistId,
    workflowStage
  } = body;

  // Verify patient belongs to clinic
  const patient = await prisma.patient.findFirst({
    where: { id: patientId, clinicId },
  });
  if (!patient) {
    throw Object.assign(new Error('Patient not found in this clinic'), { statusCode: 404 });
  }

  // Resolve dentist name if ID given
  const docId = assignedDoctorId || dentistId || null;
  let resolvedDentistName = dentistName || '';
  if (docId && !resolvedDentistName) {
    const dentistUser = await prisma.user.findUnique({ where: { id: docId } });
    if (dentistUser) resolvedDentistName = dentistUser.name;
  }

  // Resolve hygienist name if ID given
  let resolvedHygienistName = hygienistName || '';
  if (assignedHygienistId && !resolvedHygienistName) {
    const hygienistUser = await prisma.user.findUnique({ where: { id: assignedHygienistId } });
    if (hygienistUser) resolvedHygienistName = hygienistUser.name;
  }

  // Sync stage to legacy status
  const targetStage = workflowStage || 'SCHEDULED';
  const legacyStatus = targetStage === 'COMPLETED' ? 'Completed' : targetStage === 'CANCELLED' ? 'Cancelled' : 'Scheduled';

  const appointment = await prisma.appointment.create({
    data: {
      clinicId,
      patientId,
      dentistId: docId,
      patientName: patientName || patient.name,
      dentistName: resolvedDentistName,
      hygienistName: resolvedHygienistName || null,
      date: new Date(date),
      time: time || '09:00',
      duration: Number(duration) || 45,
      status: legacyStatus,
      type: type || 'Cleaning',
      notes: notes || null,
      assignedTo: assignedTo || 'dentist',
      assignedDoctorId: docId,
      assignedAssistantId: assignedAssistantId || null,
      assignedHygienistId: assignedHygienistId || null,
      workflowStage: targetStage
    },
    include: {
      patient: { select: { id: true, name: true } },
      dentist: { select: { id: true, name: true } },
      assignedDoctor: { select: { id: true, name: true, email: true } },
      assignedAssistant: { select: { id: true, name: true, email: true } },
      assignedHygienist: { select: { id: true, name: true, email: true } },
    },
  });

  // --- TRIGGER CREATION ALERTS ---
  await alertService.createAlert({
    clinicId,
    role: 'front_desk',
    title: 'New Appointment Scheduled',
    message: `A new appointment has been scheduled for patient ${patientName || patient.name}.`,
    type: 'info'
  });

  if (docId) {
    await alertService.createAlert({
      clinicId,
      userId: docId,
      role: 'dentist',
      title: 'New Patient Assigned',
      message: `Patient ${patientName || patient.name} has been assigned to you.`,
      type: 'info'
    });
  }

  if (assignedAssistantId) {
    await alertService.createAlert({
      clinicId,
      userId: assignedAssistantId,
      role: 'dental_assistant',
      title: 'Preparation Required',
      message: `Preparation required for upcoming appointment with patient ${patientName || patient.name}.`,
      type: 'warning'
    });
  }

  if (assignedHygienistId) {
    await alertService.createAlert({
      clinicId,
      userId: assignedHygienistId,
      role: 'hygienist',
      title: 'Cleaning Appointment Assigned',
      message: `A new cleaning appointment has been assigned to you for patient ${patientName || patient.name}.`,
      type: 'info'
    });
  }

  return formatAppointment(appointment);
};

/**
 * Update appointment details (reschedule)
 */
const updateAppointment = async ({ id, clinicId, body }) => {
  const appointment = await prisma.appointment.findFirst({
    where: { id, clinicId },
  });

  if (!appointment) {
    throw Object.assign(new Error('Appointment not found'), { statusCode: 404 });
  }

  const {
    date,
    time,
    duration,
    type,
    notes,
    dentistId,
    dentistName,
    hygienistName,
    assignedTo,
    assignedDoctorId,
    assignedAssistantId,
    assignedHygienistId,
    workflowStage
  } = body;

  const docId = assignedDoctorId !== undefined ? assignedDoctorId : (dentistId !== undefined ? dentistId : undefined);

  // Sync stage to legacy status
  let legacyStatus = undefined;
  if (workflowStage) {
    legacyStatus = workflowStage === 'COMPLETED' ? 'Completed' : workflowStage === 'CANCELLED' ? 'Cancelled' : 'Scheduled';
  }

  const updated = await prisma.appointment.update({
    where: { id },
    data: {
      ...(date && { date: new Date(date) }),
      ...(time && { time }),
      ...(duration && { duration: Number(duration) }),
      ...(type && { type }),
      ...(notes !== undefined && { notes }),
      ...(docId !== undefined && { dentistId: docId, assignedDoctorId: docId }),
      ...(dentistName && { dentistName }),
      ...(hygienistName !== undefined && { hygienistName }),
      ...(assignedHygienistId !== undefined && { assignedHygienistId }),
      ...(assignedAssistantId !== undefined && { assignedAssistantId }),
      ...(assignedTo && { assignedTo }),
      ...(workflowStage && { workflowStage }),
      ...(legacyStatus && { status: legacyStatus }),
    },
    include: {
      patient: { select: { id: true, name: true } },
      dentist: { select: { id: true, name: true } },
      assignedDoctor: { select: { id: true, name: true, email: true } },
      assignedAssistant: { select: { id: true, name: true, email: true } },
      assignedHygienist: { select: { id: true, name: true, email: true } },
    },
  });

  return formatAppointment(updated);
};

/**
 * Assign clinician roles
 */
const assignDoctor = async (id, doctorId, clinicId) => {
  const appointment = await prisma.appointment.findFirst({
    where: { id, clinicId }
  });
  if (!appointment) {
    throw Object.assign(new Error('Appointment not found'), { statusCode: 404 });
  }

  const doctor = await prisma.user.findUnique({ where: { id: doctorId } });
  if (!doctor) {
    throw Object.assign(new Error('Doctor not found'), { statusCode: 404 });
  }

  const updated = await prisma.appointment.update({
    where: { id },
    data: {
      assignedDoctorId: doctorId,
      dentistId: doctorId,
      dentistName: doctor.name
    },
    include: {
      patient: { select: { id: true, name: true } },
      dentist: { select: { id: true, name: true } },
      assignedDoctor: { select: { id: true, name: true, email: true } },
      assignedAssistant: { select: { id: true, name: true, email: true } },
      assignedHygienist: { select: { id: true, name: true, email: true } },
    }
  });

  await alertService.createAlert({
    clinicId,
    userId: doctorId,
    role: 'dentist',
    title: 'New Patient Assigned',
    message: `Patient ${appointment.patientName} has been assigned to you.`,
    type: 'info'
  });

  return formatAppointment(updated);
};

const assignAssistant = async (id, assistantId, clinicId) => {
  const appointment = await prisma.appointment.findFirst({
    where: { id, clinicId }
  });
  if (!appointment) {
    throw Object.assign(new Error('Appointment not found'), { statusCode: 404 });
  }

  const assistant = await prisma.user.findUnique({ where: { id: assistantId } });
  if (!assistant) {
    throw Object.assign(new Error('Assistant not found'), { statusCode: 404 });
  }

  const updated = await prisma.appointment.update({
    where: { id },
    data: {
      assignedAssistantId: assistantId
    },
    include: {
      patient: { select: { id: true, name: true } },
      dentist: { select: { id: true, name: true } },
      assignedDoctor: { select: { id: true, name: true, email: true } },
      assignedAssistant: { select: { id: true, name: true, email: true } },
      assignedHygienist: { select: { id: true, name: true, email: true } },
    }
  });

  await alertService.createAlert({
    clinicId,
    userId: assistantId,
    role: 'dental_assistant',
    title: 'Preparation Required',
    message: `Preparation required for upcoming appointment with patient ${appointment.patientName}.`,
    type: 'warning'
  });

  return formatAppointment(updated);
};

const assignHygienist = async (id, hygienistId, clinicId) => {
  const appointment = await prisma.appointment.findFirst({
    where: { id, clinicId }
  });
  if (!appointment) {
    throw Object.assign(new Error('Appointment not found'), { statusCode: 404 });
  }

  const hygienist = await prisma.user.findUnique({ where: { id: hygienistId } });
  if (!hygienist) {
    throw Object.assign(new Error('Hygienist not found'), { statusCode: 404 });
  }

  const updated = await prisma.appointment.update({
    where: { id },
    data: {
      assignedHygienistId: hygienistId,
      hygienistName: hygienist.name
    },
    include: {
      patient: { select: { id: true, name: true } },
      dentist: { select: { id: true, name: true } },
      assignedDoctor: { select: { id: true, name: true, email: true } },
      assignedAssistant: { select: { id: true, name: true, email: true } },
      assignedHygienist: { select: { id: true, name: true, email: true } },
    }
  });

  await alertService.createAlert({
    clinicId,
    userId: hygienistId,
    role: 'hygienist',
    title: 'Cleaning Appointment Assigned',
    message: `A new cleaning appointment has been assigned to you for patient ${appointment.patientName}.`,
    type: 'info'
  });

  return formatAppointment(updated);
};

/**
 * Update workflow stage
 */
const VALID_WORKFLOW_TRANSITIONS = {
  // SCHEDULED: Front desk can either Confirm (advance) OR directly Check In (walk-in)
  SCHEDULED:          ['CONFIRMED', 'CHECKED_IN', 'CANCELLED'],
  CONFIRMED:          ['CHECKED_IN', 'CANCELLED'],
  CHECKED_IN:         ['IN_PROGRESS', 'CANCELLED'],
  IN_PROGRESS:        ['CLEANING_PENDING', 'TREATMENT_PENDING', 'COMPLETED', 'CANCELLED'],
  CLEANING_PENDING:   ['TREATMENT_PENDING', 'COMPLETED', 'CANCELLED'],
  TREATMENT_PENDING:  ['CLEANING_PENDING', 'COMPLETED', 'CANCELLED'],
  COMPLETED:          [],
  CANCELLED:          [],
};

const updateWorkflowStage = async (id, stage, clinicId) => {
  const appointment = await prisma.appointment.findFirst({
    where: { id, clinicId }
  });
  if (!appointment) {
    throw Object.assign(new Error('Appointment not found'), { statusCode: 404 });
  }

  if (appointment.workflowStage === stage) {
    return formatAppointment(appointment);
  }

  const allowed = VALID_WORKFLOW_TRANSITIONS[appointment.workflowStage] || [];
  if (!allowed.includes(stage)) {
    throw Object.assign(
      new Error(`Invalid workflow stage transition: ${appointment.workflowStage} → ${stage}. Allowed: [${allowed.join(', ')}]`),
      { statusCode: 400 }
    );
  }

  // Map stage to legacy status
  let legacyStatus = 'Scheduled';
  if (stage === 'CHECKED_IN') legacyStatus = 'Checked_In';
  else if (stage === 'IN_PROGRESS' || stage === 'CLEANING_PENDING') legacyStatus = 'In_Progress';
  else if (stage === 'TREATMENT_PENDING') legacyStatus = 'Ready_For_Doctor';
  else if (stage === 'COMPLETED') legacyStatus = 'Completed';
  else if (stage === 'CANCELLED') legacyStatus = 'Cancelled';

  const updated = await prisma.appointment.update({
    where: { id },
    data: {
      workflowStage: stage,
      status: legacyStatus
    },
    include: {
      patient: { select: { id: true, name: true } },
      dentist: { select: { id: true, name: true } },
      assignedDoctor: { select: { id: true, name: true, email: true } },
      assignedAssistant: { select: { id: true, name: true, email: true } },
      assignedHygienist: { select: { id: true, name: true, email: true } },
    }
  });

  // --- STAGE ALERTS ---
  if (stage === 'CHECKED_IN') {
    await alertService.createAlert({
      clinicId,
      role: 'front_desk',
      title: 'Patient Checked In',
      message: `Patient ${appointment.patientName} has checked in and is ready.`,
      type: 'info'
    });
    if (appointment.assignedAssistantId) {
      await alertService.createAlert({
        clinicId,
        userId: appointment.assignedAssistantId,
        role: 'dental_assistant',
        title: 'Preparation Required',
        message: `Patient ${appointment.patientName} has checked in. Seat preparation required.`,
        type: 'warning'
      });
    }
  }

  if (stage === 'IN_PROGRESS' || stage === 'CLEANING_PENDING' || stage === 'TREATMENT_PENDING') {
    if (appointment.assignedDoctorId) {
      await alertService.createAlert({
        clinicId,
        userId: appointment.assignedDoctorId,
        role: 'dentist',
        title: 'Treatment Stage Updated',
        message: `Appointment for ${appointment.patientName} is now ${stage.replace('_', ' ')}.`,
        type: 'info'
      });
    }
    // Also notify assistant
    if (appointment.assignedAssistantId) {
      await alertService.createAlert({
        clinicId,
        userId: appointment.assignedAssistantId,
        role: 'dental_assistant',
        title: 'Treatment In Progress',
        message: `Treatment for ${appointment.patientName} has started. Chairside assist mode active.`,
        type: 'info'
      });
    }
    // Also notify front desk
    await alertService.createAlert({
      clinicId,
      role: 'front_desk',
      title: 'Patient In Treatment',
      message: `Patient ${appointment.patientName} is now in treatment stage: ${stage.replace('_', ' ')}.`,
      type: 'info'
    });
    // Also notify clinic owner
    await alertService.createAlert({
      clinicId,
      role: 'clinic_owner',
      title: 'Clinical Workflow Advanced',
      message: `Appointment for ${appointment.patientName} advanced to ${stage.replace('_', ' ')}.`,
      type: 'info'
    });
  }

  if (stage === 'COMPLETED') {
    await alertService.createAlert({
      clinicId,
      role: 'front_desk',
      title: 'Appointment Completed',
      message: `Appointment for ${appointment.patientName} is completed.`,
      type: 'success'
    });
    await alertService.createAlert({
      clinicId,
      role: 'billing_staff',
      title: 'Billing Triggered',
      message: `Billing triggered for patient ${appointment.patientName}'s completed treatment.`,
      type: 'success'
    });
    // Also notify clinic owner
    await alertService.createAlert({
      clinicId,
      role: 'clinic_owner',
      title: 'Appointment Completed',
      message: `Clinician completed the treatment session for ${appointment.patientName}.`,
      type: 'success'
    });
  }

  return formatAppointment(updated);
};

/**
 * Delete / cancel appointment
 */
const deleteAppointment = async ({ id, clinicId }) => {
  const appointment = await prisma.appointment.findFirst({
    where: { id, clinicId },
  });

  if (!appointment) {
    throw Object.assign(new Error('Appointment not found'), { statusCode: 404 });
  }

  await prisma.appointment.delete({ where: { id } });
  return { id };
};

/**
 * Format appointment for API response — matches frontend data contract exactly
 */
const formatAppointment = (appt) => ({
  id: appt.id,
  clinicId: appt.clinicId,
  patientId: appt.patientId,
  dentistId: appt.dentistId,
  patientName: appt.patientName,
  dentistName: appt.dentistName,
  hygienistName: appt.hygienistName || null,
  date: appt.date instanceof Date
    ? appt.date.toISOString().split('T')[0]
    : appt.date,
  time: appt.time,
  duration: appt.duration,
  status: appt.status,
  type: appt.type,
  notes: appt.notes || '',
  assignedTo: appt.assignedTo || 'dentist',
  patient: appt.patient || null,
  dentist: appt.dentist || null,
  assignedDoctorId: appt.assignedDoctorId || null,
  assignedAssistantId: appt.assignedAssistantId || null,
  assignedHygienistId: appt.assignedHygienistId || null,
  workflowStage: appt.workflowStage || 'SCHEDULED',
  assignedDoctor: appt.assignedDoctor || null,
  assignedAssistant: appt.assignedAssistant || null,
  assignedHygienist: appt.assignedHygienist || null,
  createdAt: appt.createdAt,
  updatedAt: appt.updatedAt,
});

module.exports = {
  listAppointments,
  createAppointment,
  updateAppointment,
  deleteAppointment,
  assignDoctor,
  assignAssistant,
  assignHygienist,
  updateWorkflowStage,
};
