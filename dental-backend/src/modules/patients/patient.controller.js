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

const updateOdontogram = async (req, res, next) => {
  try {
    const { id: patientId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const { chartData } = req.body;
    const result = await patientService.updateOdontogram({ patientId, clinicId, chartData });
    return success(res, result, 'Odontogram updated successfully');
  } catch (err) {
    next(err);
  }
};

const createTreatmentPlan = async (req, res, next) => {
  try {
    const { id: patientId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const { tooth, procedure, cost, status } = req.body;
    const result = await patientService.createTreatmentPlan({ patientId, clinicId, tooth, procedure, cost, status });
    return success(res, result, 'Treatment plan created successfully', 201);
  } catch (err) {
    next(err);
  }
};

const updateTreatmentPlan = async (req, res, next) => {
  try {
    const { planId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const { status } = req.body;
    const result = await patientService.updateTreatmentPlan({ planId, clinicId, status });
    return success(res, result, 'Treatment plan updated successfully');
  } catch (err) {
    next(err);
  }
};

const deleteTreatmentPlan = async (req, res, next) => {
  try {
    const { planId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const result = await patientService.deleteTreatmentPlan({ planId, clinicId });
    return success(res, result, 'Treatment plan deleted successfully');
  } catch (err) {
    next(err);
  }
};

const createPrescription = async (req, res, next) => {
  try {
    const { id: patientId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const { drug, dosage, frequency, duration } = req.body;
    const result = await patientService.createPrescription({ patientId, clinicId, drug, dosage, frequency, duration });
    return success(res, result, 'Prescription created successfully', 201);
  } catch (err) {
    next(err);
  }
};

const deletePrescription = async (req, res, next) => {
  try {
    const { rxId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const result = await patientService.deletePrescription({ rxId, clinicId });
    return success(res, result, 'Prescription deleted successfully');
  } catch (err) {
    next(err);
  }
};

const createClinicalNote = async (req, res, next) => {
  try {
    const { id: patientId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const { content } = req.body;
    const authorId = req.user.id;
    const result = await patientService.createClinicalNote({ patientId, clinicId, content, authorId });
    return success(res, result, 'Clinical note created successfully', 201);
  } catch (err) {
    next(err);
  }
};

const createXray = async (req, res, next) => {
  try {
    const { id: patientId } = req.params;
    const clinicId = req.clinicId || req.user.clinicId;
    const { name, notes, isScanned, aiReport, fileUrl } = req.body;
    const result = await patientService.createXray({ patientId, clinicId, name, notes, isScanned, aiReport, fileUrl });
    return success(res, result, 'X-ray record added successfully', 201);
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
  updateOdontogram,
  createTreatmentPlan,
  updateTreatmentPlan,
  deleteTreatmentPlan,
  createPrescription,
  deletePrescription,
  createClinicalNote,
  createXray
};
