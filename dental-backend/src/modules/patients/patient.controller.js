'use strict';
const patientService = require('./patient.service');
const { success } = require('../../utils/response');

const list = async (req, res, next) => {
  try {
    const clinicId = req.clinicId || req.user.clinicId;
    const patients = await patientService.listPatients({ clinicId });
    return success(res, patients, 'Patients list fetched successfully');
  } catch (err) {
    next(err);
  }
};

const get = async (req, res, next) => {
  try {
    const { id } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const patient = await patientService.getPatientById({ id, clinicId });
    return success(res, patient, 'Patient details fetched successfully');
  } catch (err) {
    next(err);
  }
};

const create = async (req, res, next) => {
  try {
    const clinicId = req.clinicId || req.user.clinicId;
    const patient = await patientService.createPatient({ clinicId, body: req.body });
    return success(res, patient, 'Patient registered successfully', 201);
  } catch (err) {
    next(err);
  }
};

const update = async (req, res, next) => {
  try {
    const { id } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const patient = await patientService.updatePatient({ id, clinicId, body: req.body });
    return success(res, patient, 'Patient updated successfully');
  } catch (err) {
    next(err);
  }
};

const remove = async (req, res, next) => {
  try {
    const { id } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const result = await patientService.deletePatient({ id, clinicId });
    return success(res, result, 'Patient deleted successfully');
  } catch (err) {
    next(err);
  }
};

module.exports = {
  list,
  get,
  create,
  update,
  remove,
};
