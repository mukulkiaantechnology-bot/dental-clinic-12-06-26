'use strict';
const prisma = require('../../config/db');

/**
 * List all clinics (for Super Admin dashboard)
 */
const listClinics = async () => {
  const clinics = await prisma.clinic.findMany({
    orderBy: { name: 'asc' },
    include: {
      _count: {
        select: { patients: true }
      }
    }
  });
  return clinics.map(c => ({
    ...c,
    patients: c._count.patients,
    revenue: c.monthlyFee
  }));
};

/**
 * Get clinic by ID
 */
const getClinicById = async (id) => {
  const clinic = await prisma.clinic.findUnique({
    where: { id },
    include: {
      _count: {
        select: { patients: true }
      }
    }
  });
  if (!clinic) {
    throw Object.assign(new Error('Clinic not found'), { statusCode: 404 });
  }
  return {
    ...clinic,
    patients: clinic._count.patients,
    revenue: clinic.monthlyFee
  };
};

/**
 * Create a new clinic
 */
const createClinic = async (body) => {
  const { id, name, location, phone, status, plan, monthlyFee, performanceScore, aiModules } = body;
  
  const clinic = await prisma.clinic.create({
    data: {
      ...(id && { id }),
      name,
      location,
      phone,
      status: status || 'Active',
      plan: plan || 'Basic',
      monthlyFee: monthlyFee !== undefined ? Number(monthlyFee) : 149.0,
      performanceScore: performanceScore !== undefined ? Number(performanceScore) : 85,
      aiModules: aiModules || { diagnostic: false, recallSMS: false, workload: false },
    },
  });

  return clinic;
};

/**
 * Update clinic details
 */
const updateClinic = async (id, body) => {
  const clinic = await prisma.clinic.findUnique({
    where: { id },
  });
  if (!clinic) {
    throw Object.assign(new Error('Clinic not found'), { statusCode: 404 });
  }

  const { name, location, phone, status, plan, monthlyFee, performanceScore, aiModules } = body;

  const updated = await prisma.clinic.update({
    where: { id },
    data: {
      ...(name && { name }),
      ...(location && { location }),
      ...(phone && { phone }),
      ...(status && { status }),
      ...(plan && { plan }),
      ...(monthlyFee !== undefined && { monthlyFee: Number(monthlyFee) }),
      ...(performanceScore !== undefined && { performanceScore: Number(performanceScore) }),
      ...(aiModules !== undefined && { aiModules }),
    },
  });

  return updated;
};

/**
 * Delete a clinic
 */
const deleteClinic = async (id) => {
  const clinic = await prisma.clinic.findUnique({
    where: { id },
  });
  if (!clinic) {
    throw Object.assign(new Error('Clinic not found'), { statusCode: 404 });
  }

  // Cascading deletes manually if required, but delete Clinic directly.
  // Note: appointments, patients have FK relation to Clinic. In schema they don't have cascade delete.
  // So we delete dependent records first or delete them as needed. But standard deleteClinic handles it.
  await prisma.appointment.deleteMany({ where: { clinicId: id } });
  await prisma.patient.deleteMany({ where: { clinicId: id } });
  await prisma.user.deleteMany({ where: { clinicId: id } });
  await prisma.clinic.delete({
    where: { id },
  });

  return { id };
};

/**
 * Toggle AI module status
 */
const toggleAiModule = async (id, { moduleName }) => {
  const clinic = await prisma.clinic.findUnique({
    where: { id },
  });
  if (!clinic) {
    throw Object.assign(new Error('Clinic not found'), { statusCode: 404 });
  }

  const currentModules = typeof clinic.aiModules === 'string'
    ? JSON.parse(clinic.aiModules)
    : (clinic.aiModules || {});

  const updatedModules = {
    ...currentModules,
    [moduleName]: !currentModules[moduleName],
  };

  const updated = await prisma.clinic.update({
    where: { id },
    data: { aiModules: updatedModules },
  });

  return updated;
};

/**
 * Update clinic subscription plan and status
 */
const updateSubscription = async (id, { plan, status, monthlyFee }) => {
  const clinic = await prisma.clinic.findUnique({
    where: { id },
  });
  if (!clinic) {
    throw Object.assign(new Error('Clinic not found'), { statusCode: 404 });
  }

  const updated = await prisma.clinic.update({
    where: { id },
    data: {
      plan,
      status,
      monthlyFee: monthlyFee !== undefined ? Number(monthlyFee) : clinic.monthlyFee,
    },
  });

  return updated;
};

/**
 * Update clinic operational status
 */
const updateStatus = async (id, { status }) => {
  const clinic = await prisma.clinic.findUnique({
    where: { id },
  });
  if (!clinic) {
    throw Object.assign(new Error('Clinic not found'), { statusCode: 404 });
  }

  const updated = await prisma.clinic.update({
    where: { id },
    data: { status },
  });

  return updated;
};

module.exports = {
  listClinics,
  getClinicById,
  createClinic,
  updateClinic,
  deleteClinic,
  toggleAiModule,
  updateSubscription,
  updateStatus,
};
