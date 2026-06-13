'use strict';
const prisma = require('../../config/db');

/**
 * Create a new alert
 */
const createAlert = async ({ clinicId, userId, role, title, message, type }) => {
  return await prisma.alert.create({
    data: {
      clinicId,
      userId: userId || null,
      role: role || null,
      title,
      message,
      type: type || 'info',
      read: false
    }
  });
};

/**
 * List alerts scoped to a clinic and filtered by user/role
 * super_admin with no clinicId sees all alerts across all clinics
 */
const listAlerts = async ({ clinicId, userId, role }) => {
  // super_admin without clinicId: show all alerts platform-wide
  if (role === 'super_admin' && !clinicId) {
    return await prisma.alert.findMany({
      orderBy: { createdAt: 'desc' },
      take: 200
    });
  }

  // No clinicId at all: return empty
  if (!clinicId) return [];

  const where = { clinicId };

  // Clinic owners see all alerts for their clinic
  if (role !== 'clinic_owner' && role !== 'super_admin') {
    where.OR = [
      // Alerts specific to this user
      ...(userId ? [{ userId }] : []),
      // Alerts specific to this role
      ...(role ? [{ role }] : []),
      // Global clinic alerts (no specific user or role)
      { userId: null, role: null }
    ];
  }

  return await prisma.alert.findMany({
    where,
    orderBy: { createdAt: 'desc' },
  });
};

/**
 * Mark a single alert as read
 */
const markAsRead = async (id) => {
  return await prisma.alert.update({
    where: { id },
    data: { read: true }
  });
};

/**
 * Mark all alerts as read for a specific user/role context
 */
const markAllAsRead = async ({ clinicId, userId, role }) => {
  // super_admin without clinicId: mark all globally
  if (role === 'super_admin' && !clinicId) {
    return await prisma.alert.updateMany({
      where: { read: false },
      data: { read: true }
    });
  }

  if (!clinicId) return { count: 0 };

  const where = {
    clinicId,
    read: false
  };

  if (role !== 'clinic_owner' && role !== 'super_admin') {
    where.OR = [
      ...(userId ? [{ userId }] : []),
      ...(role ? [{ role }] : []),
      { userId: null, role: null }
    ];
  }

  return await prisma.alert.updateMany({
    where,
    data: { read: true }
  });
};

module.exports = {
  createAlert,
  listAlerts,
  markAsRead,
  markAllAsRead
};
