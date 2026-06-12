'use strict';
const { Router } = require('express');
const controller = require('./patient.controller');
const { authenticate } = require('../../middlewares/auth.middleware');
const { clinicGuard, authorize } = require('../../middlewares/role.middleware');

const router = Router();

// Require auth and clinic scoping for all endpoints
router.use(authenticate);
router.use(clinicGuard);

router.get(
  '/',
  authorize(
    'super_admin', 'clinic_owner', 'dentist', 'dental_assistant',
    'hygienist', 'front_desk', 'billing_staff', 'lab_coordinator'
  ),
  controller.list
);

router.get(
  '/:id',
  authorize(
    'super_admin', 'clinic_owner', 'dentist', 'dental_assistant',
    'hygienist', 'front_desk', 'billing_staff', 'lab_coordinator', 'patient'
  ),
  controller.get
);

router.post(
  '/',
  authorize('super_admin', 'clinic_owner', 'dentist', 'dental_assistant', 'front_desk'),
  controller.create
);

router.put(
  '/:id',
  authorize('super_admin', 'clinic_owner', 'dentist', 'dental_assistant', 'front_desk'),
  controller.update
);

router.delete(
  '/:id',
  authorize('super_admin', 'clinic_owner', 'front_desk'),
  controller.remove
);

module.exports = router;
