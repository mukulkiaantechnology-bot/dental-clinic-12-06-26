'use strict';
const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Starting database seed...');

  // ─── CLEANUP ──────────────────────────────────────────────────────────────
  await prisma.subscription.deleteMany();
  await prisma.plan.deleteMany();
  await prisma.crownCase.deleteMany();
  await prisma.implantCase.deleteMany();
  await prisma.labCase.deleteMany();
  await prisma.odontogram.deleteMany();
  await prisma.treatmentPlan.deleteMany();
  await prisma.xrayFile.deleteMany();
  await prisma.prescription.deleteMany();
  await prisma.clinicalNote.deleteMany();
  await prisma.invoice.deleteMany();
  await prisma.appointment.deleteMany();
  await prisma.patient.deleteMany();
  await prisma.refreshToken.deleteMany();
  await prisma.aiLog.deleteMany();
  await prisma.saasInvoice.deleteMany();
  await prisma.auditLog.deleteMany();
  await prisma.alert.deleteMany();
  await prisma.user.deleteMany();
  await prisma.clinic.deleteMany();

  console.log('🗑️  Cleared existing records');

  // ─── PLANS ─────────────────────────────────────────────────────────────────
  const basicPlan = await prisma.plan.create({
    data: {
      id: 'plan-basic',
      name: 'Basic',
      price: 99.00,
      features: ['Core HMS', 'Basic Reports'],
      maxClinics: 1,
      maxUsers: 5,
      maxPatients: 50
    }
  });

  const proPlan = await prisma.plan.create({
    data: {
      id: 'plan-pro',
      name: 'Pro',
      price: 299.00,
      features: ['Core HMS', 'Extended Reports', 'AI Copilot Widget'],
      maxClinics: 1,
      maxUsers: 15,
      maxPatients: 500
    }
  });

  const enterprisePlan = await prisma.plan.create({
    data: {
      id: 'plan-enterprise',
      name: 'Enterprise',
      price: 499.00,
      features: ['Core HMS', 'Unlimited Reports', 'AI Copilot Widget', 'AI Recall SMS Campaigns'],
      maxClinics: 1,
      maxUsers: 9999,
      maxPatients: 99999
    }
  });

  console.log('Plan options seeded');

  // ─── CLINICS ───────────────────────────────────────────────────────────────
  const clinic1 = await prisma.clinic.create({
    data: {
      id: 'clinic-1',
      name: 'Metropolitan Dental Care',
      location: 'Downtown Seattle, WA',
      phone: '(206) 555-0192',
      status: 'Active',
      plan: 'Enterprise',
      monthlyFee: 499.0,
      performanceScore: 94,
      aiModules: { diagnostic: true, recallSMS: true, workload: true },
    },
  });

  const clinic2 = await prisma.clinic.create({
    data: {
      id: 'clinic-2',
      name: 'Apex Orthodontics & Pediatrics',
      location: 'Bellevue, WA',
      phone: '(425) 555-0143',
      status: 'Active',
      plan: 'Premium',
      monthlyFee: 299.0,
      performanceScore: 89,
      aiModules: { diagnostic: true, recallSMS: true, workload: false },
    },
  });

  const clinic3 = await prisma.clinic.create({
    data: {
      id: 'clinic-3',
      name: 'Northside Family Dentistry',
      location: 'Everett, WA',
      phone: '(425) 555-0187',
      status: 'Active',
      plan: 'Basic',
      monthlyFee: 149.0,
      performanceScore: 81,
      aiModules: { diagnostic: false, recallSMS: false, workload: false },
    },
  });

  const clinic4 = await prisma.clinic.create({
    data: {
      id: 'clinic-4',
      name: 'Westside Pediatric Dental',
      location: 'Tacoma, WA',
      phone: '(253) 555-0210',
      status: 'Suspended',
      plan: 'Trial',
      monthlyFee: 0.0,
      performanceScore: 78,
      aiModules: { diagnostic: true, recallSMS: false, workload: false },
    },
  });

  console.log('✅ 4 Clinics created');

  // ─── SUBSCRIPTIONS ─────────────────────────────────────────────────────────
  await prisma.subscription.create({
    data: {
      clinicId: 'clinic-1',
      planId: 'plan-enterprise',
      status: 'active',
      startDate: new Date('2026-05-01')
    }
  });

  await prisma.subscription.create({
    data: {
      clinicId: 'clinic-2',
      planId: 'plan-pro',
      status: 'active',
      startDate: new Date('2026-05-01')
    }
  });

  await prisma.subscription.create({
    data: {
      clinicId: 'clinic-3',
      planId: 'plan-basic',
      status: 'active',
      startDate: new Date('2026-05-01')
    }
  });

  await prisma.subscription.create({
    data: {
      clinicId: 'clinic-4',
      planId: 'plan-basic',
      status: 'inactive',
      startDate: new Date('2026-05-01')
    }
  });

  console.log('Subscriptions seeded');

  const hashedPassword = await bcrypt.hash('123456', 10);

  // ─── USERS ────────────────────────────────────────────────────────────────
  const superAdmin = await prisma.user.create({
    data: {
      id: 'usr-superadmin',
      name: 'Sarah Jenkins',
      email: 'superadmin@gmail.com',
      password: hashedPassword,
      role: 'super_admin',
      status: 'Approved',
      clinicId: null,
    },
  });

  const clinicOwner = await prisma.user.create({
    data: {
      id: 'usr-clinicowner',
      name: 'Dr. Arthur Vance',
      email: 'clinicowner@gmail.com',
      password: hashedPassword,
      role: 'clinic_owner',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const dentist = await prisma.user.create({
    data: {
      id: 'usr-dentist',
      name: 'Dr. Michael Chen, DDS',
      email: 'dentist@gmail.com',
      password: hashedPassword,
      role: 'dentist',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const assistant = await prisma.user.create({
    data: {
      id: 'usr-assistant',
      name: 'David Miller',
      email: 'assistant@gmail.com',
      password: hashedPassword,
      role: 'dental_assistant',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const hygienist = await prisma.user.create({
    data: {
      id: 'usr-hygienist',
      name: 'Elena Rostova, RDH',
      email: 'hygienist@gmail.com',
      password: hashedPassword,
      role: 'hygienist',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const frontDesk = await prisma.user.create({
    data: {
      id: 'usr-frontdesk',
      name: 'Amara Lopez',
      email: 'frontdesk@gmail.com',
      password: hashedPassword,
      role: 'front_desk',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const billingStaff = await prisma.user.create({
    data: {
      id: 'usr-billing',
      name: 'Samantha Billing',
      email: 'billingstaff@gmail.com',
      password: hashedPassword,
      role: 'billing_staff',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const labCoordinator = await prisma.user.create({
    data: {
      id: 'usr-lab',
      name: 'Marcus Vance',
      email: 'labcoordinator@gmail.com',
      password: hashedPassword,
      role: 'lab_coordinator',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  const patientUser = await prisma.user.create({
    data: {
      id: 'usr-patient',
      name: 'James Carter',
      email: 'patient@gmail.com',
      password: hashedPassword,
      role: 'patient',
      status: 'Approved',
      clinicId: 'clinic-1',
    },
  });

  // Additional mock users for other clinics so they match frontend superAdminStore expectations
  await prisma.user.create({
    data: {
      id: 'usr-owner-clinic-3',
      name: 'Dr. Rajesh Sharma',
      email: 'rajesh@sharmadental.com',
      password: hashedPassword,
      role: 'clinic_owner',
      status: 'Pending_Approval',
      clinicId: 'clinic-3',
    },
  });

  await prisma.user.create({
    data: {
      id: 'usr-owner-clinic-4',
      name: 'Dr. Jane Miller',
      email: 'jane.miller@millerdental.com',
      password: hashedPassword,
      role: 'clinic_owner',
      status: 'Suspended',
      clinicId: 'clinic-4',
    },
  });

  console.log('✅ Users seeded');

  // ─── PATIENTS ─────────────────────────────────────────────────────────────
  const patient1 = await prisma.patient.create({
    data: {
      id: 'pat-1',
      clinicId: 'clinic-1',
      userId: 'usr-patient',
      name: 'James Carter',
      age: 45,
      gender: 'Male',
      phone: '(206) 555-1212',
      email: 'patient@gmail.com',
      status: 'Active',
      vitals: 'BP: 120/80, Temp: 98.6 F, Pulse: 72 bpm',
      allergies: 'Penicillin',
      insuranceProvider: 'MetLife Dental',
      address: '123 Pine St, Seattle, WA',
      history: 'No systemic diseases. High hygiene compliance. Mild bruxism.',
    },
  });

  const patient2 = await prisma.patient.create({
    data: {
      id: 'pat-2',
      clinicId: 'clinic-1',
      name: 'Mary Watson',
      age: 34,
      gender: 'Female',
      phone: '(206) 555-8989',
      email: 'mary.watson@gmail.com',
      status: 'Active',
      vitals: 'BP: 118/75, Temp: 98.2 F, Pulse: 68 bpm',
      allergies: 'Latex',
      insuranceProvider: 'Delta Dental',
      address: '456 Oak St, Seattle, WA',
      history: 'Prefers local sedation. Mild gingivitis reported in lower mandibular segment.',
    },
  });

  await prisma.patient.create({
    data: {
      id: 'pat-3',
      clinicId: 'clinic-1',
      name: 'Alex Johnson',
      age: 29,
      gender: 'Male',
      phone: '(206) 555-4343',
      email: 'alex.j@gmail.com',
      status: 'Inactive',
      vitals: 'BP: 130/85, Temp: 98.9 F, Pulse: 80 bpm',
      allergies: '',
      insuranceProvider: 'Cigna',
      address: '789 Maple Ave, Bellevue, WA',
      history: 'Bruxism. Wears custom night guard. History of orthodontic alignment (2022).',
    },
  });

  await prisma.patient.create({
    data: {
      id: 'pat-4',
      clinicId: 'clinic-1',
      name: 'Sarah Jenkins',
      age: 38,
      gender: 'Female',
      phone: '(206) 555-7788',
      email: 's.jenkins@hms-saas.com',
      status: 'Active',
      vitals: 'BP: 115/70, Temp: 98.4 F',
      allergies: '',
      insuranceProvider: 'Guardian Dental',
      address: '101 Broadway, Seattle, WA',
      history: 'Standard comprehensive review. Normal health chart.',
    },
  });

  await prisma.patient.create({
    data: {
      id: 'pat-5',
      clinicId: 'clinic-2',
      name: 'Robert Chen',
      age: 52,
      gender: 'Male',
      phone: '(425) 555-9012',
      email: 'robert@chen.org',
      status: 'Active',
      vitals: 'BP: 125/82, Temp: 98.7 F',
      allergies: 'Sulfa',
      insuranceProvider: 'Aetna PPO',
      address: '202 Bellevue Way, Bellevue, WA',
      history: 'Requires pre-medication before surgical procedures.',
    },
  });

  await prisma.patient.create({
    data: {
      id: 'pat-6',
      clinicId: 'clinic-2',
      name: 'Emily Davis',
      age: 26,
      gender: 'Female',
      phone: '(425) 555-3456',
      email: 'emily.d@gmail.com',
      status: 'Active',
      vitals: 'BP: 110/68, Temp: 98.1 F',
      allergies: '',
      insuranceProvider: 'None',
      address: '303 Red Wood Ave, Redmond, WA',
      history: 'Occasional teeth sensitivity. Brushes twice daily.',
    },
  });

  console.log('✅ 6 Patients created');

  // ─── APPOINTMENTS ─────────────────────────────────────────────────────────
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);

  await prisma.appointment.create({
    data: {
      id: 'apt-1',
      clinicId: 'clinic-1',
      patientId: 'pat-1',
      dentistId: 'usr-dentist',
      patientName: 'James Carter',
      dentistName: 'Dr. Michael Chen, DDS',
      hygienistName: 'Elena Rostova, RDH',
      date: today,
      time: '09:00',
      duration: 60,
      status: 'Checked_In',
      type: 'Cleaning',
      notes: 'Routine 6-month cleaning and exam',
      assignedTo: 'hygienist',
    },
  });

  await prisma.appointment.create({
    data: {
      id: 'apt-2',
      clinicId: 'clinic-1',
      patientId: 'pat-2',
      dentistId: 'usr-dentist',
      patientName: 'Mary Watson',
      dentistName: 'Dr. Michael Chen, DDS',
      date: today,
      time: '11:00',
      duration: 90,
      status: 'Scheduled',
      type: 'Root Canal',
      notes: 'Tooth #14 root canal procedure',
      assignedTo: 'dentist',
    },
  });

  await prisma.appointment.create({
    data: {
      id: 'apt-3',
      clinicId: 'clinic-1',
      patientId: 'pat-1',
      dentistId: 'usr-dentist',
      patientName: 'James Carter',
      dentistName: 'Dr. Michael Chen, DDS',
      date: tomorrow,
      time: '10:00',
      duration: 45,
      status: 'Scheduled',
      type: 'Teeth Cleaning',
      notes: 'Routine hygiene checkup',
      assignedTo: 'hygienist',
    },
  });

  console.log('✅ 3 appointments created');

  // ─── SAAS INVOICES ────────────────────────────────────────────────────────
  await prisma.saasInvoice.create({
    data: {
      id: 'sinv-101',
      clinicId: 'clinic-1',
      clinicName: 'Metropolitan Dental Care',
      amount: 499.00,
      issueDate: new Date('2026-06-01'),
      status: 'Paid',
      plan: 'Enterprise',
    },
  });

  await prisma.saasInvoice.create({
    data: {
      id: 'sinv-102',
      clinicId: 'clinic-2',
      clinicName: 'Apex Orthodontics & Pediatrics',
      amount: 299.00,
      issueDate: new Date('2026-06-01'),
      status: 'Paid',
      plan: 'Premium',
    },
  });

  await prisma.saasInvoice.create({
    data: {
      id: 'sinv-103',
      clinicId: 'clinic-3',
      clinicName: 'Northside Family Dentistry',
      amount: 149.00,
      issueDate: new Date('2026-06-01'),
      status: 'Unpaid',
      plan: 'Basic',
    },
  });

  await prisma.saasInvoice.create({
    data: {
      id: 'sinv-104',
      clinicId: 'clinic-4',
      clinicName: 'Westside Pediatric Dental',
      amount: 0.00,
      issueDate: new Date('2026-06-01'),
      status: 'Trial',
      plan: 'Trial',
    },
  });

  console.log('✅ SaaS Invoices seeded');

  // ─── AUDIT LOGS ───────────────────────────────────────────────────────────
  await prisma.auditLog.create({
    data: {
      id: 'log-1',
      userId: 'usr-superadmin',
      action: 'Upgraded Apex Orthodontics to Premium Plan',
      clinic: 'Apex Orthodontics & Pediatrics',
      timestamp: new Date('2026-06-08T09:12:00Z'),
    },
  });

  await prisma.auditLog.create({
    data: {
      id: 'log-2',
      userId: 'usr-superadmin',
      action: 'Enabled AI Diagnosis Module for Metropolitan Dental Care',
      clinic: 'Metropolitan Dental Care',
      timestamp: new Date('2026-06-08T08:45:00Z'),
    },
  });

  await prisma.auditLog.create({
    data: {
      id: 'log-3',
      userId: 'usr-superadmin',
      action: 'Registered new clinic location: Westside Pediatric Dental',
      clinic: 'Westside Pediatric Dental',
      timestamp: new Date('2026-06-07T14:20:00Z'),
    },
  });

  console.log('✅ Audit logs seeded');

  console.log('');
  console.log('🦷 ─────────────────────────────────────────────────');
  console.log('   Seed Complete! Login credentials:');
  console.log('   Super Admin  : superadmin@gmail.com / 123456');
  console.log('   Clinic Owner : clinicowner@gmail.com / 123456');
  console.log('   Dentist      : dentist@gmail.com / 123456');
  console.log('   Assistant    : assistant@gmail.com / 123456');
  console.log('   Hygienist    : hygienist@gmail.com / 123456');
  console.log('   Front Desk   : frontdesk@gmail.com / 123456');
  console.log('   Billing      : billingstaff@gmail.com / 123456');
  console.log('   Lab Coord.   : labcoordinator@gmail.com / 123456');
  console.log('   Patient      : patient@gmail.com / 123456');
  console.log('🦷 ─────────────────────────────────────────────────');
}

main()
  .catch((e) => {
    console.error('❌ Seed failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
