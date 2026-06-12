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
 */
const listAlerts = async ({ clinicId, userId, role }) => {
  const where = { clinicId };

  // Clinic owners and super admins see all alerts for their clinic
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
