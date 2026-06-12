'use strict';
const prisma = require('../../config/db');
const { hashPassword } = require('../../utils/hash');

/**
 * Format patient for API response — converts comma-separated allergies to array
 */
const formatPatient = (pat) => {
  if (!pat) return null;
  return {
    ...pat,
    allergies: pat.allergies
      ? pat.allergies.split(',').map((s) => s.trim()).filter(Boolean)
      : [],
  };
};

/**
 * List patients scoped by clinicId
 */
const listPatients = async ({ clinicId }) => {
  const patients = await prisma.patient.findMany({
    where: { clinicId },
    orderBy: { name: 'asc' },
  });
  return patients.map(formatPatient);
};

/**
 * Get patient by ID and clinicId
 */
const getPatientById = async ({ id, clinicId }) => {
  const patient = await prisma.patient.findFirst({
    where: { id, clinicId },
  });
  if (!patient) {
    throw Object.assign(new Error('Patient not found'), { statusCode: 404 });
  }
  return formatPatient(patient);
};

/**
 * Create a new patient
 */
const createPatient = async ({ clinicId, body }) => {
  const { name, age, gender, phone, email, status, address, allergies, insuranceProvider, vitals, history, password } = body;

  const allergyStr = Array.isArray(allergies)
    ? allergies.join(', ')
    : (allergies || '');

  let userId = null;

  if (email) {
    if (password) {
      // CASE 1: Email + Password provided (LOGIN ENABLED PATIENT)
      const existing = await prisma.user.findUnique({ where: { email } });
      if (existing) {
        throw Object.assign(new Error('Email is already registered'), { statusCode: 400 });
      }

      const hashedPassword = await hashPassword(password);
      const user = await prisma.user.create({
        data: {
          name,
          email,
          password: hashedPassword,
          role: 'patient',
          status: 'Approved',
          clinicId: clinicId || null,
        }
      });
      userId = user.id;
    }
    // CASE 2: Email provided BUT NO password -> userId remains null, created user is skipped
  }
  // CASE 3: No email -> userId remains null, created user is skipped

  const patient = await prisma.patient.create({
    data: {
      clinicId,
      name,
      age: Number(age) || 0,
      gender: gender || 'Other',
      phone,
      email: email || null,
      status: status || 'Active',
      address: address || '',
      allergies: allergyStr,
      insuranceProvider: insuranceProvider || 'None',
      vitals: vitals || '',
      history: history || '',
      userId,
    },
  });

  return formatPatient(patient);
};

/**
 * Update an existing patient
 */
const updatePatient = async ({ id, clinicId, body }) => {
  const patient = await prisma.patient.findFirst({
    where: { id, clinicId },
  });
  if (!patient) {
    throw Object.assign(new Error('Patient not found'), { statusCode: 404 });
  }

  const { name, age, gender, phone, email, status, address, allergies, insuranceProvider, vitals, history, password } = body;

  let newUserId = undefined;

  if (patient.userId) {
    // If email is changing, ensure uniqueness
    if (email && email !== patient.email) {
      const existing = await prisma.user.findFirst({
        where: {
          email,
          id: { not: patient.userId }
        }
      });
      if (existing) {
        throw Object.assign(new Error('Email is already registered'), { statusCode: 400 });
      }
    }

    const hashedPassword = password ? await hashPassword(password) : undefined;
    await prisma.user.update({
      where: { id: patient.userId },
      data: {
        ...(name && { name }),
        ...(email && { email }),
        ...(hashedPassword && { password: hashedPassword }),
      }
    });
  } else {
    // If patient has NO userId, but email (either updated or existing) + password are now provided:
    const activeEmail = email !== undefined ? email : patient.email;
    if (activeEmail && password) {
      const existing = await prisma.user.findUnique({ where: { email: activeEmail } });
      if (existing) {
        throw Object.assign(new Error('Email is already registered'), { statusCode: 400 });
      }

      const hashedPassword = await hashPassword(password);
      const user = await prisma.user.create({
        data: {
          name: name || patient.name,
          email: activeEmail,
          password: hashedPassword,
          role: 'patient',
          status: 'Approved',
          clinicId: clinicId || patient.clinicId || null,
        }
      });
      newUserId = user.id;
    }
  }

  const allergyStr = Array.isArray(allergies)
    ? allergies.join(', ')
    : allergies !== undefined
      ? allergies
      : undefined;

  const updated = await prisma.patient.update({
    where: { id },
    data: {
      ...(name && { name }),
      ...(age !== undefined && { age: Number(age) }),
      ...(gender && { gender }),
      ...(phone && { phone }),
      ...(email !== undefined && { email }),
      ...(status && { status }),
      ...(address !== undefined && { address }),
      ...(allergyStr !== undefined && { allergies: allergyStr }),
      ...(insuranceProvider !== undefined && { insuranceProvider }),
      ...(vitals !== undefined && { vitals }),
      ...(history !== undefined && { history }),
      ...(newUserId && { userId: newUserId }),
    },
  });

  return formatPatient(updated);
};

/**
 * Delete a patient
 */
const deletePatient = async ({ id, clinicId }) => {
  const patient = await prisma.patient.findFirst({
    where: { id, clinicId },
  });
  if (!patient) {
    throw Object.assign(new Error('Patient not found'), { statusCode: 404 });
  }

  if (patient.userId) {
    await prisma.refreshToken.deleteMany({ where: { userId: patient.userId } });
  }

  // Delete dependent tables to avoid foreign key violations
  await prisma.odontogram.deleteMany({ where: { patientId: id } });
  await prisma.appointment.deleteMany({ where: { patientId: id } });
  await prisma.treatmentPlan.deleteMany({ where: { patientId: id } });
  await prisma.xrayFile.deleteMany({ where: { patientId: id } });
  await prisma.prescription.deleteMany({ where: { patientId: id } });
  await prisma.clinicalNote.deleteMany({ where: { patientId: id } });
  await prisma.invoice.deleteMany({ where: { patientId: id } });
  await prisma.labCase.deleteMany({ where: { patientId: id } });

  await prisma.patient.delete({
    where: { id },
  });

  if (patient.userId) {
    try {
      await prisma.user.delete({ where: { id: patient.userId } });
    } catch (err) {
      console.error('Failed to delete user record:', err);
    }
  }

  return { id };
};

module.exports = {
  listPatients,
  getPatientById,
  createPatient,
  updatePatient,
  deletePatient,
};

