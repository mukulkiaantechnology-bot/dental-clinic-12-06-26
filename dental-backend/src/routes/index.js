'use strict';
const { Router } = require('express');

const authRoutes = require('../modules/auth/auth.routes');
const appointmentRoutes = require('../modules/appointments/appointment.routes');
const patientRoutes = require('../modules/patients/patient.routes');
const clinicRoutes = require('../modules/clinics/clinic.routes');
const userRoutes = require('../modules/users/user.routes');
const saasInvoiceRoutes = require('../modules/saasInvoices/saasInvoice.routes');
const auditLogRoutes = require('../modules/auditLogs/auditLog.routes');
const alertRoutes = require('../modules/alerts/alert.routes');

const router = Router();

// ─── API v1 ROUTES ────────────────────────────────────────────────────────────

router.use('/auth', authRoutes);
router.use('/appointments', appointmentRoutes);
router.use('/patients', patientRoutes);
router.use('/clinics', clinicRoutes);
router.use('/users', userRoutes);
router.use('/saas-invoices', saasInvoiceRoutes);
router.use('/audit-logs', auditLogRoutes);
router.use('/alerts', alertRoutes);

// Phase 2/3/4 — coming soon:
// router.use('/treatments', treatmentRoutes);
// router.use('/billing', billingRoutes);
// router.use('/ai', aiRoutes);
// router.use('/lab', labRoutes);

module.exports = router;
