-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2026 at 10:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dental_hms_saas`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_logs`
--

CREATE TABLE `ai_logs` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `userId` varchar(191) NOT NULL,
  `module` varchar(191) NOT NULL,
  `prompt` text NOT NULL,
  `response` longtext NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `userId` varchar(191) DEFAULT NULL,
  `role` enum('super_admin','clinic_owner','dentist','hygienist','front_desk','billing_staff','lab_coordinator','dental_assistant','patient') DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','warning','success','critical') NOT NULL DEFAULT 'info',
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alerts`
--

INSERT INTO `alerts` (`id`, `clinicId`, `userId`, `role`, `title`, `message`, `type`, `read`, `createdAt`) VALUES
('0203a544-d7eb-413d-b75d-fe747a41286b', 'clinic-1', NULL, 'front_desk', 'Patient In Preparation', 'Patient patient is with the assistant for intake and prep.', 'info', 1, '2026-06-15 12:01:05.927'),
('0ad3c2a3-939f-459d-bdf0-edbd60b18d1a', 'clinic-1', NULL, 'front_desk', 'Patient Checked In', 'Patient James Carter has checked in and is ready.', 'info', 1, '2026-06-15 07:47:23.055'),
('0e77ea97-e944-4683-a9b4-31327da9c2c2', 'clinic-1', NULL, 'billing_staff', 'Billing Triggered', 'Billing triggered for patient James Carter\'s completed treatment.', 'success', 0, '2026-06-15 13:09:14.597'),
('0f36ffbd-a550-414b-a517-0cd2a78685a0', 'clinic-1', '8e71a7be-a7a1-4ec9-8052-6abaf6d771a8', 'hygienist', 'Cleaning Appointment Assigned', 'A new cleaning appointment has been assigned to you for patient patient.', 'info', 0, '2026-06-15 11:27:09.949'),
('1651106f-0648-48a3-aff0-85772fcfb9d1', 'clinic-1', NULL, 'front_desk', 'New Appointment Scheduled', 'A new appointment has been scheduled for patient James Carter.', 'info', 1, '2026-06-15 13:06:56.283'),
('16b80c65-fc58-4fd9-9f04-ee0f25d73134', 'clinic-1', 'f9caeeaa-f47f-4c58-a365-65fd826b4d94', 'dental_assistant', 'Preparation Required', 'Preparation required for upcoming appointment with patient patient.', 'warning', 0, '2026-06-15 11:27:09.933'),
('1b85925a-74e3-45a4-9d5f-329310003e7e', 'clinic-1', NULL, 'front_desk', 'New Appointment Scheduled', 'A new appointment has been scheduled for patient patient.', 'info', 1, '2026-06-17 07:08:26.324'),
('1e0076a7-06fc-4cdc-9d07-0f2e30cf0449', 'clinic-1', NULL, 'hygienist', 'Patient With Assistant', 'Patient patient is currently with the assistant. Dentist treatment has not started yet.', 'info', 0, '2026-06-15 12:01:05.912'),
('2eb369a3-c437-426c-ae47-a4a37556e502', 'clinic-1', NULL, 'clinic_owner', 'Appointment Completed', 'Clinician completed the treatment session for patient.', 'success', 0, '2026-06-15 12:12:50.511'),
('36ffbd96-6083-4eb2-b51f-5426dbdfe445', 'clinic-1', NULL, 'clinic_owner', 'Appointment Completed', 'Clinician completed the treatment session for patient.', 'success', 0, '2026-06-17 07:09:36.072'),
('3909e736-4706-4333-9b8d-77dbf31bceba', 'clinic-1', NULL, 'hygienist', 'Dentist Treatment In Progress', 'Dentist is now treating patient James Carter. Hygiene cleaning will follow when ready.', 'info', 1, '2026-06-15 09:05:20.375'),
('3a05996b-e71d-4d81-a8a1-863ba032fa64', 'clinic-1', NULL, 'clinic_owner', 'Clinical Workflow Advanced', 'Appointment for James Carter advanced to IN PROGRESS.', 'info', 1, '2026-06-15 07:58:53.023'),
('3c631f6f-0d61-4c06-9bc9-3609c03000b4', 'clinic-1', 'usr-assistant', 'dental_assistant', 'Preparation Started', 'Patient James Carter is ready for chairside preparation.', 'warning', 0, '2026-06-15 13:07:37.398'),
('3eb0e120-f1ac-4847-bd23-3818a2244deb', 'clinic-1', NULL, 'front_desk', 'Patient In Treatment', 'Patient James Carter is now in treatment stage: IN PROGRESS.', 'info', 1, '2026-06-15 07:58:53.002'),
('44fc2dd8-43af-45d5-881a-6985f322a33e', 'clinic-1', NULL, 'billing_staff', 'Billing Triggered', 'Billing triggered for patient patient\'s completed treatment.', 'success', 0, '2026-06-17 07:09:36.055'),
('4a61a17d-fabc-48b1-b078-5d58ce82dee6', 'clinic-1', NULL, 'front_desk', 'Patient Checked In', 'Patient James Carter has checked in and is ready.', 'info', 1, '2026-06-15 13:07:23.798'),
('4e9631e8-2d2c-4596-b069-cd8fa4902de2', 'clinic-1', NULL, 'front_desk', 'New Appointment Scheduled', 'A new appointment has been scheduled for patient patient.', 'info', 1, '2026-06-15 11:27:09.905'),
('55fe3bc3-2fe1-448c-947c-e5ec87df548f', 'clinic-1', 'usr-assistant', 'dental_assistant', 'Preparation Required', 'Preparation required for upcoming appointment with patient patient.', 'warning', 0, '2026-06-17 07:08:26.358'),
('5885c6d9-fda6-4407-905e-1639d1ac6ad2', 'clinic-1', 'f9caeeaa-f47f-4c58-a365-65fd826b4d94', 'dental_assistant', 'Preparation Required', 'Patient patient has checked in. Seat preparation required.', 'warning', 0, '2026-06-15 11:35:14.875'),
('5b17819f-b13e-4935-835c-6a81967b8d3b', 'clinic-1', NULL, 'front_desk', 'Patient Checked In', 'Patient patient has checked in and is ready.', 'info', 1, '2026-06-17 07:08:28.580'),
('5ce524b3-7e40-42df-9a94-edae721755a9', 'clinic-1', NULL, 'front_desk', 'Patient In Preparation', 'Patient patient is with the assistant for intake and prep.', 'info', 0, '2026-06-17 07:08:43.840'),
('5def1d83-ddf6-48c8-9cb3-f939a85cdfe3', 'clinic-1', 'usr-dentist', 'dentist', 'Ready for Treatment', 'Patient patient has been assigned to you. Please begin clinical treatment.', 'warning', 0, '2026-06-17 07:09:34.061'),
('6f0ae61e-3a1f-493d-a026-8afb8efbf0a2', 'clinic-1', NULL, 'hygienist', 'Patient With Assistant', 'Patient James Carter is currently with the assistant. Dentist treatment has not started yet.', 'info', 0, '2026-06-15 13:07:37.386'),
('745aa5a9-3cdf-4de3-aac0-440e7d37acab', 'clinic-1', NULL, 'front_desk', 'Dentist Treatment Started', 'Patient James Carter is now with the dentist for treatment.', 'info', 1, '2026-06-15 09:05:20.385'),
('7809b0db-35b7-470d-858f-a0c2eff33a57', 'clinic-1', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', 'dentist', 'Patient With Assistant', 'Patient patient is now with the dental assistant for preparation.', 'info', 0, '2026-06-15 12:01:05.902'),
('8149652b-550d-45e2-8df2-1e16e5c6c5e4', 'clinic-1', 'f9caeeaa-f47f-4c58-a365-65fd826b4d94', 'dental_assistant', 'Preparation Started', 'Patient patient is ready for chairside preparation.', 'warning', 0, '2026-06-15 12:01:05.919'),
('82f865b5-6254-49fd-a0d7-f84570980d07', 'clinic-1', NULL, 'front_desk', 'Appointment Completed', 'Appointment for James Carter is completed.', 'success', 1, '2026-06-15 09:05:21.676'),
('83775956-0b33-4536-b145-cd8aa92fc233', 'clinic-1', 'usr-assistant', 'dental_assistant', 'Preparation Started', 'Patient patient is ready for chairside preparation.', 'warning', 0, '2026-06-17 07:08:43.835'),
('8bdf350b-ca7a-42dd-b72f-7e396083b99c', 'clinic-1', 'usr-assistant', 'dental_assistant', 'Preparation Required', 'Patient James Carter has checked in. Seat preparation required.', 'warning', 0, '2026-06-15 13:07:23.808'),
('8bf80afc-fea5-4123-9da6-8484132f6c04', 'clinic-1', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', 'dentist', 'Ready for Treatment', 'Patient patient has been assigned to you. Please begin clinical treatment.', 'warning', 1, '2026-06-15 12:12:49.158'),
('959efd45-2eb9-4774-bb8e-b610385ac464', 'clinic-1', NULL, 'hygienist', 'Dentist Treatment In Progress', 'Dentist is now treating patient patient. Hygiene cleaning will follow when ready.', 'info', 0, '2026-06-17 07:09:34.067'),
('98d58f6c-9736-41f1-a6d5-d8ef4518f3fd', 'clinic-1', NULL, 'front_desk', 'Appointment Completed', 'Appointment for patient is completed.', 'success', 0, '2026-06-17 07:09:36.051'),
('9dc69924-3764-41e0-9a86-d58cfef4e3a3', 'clinic-1', NULL, 'clinic_owner', 'Appointment Completed', 'Clinician completed the treatment session for James Carter.', 'success', 0, '2026-06-15 13:09:14.606'),
('9e39846e-1fc4-4afc-8757-b5cf3b0e12b5', 'clinic-1', 'usr-hygienist', 'hygienist', 'Cleaning Appointment Assigned', 'A new cleaning appointment has been assigned to you for patient patient.', 'info', 0, '2026-06-17 07:08:26.376'),
('9eb53a27-593e-4349-bf7f-1ef8f91efbca', 'clinic-1', NULL, 'front_desk', 'Dentist Treatment Started', 'Patient patient is now with the dentist for treatment.', 'info', 1, '2026-06-15 12:12:49.174'),
('9f76bc09-d133-43a6-97f7-901940c41f7e', 'clinic-1', 'usr-dentist', 'dentist', 'Patient With Assistant', 'Patient patient is now with the dental assistant for preparation.', 'info', 0, '2026-06-17 07:08:43.818'),
('a07e1fea-16ac-4b8e-9852-ab4dde7194bd', 'clinic-1', NULL, 'hygienist', 'Dentist Treatment In Progress', 'Dentist is now treating patient patient. Hygiene cleaning will follow when ready.', 'info', 0, '2026-06-15 12:12:49.162'),
('a73c581b-29c3-4ce0-882a-79b78f6394c3', 'clinic-1', NULL, 'hygienist', 'Patient With Assistant', 'Patient patient is currently with the assistant. Dentist treatment has not started yet.', 'info', 0, '2026-06-17 07:08:43.824'),
('aaf58f53-ee0c-44a2-9b13-461d375387ac', 'clinic-1', NULL, 'front_desk', 'Appointment Completed', 'Appointment for James Carter is completed.', 'success', 1, '2026-06-15 13:09:14.589'),
('b0267adf-390d-4128-8330-907f8eb748e3', 'clinic-1', 'usr-dentist', 'dentist', 'Patient With Assistant', 'Patient James Carter is now with the dental assistant for preparation.', 'info', 1, '2026-06-15 13:07:37.381'),
('b21776cd-37a7-4732-8968-ce1078c66636', 'clinic-1', NULL, 'front_desk', 'Dentist Treatment Started', 'Patient patient is now with the dentist for treatment.', 'info', 0, '2026-06-17 07:09:34.081'),
('b22b1ad1-ebab-4c36-a522-dc42364d5aba', 'clinic-1', NULL, 'super_admin', 'Plan Change Request: Enterprise', 'Clinic \"Metropolitan Dental Care\" has requested to upgrade/change their plan to Enterprise. Please review in Subscriptions Management.', 'info', 1, '2026-06-15 11:02:47.781'),
('be676a79-b040-42d1-ab54-909fdb5ee83a', 'clinic-1', 'usr-assistant', 'dental_assistant', 'Preparation Required', 'Patient patient has checked in. Seat preparation required.', 'warning', 0, '2026-06-17 07:08:28.585'),
('c06db4bf-75ac-457e-97b0-ddebcb64b01d', 'clinic-1', 'usr-dentist', 'dentist', 'New Patient Assigned', 'Patient James Carter has been assigned to you.', 'info', 0, '2026-06-15 13:06:56.304'),
('c30ea02f-2625-4468-8f1d-c6a9b0a0c1ba', 'clinic-1', 'usr-dentist', 'dentist', 'Ready for Treatment', 'Patient James Carter has been assigned to you. Please begin clinical treatment.', 'warning', 1, '2026-06-15 09:05:20.359'),
('c9b70b12-2efa-4b0d-8d45-38a5da234427', 'clinic-1', NULL, 'billing_staff', 'Billing Triggered', 'Billing triggered for patient patient\'s completed treatment.', 'success', 0, '2026-06-15 12:12:50.507'),
('c9b898b2-cf35-4293-9787-4271e6d1d451', 'clinic-1', NULL, 'front_desk', 'Appointment Completed', 'Appointment for patient is completed.', 'success', 1, '2026-06-15 12:12:50.495'),
('ca3b4f81-143a-4e13-8fbb-215a65c73fed', 'clinic-1', NULL, 'front_desk', 'Patient In Preparation', 'Patient James Carter is with the assistant for intake and prep.', 'info', 1, '2026-06-15 13:07:37.402'),
('cac99671-0ceb-417f-a58b-4ed282d21d39', 'clinic-1', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', 'dentist', 'New Patient Assigned', 'Patient patient has been assigned to you.', 'info', 0, '2026-06-15 11:27:09.918'),
('d6c923e5-3c51-4576-8f40-be170ff48697', 'clinic-1', NULL, 'front_desk', 'Patient Checked In', 'Patient patient has checked in and is ready.', 'info', 1, '2026-06-15 11:35:14.865'),
('d70543fd-87b2-4639-a304-bc9a29d9fdf3', 'clinic-1', 'usr-hygienist', 'hygienist', 'Cleaning Appointment Assigned', 'A new cleaning appointment has been assigned to you for patient James Carter.', 'info', 0, '2026-06-15 13:06:56.335'),
('dede594a-7974-4d7d-8505-3b36078763dc', 'clinic-1', NULL, 'clinic_owner', 'Appointment Completed', 'Clinician completed the treatment session for James Carter.', 'success', 1, '2026-06-15 09:05:21.690'),
('ee496c37-6ced-48f2-84dc-b6da332bc7fa', 'clinic-1', NULL, 'billing_staff', 'Billing Triggered', 'Billing triggered for patient James Carter\'s completed treatment.', 'success', 1, '2026-06-15 09:05:21.685'),
('eeb58ab4-1aa8-4bda-bc2d-4cc9b5ff22ea', 'clinic-1', 'usr-dentist', 'dentist', 'New Patient Assigned', 'Patient patient has been assigned to you.', 'info', 0, '2026-06-17 07:08:26.344'),
('faef86e2-726c-48c0-8da7-65bae99453e0', 'clinic-1', 'usr-assistant', 'dental_assistant', 'Preparation Required', 'Preparation required for upcoming appointment with patient James Carter.', 'warning', 0, '2026-06-15 13:06:56.317');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `dentistId` varchar(191) DEFAULT NULL,
  `patientName` varchar(191) NOT NULL,
  `dentistName` varchar(191) NOT NULL,
  `hygienistName` varchar(191) DEFAULT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 60,
  `status` enum('Scheduled','Checked_In','In_Progress','Ready_For_Doctor','Completed','Cancelled','No_Show') NOT NULL DEFAULT 'Scheduled',
  `type` varchar(191) NOT NULL,
  `notes` text DEFAULT NULL,
  `assignedTo` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `assignedAssistantId` varchar(191) DEFAULT NULL,
  `assignedDoctorId` varchar(191) DEFAULT NULL,
  `assignedHygienistId` varchar(191) DEFAULT NULL,
  `workflowStage` enum('SCHEDULED','CONFIRMED','CHECKED_IN','IN_PROGRESS','CLEANING_PENDING','TREATMENT_PENDING','COMPLETED','CANCELLED') NOT NULL DEFAULT 'SCHEDULED'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `clinicId`, `patientId`, `dentistId`, `patientName`, `dentistName`, `hygienistName`, `date`, `time`, `duration`, `status`, `type`, `notes`, `assignedTo`, `createdAt`, `updatedAt`, `assignedAssistantId`, `assignedDoctorId`, `assignedHygienistId`, `workflowStage`) VALUES
('024ae01b-f2aa-4a36-854b-72bee8ded186', 'clinic-1', 'pat-1', 'usr-dentist', 'James Carter', 'Dr. Michael Chen, DDS', 'Elena Rostova, RDH', '2026-06-15', '09:00', 45, 'Completed', 'Teeth Cleaning', 'xz', 'dentist', '2026-06-15 13:06:56.219', '2026-06-15 13:09:14.565', 'usr-assistant', 'usr-dentist', 'usr-hygienist', 'COMPLETED'),
('445e8fd5-0b58-4e60-aa55-3ee4cd6ea179', 'clinic-1', 'pat-1', NULL, 'James Carter', 'Dr. Michael Chen', NULL, '2026-06-17', '10:00 AM', 45, 'Scheduled', 'General Checkup', 'Patient requested a general cleaning and checkup.', NULL, '2026-06-15 13:38:37.073', '2026-06-15 13:38:37.073', NULL, NULL, NULL, 'SCHEDULED'),
('7ffed91a-c948-4ee6-9d09-3024b3f00f8c', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', 'patient', 'dentist', 'hygienist', '2026-06-15', '09:00', 45, 'Completed', 'Crown', 'rgtedg', 'dentist', '2026-06-15 11:27:09.869', '2026-06-15 12:12:50.484', 'f9caeeaa-f47f-4c58-a365-65fd826b4d94', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', '8e71a7be-a7a1-4ec9-8052-6abaf6d771a8', 'COMPLETED'),
('e949aeb8-8b5f-4939-bdb4-6b08aff88f03', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'usr-dentist', 'patient', 'Dr. Michael Chen, DDS', 'Elena Rostova, RDH', '2026-06-17', '09:00', 45, 'Completed', 'Filling', 'fgsdfg', 'dentist', '2026-06-17 07:08:26.271', '2026-06-17 07:09:36.035', 'usr-assistant', 'usr-dentist', 'usr-hygienist', 'COMPLETED');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) DEFAULT NULL,
  `userId` varchar(191) NOT NULL,
  `action` text NOT NULL,
  `clinic` varchar(191) DEFAULT NULL,
  `timestamp` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `clinicId`, `userId`, `action`, `clinic`, `timestamp`, `createdAt`) VALUES
('1d34c493-419f-452f-a259-4b1c439d7529', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-15 09:49:45.737', '2026-06-15 09:49:45.739'),
('1f2876ce-30c3-4374-a940-de191a215ba7', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-15 09:49:44.496', '2026-06-15 09:49:44.498'),
('1f49d5ff-9239-4772-a492-ad1e63c9d15e', NULL, 'usr-superadmin', 'Updated details for clinic location: Apex Orthodontics & Pediatrics', 'Apex Orthodontics & Pediatrics', '2026-06-15 10:49:56.127', '2026-06-15 10:49:56.129'),
('34f777c3-d9bb-42e2-96b3-a76393446895', NULL, 'usr-superadmin', 'Updated SaaS Pricing Plan configuration: trial', 'Global', '2026-06-15 10:44:19.799', '2026-06-15 10:44:19.800'),
('36ebb49e-3964-47e9-bd2e-4c9bca8fa738', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-15 09:49:44.991', '2026-06-15 09:49:44.992'),
('38df4f4b-7fd9-4e3a-99a6-d6d534169800', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-15 10:02:42.305', '2026-06-15 10:02:42.306'),
('44c87f50-89e9-48e2-92d4-62764ce183e8', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Westside Pediatric Dental', 'Westside Pediatric Dental', '2026-06-17 06:59:06.663', '2026-06-17 06:59:06.664'),
('541451b0-03a7-4d9f-9fe0-7fa83ca5b98f', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-15 10:02:45.515', '2026-06-15 10:02:45.517'),
('5b546a3c-e7e5-4f6c-8d05-2b22d9a24b26', NULL, 'usr-superadmin', 'Created new SaaS Pricing Plan: trial ($0/mo)', 'Global', '2026-06-15 10:44:04.126', '2026-06-15 10:44:04.131'),
('5fd48f01-a1f4-45fb-a936-4e21935f6a4a', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-15 10:02:42.957', '2026-06-15 10:02:42.958'),
('673d7cee-4e0f-490c-af1d-f83cfde0bc17', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-15 11:09:09.371', '2026-06-15 11:09:09.373'),
('adb13bee-4f40-4164-8907-f4d7e74df641', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-17 06:58:46.608', '2026-06-17 06:58:46.610'),
('bcdc1449-2df5-4934-aa8a-7537862e0aac', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Westside Pediatric Dental', 'Westside Pediatric Dental', '2026-06-17 06:58:57.239', '2026-06-17 06:58:57.241'),
('c348bf73-2a65-4f21-be38-c0fcbce24baa', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-15 10:02:46.188', '2026-06-15 10:02:46.189'),
('cff91061-93f6-4deb-8bb2-d4135f6c3a87', NULL, 'usr-superadmin', 'Registered new platform user: apex as clinic_owner for Apex Orthodontics & Pediatrics', 'Apex Orthodontics & Pediatrics', '2026-06-15 10:50:18.883', '2026-06-15 10:50:18.885'),
('d01edb87-ff89-4e04-845c-15d5cc832d22', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-17 06:58:43.976', '2026-06-17 06:58:43.979'),
('d875527a-01d3-46e2-8e91-4c9557b32bcd', NULL, 'usr-clinicowner', 'Modified permissions/details for user: Dr. Arthur Vance', 'Apex Orthodontics & Pediatrics', '2026-06-15 10:52:29.386', '2026-06-15 10:52:29.387'),
('e8306c3f-e7a3-4fa9-b561-71b913f5ba18', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-15 11:09:08.928', '2026-06-15 11:09:08.930'),
('ef67a346-eb65-45de-8bdd-cc2ad60e75fb', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-17 06:59:46.060', '2026-06-17 06:59:46.062'),
('fb8e94d9-18ca-4f91-bc6b-f74de39abe04', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-17 07:00:11.526', '2026-06-17 07:00:11.528'),
('log-1', NULL, 'usr-superadmin', 'Upgraded Apex Orthodontics to Premium Plan', 'Apex Orthodontics & Pediatrics', '2026-06-08 09:12:00.000', '2026-06-15 07:41:22.990'),
('log-2', NULL, 'usr-superadmin', 'Enabled AI Diagnosis Module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-08 08:45:00.000', '2026-06-15 07:41:22.996'),
('log-3', NULL, 'usr-superadmin', 'Registered new clinic location: Westside Pediatric Dental', 'Westside Pediatric Dental', '2026-06-07 14:20:00.000', '2026-06-15 07:41:23.006');

-- --------------------------------------------------------

--
-- Table structure for table `chairside_sessions`
--

CREATE TABLE `chairside_sessions` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `appointmentId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `tasks` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tasks`)),
  `activeStage` varchar(191) NOT NULL DEFAULT 'Prep',
  `timerSeconds` int(11) NOT NULL DEFAULT 0,
  `timerRunning` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chairside_sessions`
--

INSERT INTO `chairside_sessions` (`id`, `clinicId`, `appointmentId`, `patientId`, `tasks`, `activeStage`, `timerSeconds`, `timerRunning`, `createdAt`, `updatedAt`) VALUES
('6afb4d62-2ac6-4926-bc78-0708421b08df', 'clinic-1', 'e949aeb8-8b5f-4939-bdb4-6b08aff88f03', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '[{\"id\":\"ster-1\",\"category\":\"Sterilization\",\"text\":\"Sanitize and prep treatment chair\",\"completed\":true},{\"id\":\"ster-2\",\"category\":\"Sterilization\",\"text\":\"Autoclave dental mirrors and explorers\",\"completed\":true},{\"id\":\"ster-3\",\"category\":\"Sterilization\",\"text\":\"Place protective barriers on handles and switches\",\"completed\":true},{\"id\":\"ster-4\",\"category\":\"Sterilization\",\"text\":\"Dispose of biohazard waste from previous session\",\"completed\":true},{\"id\":\"inst-1\",\"category\":\"Instrument\",\"text\":\"Confirm high-speed handpiece is clean and tracked\",\"completed\":false},{\"id\":\"inst-2\",\"category\":\"Instrument\",\"text\":\"Set up high-volume evacuator (suction) tips\",\"completed\":true},{\"id\":\"inst-3\",\"category\":\"Instrument\",\"text\":\"Lay out composite restorative materials and curing light\",\"completed\":true},{\"id\":\"inst-4\",\"category\":\"Instrument\",\"text\":\"Prepare articulating paper and polishing burs\",\"completed\":true},{\"id\":\"stage-1\",\"category\":\"Stage\",\"text\":\"Review patient medical history & vitals\",\"completed\":true},{\"id\":\"stage-2\",\"category\":\"Stage\",\"text\":\"Assist dentist during procedure\",\"completed\":true},{\"id\":\"stage-3\",\"category\":\"Stage\",\"text\":\"Review post-op care instructions with patient\",\"completed\":false}]', 'Assist', 5, 0, '2026-06-17 07:08:44.487', '2026-06-17 07:09:43.004'),
('6db64af1-a0c7-4f52-b84b-ac675ce5e8c3', 'clinic-1', '7ffed91a-c948-4ee6-9d09-3024b3f00f8c', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '[{\"id\":\"ster-1\",\"category\":\"Sterilization\",\"text\":\"Sanitize and prep treatment chair\",\"completed\":true},{\"id\":\"ster-2\",\"category\":\"Sterilization\",\"text\":\"Autoclave dental mirrors and explorers\",\"completed\":true},{\"id\":\"ster-3\",\"category\":\"Sterilization\",\"text\":\"Place protective barriers on handles and switches\",\"completed\":true},{\"id\":\"ster-4\",\"category\":\"Sterilization\",\"text\":\"Dispose of biohazard waste from previous session\",\"completed\":true},{\"id\":\"inst-1\",\"category\":\"Instrument\",\"text\":\"Confirm high-speed handpiece is clean and tracked\",\"completed\":true},{\"id\":\"inst-2\",\"category\":\"Instrument\",\"text\":\"Set up high-volume evacuator (suction) tips\",\"completed\":true},{\"id\":\"inst-3\",\"category\":\"Instrument\",\"text\":\"Lay out composite restorative materials and curing light\",\"completed\":true},{\"id\":\"inst-4\",\"category\":\"Instrument\",\"text\":\"Prepare articulating paper and polishing burs\",\"completed\":true},{\"id\":\"stage-1\",\"category\":\"Stage\",\"text\":\"Review patient medical history & vitals\",\"completed\":false},{\"id\":\"stage-2\",\"category\":\"Stage\",\"text\":\"Assist dentist during procedure\",\"completed\":false},{\"id\":\"stage-3\",\"category\":\"Stage\",\"text\":\"Review post-op care instructions with patient\",\"completed\":false}]', 'Assist', 4, 0, '2026-06-15 11:35:38.349', '2026-06-15 12:31:47.931'),
('fd5fc7b0-9c0e-4959-9e88-0dba7a800bff', 'clinic-1', '024ae01b-f2aa-4a36-854b-72bee8ded186', 'pat-1', '[{\"id\":\"ster-1\",\"category\":\"Sterilization\",\"text\":\"Sanitize and prep treatment chair\",\"completed\":true},{\"id\":\"ster-2\",\"category\":\"Sterilization\",\"text\":\"Autoclave dental mirrors and explorers\",\"completed\":true},{\"id\":\"ster-3\",\"category\":\"Sterilization\",\"text\":\"Place protective barriers on handles and switches\",\"completed\":true},{\"id\":\"ster-4\",\"category\":\"Sterilization\",\"text\":\"Dispose of biohazard waste from previous session\",\"completed\":true},{\"id\":\"inst-1\",\"category\":\"Instrument\",\"text\":\"Confirm high-speed handpiece is clean and tracked\",\"completed\":true},{\"id\":\"inst-2\",\"category\":\"Instrument\",\"text\":\"Set up high-volume evacuator (suction) tips\",\"completed\":true},{\"id\":\"inst-3\",\"category\":\"Instrument\",\"text\":\"Lay out composite restorative materials and curing light\",\"completed\":true},{\"id\":\"inst-4\",\"category\":\"Instrument\",\"text\":\"Prepare articulating paper and polishing burs\",\"completed\":true},{\"id\":\"stage-1\",\"category\":\"Stage\",\"text\":\"Review patient medical history & vitals\",\"completed\":false},{\"id\":\"stage-2\",\"category\":\"Stage\",\"text\":\"Assist dentist during procedure\",\"completed\":true},{\"id\":\"stage-3\",\"category\":\"Stage\",\"text\":\"Review post-op care instructions with patient\",\"completed\":false}]', 'Prep', 3, 0, '2026-06-15 13:08:10.258', '2026-06-17 06:52:15.456');

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `invoiceId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `carrier` varchar(191) NOT NULL,
  `claimAmount` double NOT NULL,
  `approvedAmount` double NOT NULL DEFAULT 0,
  `submittedDate` date NOT NULL,
  `status` varchar(191) NOT NULL,
  `note` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `clinicId`, `invoiceId`, `patientName`, `carrier`, `claimAmount`, `approvedAmount`, `submittedDate`, `status`, `note`, `createdAt`) VALUES
('clm-001', 'clinic-1', 'inv-1001', 'James Carter', 'Blue Cross Blue Shield', 120, 120, '2026-05-14', 'Approved', 'Full claim approved for preventive services', '2026-06-15 07:41:23.113'),
('clm-002', 'clinic-1', 'inv-1002', 'Mary Watson', 'Aetna', 900, 800, '2026-05-20', 'Approved', 'Partial approval — deductible applied', '2026-06-15 07:41:23.118'),
('clm-003', 'clinic-1', 'inv-1003', 'Alex Johnson', 'Cigna', 2000, 0, '2026-06-01', 'Pending', 'Orthodontic pre-authorization pending', '2026-06-15 07:41:23.123'),
('clm-1781529388404', 'clinic-1', 'inv-1781516550013', 'James Carter', 'sdfgsdf', 100, 100, '2026-06-15', 'Approved', 'sdfgsdf', '2026-06-15 13:16:28.406');

-- --------------------------------------------------------

--
-- Table structure for table `clinical_notes`
--

CREATE TABLE `clinical_notes` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `content` longtext NOT NULL,
  `authorId` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clinical_notes`
--

INSERT INTO `clinical_notes` (`id`, `clinicId`, `patientId`, `content`, `authorId`, `createdAt`, `updatedAt`) VALUES
('1262b85b-8e65-4dc2-ac70-6bdfc65ed428', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '[Assistant Prep Note]\nProcedure: Crown\nObservations: Pre-procedural chlorhexidine rinse administered. Conducted intake and vitals audit. Assisted dentist during scaling and fine paste prophy polishing. Flossed. Pt advised on interproximal cleaning.\nActions Taken: Sterilization completed, Instruments prepped, Patient post-op briefing\n\n[TGYHETFGH]\nrtfgsrg', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', '2026-06-15 12:15:28.555', '2026-06-15 12:15:28.555'),
('27458a41-99a8-4bfc-8db8-fe37fbaa9755', 'clinic-1', 'pat-1', 'Medical History: Reviewed. Vitals: Normal.\nTreatment:\n- Conducted complete 6-point perio charting.\n- Localized root scaling on pocketed posterior teeth.\n- Subgingival irrigation with Chlorhexidine rinse.\n- Selective rubber cup polishing.\n- Flossed.\nOral Hygiene Instructions: Electric toothbrush usage reviewed. Re-evaluate perio status in 3 months.', 'usr-hygienist', '2026-06-15 09:41:12.399', '2026-06-15 09:41:12.399'),
('29a4fe3d-e896-42c2-9d54-3e388e9ee262', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'Medical History: Reviewed. Vitals: Normal. Patient compliant.\nTreatment:\n- Pre-procedural 0.12% Chlorhexidine rinse.\n- Supra & subgingival scaling using ultrasonic scaler & hand scaling.\n- Stain removal using polishing paste.\n- Interdental flossing completed.\n- 5.0% Sodium Fluoride varnish applied.\nOral Hygiene Instructions: Daily flossing emphasized. Return in 6 months.', '8e71a7be-a7a1-4ec9-8052-6abaf6d771a8', '2026-06-15 12:31:05.958', '2026-06-15 12:31:05.958'),
('413b870e-7da9-4e97-9363-51b3208ec7c6', 'clinic-1', 'pat-1', 'Medical History: Reviewed. Vitals: Normal.\nTreatment:\n- Localized anesthesia administered (1 carpule 2% Lidocaine w/ 1:100k epi).\n- Scaling and root planing (SRP) completed in lower left quadrant.\n- Removal of heavy subgingival calculus deposits.\n- Post-op instructions given. Warned patient of minor sensitivity.\nOral Hygiene Instructions: Warm salt water rinse, soft brush for 48 hours.', 'usr-hygienist', '2026-06-15 13:10:05.526', '2026-06-15 13:10:05.526'),
('54a05477-47fb-4584-a2b1-ec49f9a4cdb9', 'clinic-1', 'pat-1', '[Assistant Prep Note]\nProcedure: Cleaning\nObservations: Assisted in local anesthesia administration (Lidocaine block). Maintained high-volume suction and tongue/cheek retraction during extraction. Monitored vital signs. Placed sterile gauze post-op.\nActions Taken: Sterilization completed, Instruments prepped', 'usr-assistant', '2026-06-15 09:18:38.148', '2026-06-15 09:18:38.148'),
('554347c4-6a84-4fcb-8e95-b0ece992b403', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'Medical History: Reviewed. Vitals: Normal. Patient compliant.\nTreatment:\n- Pre-procedural 0.12% Chlorhexidine rinse.\n- Supra & subgingival scaling using ultrasonic scaler & hand scaling.\n- Stain removal using polishing paste.\n- Interdental flossing completed.\n- 5.0% Sodium Fluoride varnish applied.\nOral Hygiene Instructions: Daily flossing emphasized. Return in 6 months.', 'usr-hygienist', '2026-06-17 07:10:45.891', '2026-06-17 07:10:45.891'),
('6a8b45c2-5c14-4685-b36f-9ad00a36770e', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '[Assistant Prep Note]\nProcedure: Filling\nObservations: Assisted in local anesthesia administration (Lidocaine block). Maintained high-volume suction and tongue/cheek retraction during extraction. Monitored vital signs. Placed sterile gauze post-op.\nActions Taken: Sterilization completed, Instruments prepped, Patient post-op briefing', 'usr-assistant', '2026-06-17 07:09:23.911', '2026-06-17 07:09:23.911'),
('6e0de292-1d12-49c0-9ea8-6fdb72551ab6', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '[Assistant Prep Note]\nProcedure: Crown\nObservations: Pre-procedural chlorhexidine rinse administered. Conducted intake and vitals audit. Assisted dentist during scaling and fine paste prophy polishing. Flossed. Pt advised on interproximal cleaning.\nActions Taken: Sterilization completed, Instruments prepped, Patient post-op briefing\n\n[TGYHETFGH]\nrtfgsrg\n\n[TGYHETFGH]\nrtfgsrg', 'd1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', '2026-06-15 12:15:34.007', '2026-06-15 12:15:34.007'),
('717fd9e4-8890-4188-8197-f5ed217483f2', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'Medical History: Reviewed. Vitals: Normal. Patient compliant.\nTreatment:\n- Pre-procedural 0.12% Chlorhexidine rinse.\n- Supra & subgingival scaling using ultrasonic scaler & hand scaling.\n- Stain removal using polishing paste.\n- Interdental flossing completed.\n- 5.0% Sodium Fluoride varnish applied.\nOral Hygiene Instructions: Daily flossing emphasized. Return in 6 months.', 'usr-hygienist', '2026-06-17 07:10:44.945', '2026-06-17 07:10:44.945'),
('826d33d3-8911-46b7-87d1-69b976cc93a4', 'clinic-1', 'pat-1', '[Assistant Prep Note]\nProcedure: Teeth Cleaning\nObservations: Assisted in local anesthesia administration (Lidocaine block). Maintained high-volume suction and tongue/cheek retraction during extraction. Monitored vital signs. Placed sterile gauze post-op.\nActions Taken: Sterilization completed, Instruments prepped, Patient post-op briefing', 'usr-assistant', '2026-06-17 06:53:41.453', '2026-06-17 06:53:41.453'),
('90807b36-235e-40b3-9211-e4a3760e1077', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '', 'usr-hygienist', '2026-06-17 07:10:42.280', '2026-06-17 07:10:42.280'),
('9986119e-68d8-4b07-a9fb-0bd523ab0eab', 'clinic-1', 'pat-1', '[Assistant Prep Note]\nProcedure: Cleaning\nObservations: Conducted panoramic and right bitewing scan series. Scans uploaded to patient record. Noted slight bone recession on posterior molar region, flagged for dentist diagnostic review.\nActions Taken: Sterilization completed, Instruments prepped\n\n[CHIEF COMPLAINT]\nPatient reports mild discomfort in the lower left jaw when chewing.\n\n[DIAGNOSIS]\nOcclusal caries detected on Tooth #19; localized gingival inflammation.\n\n[TREATMENT PERFORMED]\nAdministered local infiltration (2% Lidocaine with 1:100k Epinephrine). Completed composite restoration on Tooth #19. Excavated decay and applied bonding agent.\n\n[RECOMMENDATIONS]\nAvoid chewing hard foods on the lower left side for 24 hours. Maintain standard flossing and brush with fluoridated toothpaste twice daily. Follow up in 6 months.', 'usr-dentist', '2026-06-15 09:29:48.053', '2026-06-15 09:29:48.053'),
('ab561460-ed01-44de-8300-0ad4883ac38f', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '[Assistant Prep Note]\nProcedure: Crown\nObservations: Pre-procedural chlorhexidine rinse administered. Conducted intake and vitals audit. Assisted dentist during scaling and fine paste prophy polishing. Flossed. Pt advised on interproximal cleaning.\nActions Taken: Sterilization completed, Instruments prepped, Patient post-op briefing', 'f9caeeaa-f47f-4c58-a365-65fd826b4d94', '2026-06-15 12:12:46.284', '2026-06-15 12:12:46.284'),
('b9ced5ba-d2cd-4cb6-b905-eff4467d4d5b', 'clinic-1', 'pat-1', 'Medical History: Reviewed. Vitals: Normal.\nTreatment:\n- Conducted complete 6-point perio charting.\n- Localized root scaling on pocketed posterior teeth.\n- Subgingival irrigation with Chlorhexidine rinse.\n- Selective rubber cup polishing.\n- Flossed.\nOral Hygiene Instructions: Electric toothbrush usage reviewed. Re-evaluate perio status in 3 months.', 'usr-hygienist', '2026-06-15 09:41:11.137', '2026-06-15 09:41:11.137'),
('bf79d0de-64df-4de0-b1fd-8afb0a4c33d1', 'clinic-1', 'pat-1', '[Assistant Prep Note]\nProcedure: Cleaning\nObservations: Conducted panoramic and right bitewing scan series. Scans uploaded to patient record. Noted slight bone recession on posterior molar region, flagged for dentist diagnostic review.\nActions Taken: Sterilization completed, Instruments prepped', 'usr-assistant', '2026-06-15 09:05:17.052', '2026-06-15 09:05:17.052'),
('fc11ea2f-1c09-43ce-9545-0d2e131c95c8', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'Medical History: Reviewed. Vitals: Normal. Patient compliant.\nTreatment:\n- Pre-procedural 0.12% Chlorhexidine rinse.\n- Supra & subgingival scaling using ultrasonic scaler & hand scaling.\n- Stain removal using polishing paste.\n- Interdental flossing completed.\n- 5.0% Sodium Fluoride varnish applied.\nOral Hygiene Instructions: Daily flossing emphasized. Return in 6 months.', '8e71a7be-a7a1-4ec9-8052-6abaf6d771a8', '2026-06-15 12:31:07.973', '2026-06-15 12:31:07.973');

-- --------------------------------------------------------

--
-- Table structure for table `clinics`
--

CREATE TABLE `clinics` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `location` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `status` enum('Active','Trialing','Suspended') NOT NULL DEFAULT 'Active',
  `plan` enum('Basic','Premium','Enterprise','Trial') NOT NULL DEFAULT 'Basic',
  `monthlyFee` double NOT NULL DEFAULT 0,
  `performanceScore` int(11) NOT NULL DEFAULT 80,
  `aiModules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`aiModules`)),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clinics`
--

INSERT INTO `clinics` (`id`, `name`, `location`, `phone`, `status`, `plan`, `monthlyFee`, `performanceScore`, `aiModules`, `createdAt`, `updatedAt`) VALUES
('clinic-1', 'Metropolitan Dental Care', 'Downtown Seattle, WA', '(206) 555-0192', 'Active', 'Enterprise', 499, 94, '{\"diagnostic\":true,\"recallSMS\":true,\"workload\":true}', '2026-06-15 07:41:22.690', '2026-06-17 07:00:11.498'),
('clinic-2', 'Apex Orthodontics & Pediatrics', 'Bellevue, WA', '(425) 555-0143', 'Active', 'Premium', 299, 89, '{\"diagnostic\":true,\"recallSMS\":true,\"workload\":false}', '2026-06-15 07:41:22.694', '2026-06-15 10:49:56.095'),
('clinic-3', 'Northside Family Dentistry', 'Everett, WA', '(425) 555-0187', 'Active', 'Basic', 149, 81, '{\"diagnostic\":true,\"recallSMS\":false,\"workload\":false}', '2026-06-15 07:41:22.697', '2026-06-17 06:58:46.559'),
('clinic-4', 'Westside Pediatric Dental', 'Tacoma, WA', '(253) 555-0210', 'Suspended', 'Trial', 0, 78, '{\"diagnostic\":true,\"recallSMS\":false,\"workload\":false}', '2026-06-15 07:41:22.700', '2026-06-17 06:59:06.557');

-- --------------------------------------------------------

--
-- Table structure for table `crown_cases`
--

CREATE TABLE `crown_cases` (
  `id` varchar(191) NOT NULL,
  `caseId` varchar(191) NOT NULL,
  `toothNumber` varchar(191) NOT NULL,
  `material` varchar(191) NOT NULL DEFAULT 'Ceramic',
  `shade` varchar(191) NOT NULL DEFAULT 'A1',
  `notes` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `crown_cases`
--

INSERT INTO `crown_cases` (`id`, `caseId`, `toothNumber`, `material`, `shade`, `notes`, `createdAt`, `updatedAt`) VALUES
('397dd84d-3930-425f-981a-4dccbce23b7e', '2944e771-37a8-4554-8802-7b82b8c80dac', '24', 'Ceramic', 'A1', 'sertgsdfg', '2026-06-15 13:11:27.453', '2026-06-15 13:11:35.086'),
('abf656fb-88b8-4a68-a50d-e50554d916c0', 'f7481914-26cc-4d9a-819e-8c96d6da2bbf', '10', 'Zirconia', 'A1', 'High translucency', '2026-06-15 13:39:05.299', '2026-06-17 07:11:30.021');

-- --------------------------------------------------------

--
-- Table structure for table `implant_cases`
--

CREATE TABLE `implant_cases` (
  `id` varchar(191) NOT NULL,
  `caseId` varchar(191) NOT NULL,
  `stage` enum('Planning','Manufacturing','Ready','Delivered') NOT NULL DEFAULT 'Planning',
  `planningNotes` text DEFAULT NULL,
  `dimensions` varchar(191) DEFAULT NULL,
  `surgicalNotes` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `implant_cases`
--

INSERT INTO `implant_cases` (`id`, `caseId`, `stage`, `planningNotes`, `dimensions`, `surgicalNotes`, `createdAt`, `updatedAt`) VALUES
('57ee1f32-7e90-4ee2-a521-c1a0f17c4992', '94e24e53-4fa7-4eb4-bb75-3e9fcf8bac63', 'Ready', 'DFGSDF', 'Platform: 4.5mm, Length: 10.0mm', 'DFSGDSF', '2026-06-17 07:22:48.509', '2026-06-17 07:22:52.426'),
('884b60eb-7939-477a-bf8f-aa806be1bc03', 'f7481914-26cc-4d9a-819e-8c96d6da2bbf', 'Ready', 'dfsgsdf', 'Platform: 4.5mm, Length: 10.0mm', 'dfsgsfdgsdf', '2026-06-17 07:11:33.502', '2026-06-17 07:11:38.938'),
('99e4bcde-3008-4aea-a01a-318bd430d3d4', '2944e771-37a8-4554-8802-7b82b8c80dac', 'Ready', 'sdfgsd', 'Platform: 4.5mm, Length: 10.0mm', 'fgsdfgsdf', '2026-06-15 13:11:37.941', '2026-06-15 13:46:43.324');

-- --------------------------------------------------------

--
-- Table structure for table `insurance_checks`
--

CREATE TABLE `insurance_checks` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `provider` varchar(191) NOT NULL,
  `policyNumber` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Pending',
  `coverageDetails` text NOT NULL,
  `lastChecked` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `insurance_checks`
--

INSERT INTO `insurance_checks` (`id`, `clinicId`, `patientName`, `provider`, `policyNumber`, `status`, `coverageDetails`, `lastChecked`) VALUES
('6844ef40-aa05-42f2-9f17-410a3a4283ee', 'clinic-1', 'patient', 'fdvgsdf', 'dfsgsdf', 'Pending', '', '2026-06-15 13:40:33.754');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `dueDate` date NOT NULL,
  `amount` double NOT NULL,
  `tax` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `insurancePaid` double NOT NULL DEFAULT 0,
  `patientPaid` double NOT NULL DEFAULT 0,
  `status` enum('Paid','Partial','Unpaid','Overdue') NOT NULL DEFAULT 'Unpaid',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`items`)),
  `labCaseId` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `clinicId`, `patientId`, `patientName`, `date`, `dueDate`, `amount`, `tax`, `discount`, `insurancePaid`, `patientPaid`, `status`, `items`, `labCaseId`, `createdAt`, `updatedAt`) VALUES
('242904cc-3fae-413d-9647-0422d3535c7e', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-07-15', 250, 0, 0, 0, 0, 'Unpaid', '\"[{\\\"description\\\":\\\"Composite Filling\\\",\\\"cost\\\":250}]\"', NULL, '2026-06-15 13:39:05.287', '2026-06-15 13:39:05.287'),
('27a2441c-5762-4e7f-9189-eff5fd388c6d', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-07-15', 250, 0, 0, 0, 0, 'Unpaid', '\"[{\\\"description\\\":\\\"Composite Filling\\\",\\\"cost\\\":250}]\"', NULL, '2026-06-15 13:38:37.109', '2026-06-15 13:38:37.109'),
('89e5099b-eda1-4ef4-9324-6d4982db4236', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-06-29', 850, 0, 0, 500, 100, 'Partial', '\"[{\\\"description\\\":\\\"Root Canal\\\",\\\"cost\\\":850}]\"', NULL, '2026-06-15 13:38:37.109', '2026-06-15 13:38:37.109'),
('9e1e24b7-59c9-426e-b0b2-7316ac5f2c04', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-06-29', 850, 0, 0, 500, 100, 'Partial', '\"[{\\\"description\\\":\\\"Root Canal\\\",\\\"cost\\\":850}]\"', NULL, '2026-06-15 13:39:05.287', '2026-06-15 13:39:05.287'),
('inv-1001', 'clinic-1', 'pat-1', 'James Carter', '2026-05-14', '2026-05-28', 180, 9, 0, 120, 60, 'Paid', '[{\"description\":\"Comprehensive Exam\",\"cost\":80},{\"description\":\"Prophylaxis - Adult Cleaning\",\"cost\":100}]', NULL, '2026-06-15 07:41:23.010', '2026-06-15 07:41:23.010'),
('inv-1781516549964', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-06-29', 250, 12.5, 0, 0, 250, 'Paid', '[{\"description\":\"Lab Fees - Crown Fabrication (Pacific Dental Lab)\",\"cost\":250}]', NULL, '2026-06-15 09:42:29.969', '2026-06-15 09:43:23.859'),
('inv-1781516550013', 'clinic-1', 'pat-1', 'James Carter', '2026-12-06', '2026-06-29', 262.5, 12.5, 0, 0, 0, 'Paid', '[{\"description\":\"Lab Fees - Crown Fabrication (Pacific Dental Lab)\",\"cost\":250}]', NULL, '2026-06-15 09:42:30.016', '2026-06-15 09:43:56.150'),
('inv-1781529374137', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-06-15', 54590, 2600, 10, 0, 0, 'Paid', '[{\"description\":\"sdfasdf\",\"cost\":52000}]', NULL, '2026-06-15 13:16:14.141', '2026-06-15 13:16:14.141'),
('inv-1781680293599', 'clinic-1', 'pat-1', 'James Carter', '2026-06-17', '2026-07-01', 300, 15, 0, 0, 0, 'Unpaid', '\"[{\\\"description\\\":\\\"Lab Fees - Crown Fabrication (Precision Dental Labs)\\\",\\\"cost\\\":300}]\"', NULL, '2026-06-17 07:11:33.601', '2026-06-17 07:11:33.601'),
('inv-1781680979377', 'clinic-1', 'pat-1', 'James Carter', '2026-06-17', '2026-07-01', 250, 12.5, 0, 0, 0, 'Unpaid', '\"[{\\\"description\\\":\\\"Lab Fees - Denture Fabrication (Pacific Dental Lab)\\\",\\\"cost\\\":250}]\"', NULL, '2026-06-17 07:22:59.380', '2026-06-17 07:22:59.380');

-- --------------------------------------------------------

--
-- Table structure for table `lab_cases`
--

CREATE TABLE `lab_cases` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `dentistName` varchar(191) NOT NULL,
  `type` enum('Crown','Implant','Bridge','Denture','Aligner','Retainer') NOT NULL,
  `status` enum('Created','Sent','In_Progress','Ready','Delivered') NOT NULL DEFAULT 'Created',
  `expectedDelivery` date NOT NULL,
  `cost` double NOT NULL,
  `notes` text DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`attachments`)),
  `labName` varchar(191) NOT NULL DEFAULT 'Pending Assignment',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_cases`
--

INSERT INTO `lab_cases` (`id`, `clinicId`, `patientId`, `patientName`, `dentistName`, `type`, `status`, `expectedDelivery`, `cost`, `notes`, `attachments`, `labName`, `createdAt`, `updatedAt`) VALUES
('2944e771-37a8-4554-8802-7b82b8c80dac', 'clinic-1', 'pat-1', 'James Carter', 'Dr. Michael Chen', 'Crown', 'Ready', '2026-10-12', 250, 'sertgsdfg', '[\"sdfgsdf\"]', 'Pacific Dental Lab', '2026-06-15 13:11:27.453', '2026-06-15 13:46:42.419'),
('94e24e53-4fa7-4eb4-bb75-3e9fcf8bac63', 'clinic-1', 'pat-1', 'James Carter', 'Dr. Michael Chen', 'Denture', 'Delivered', '2026-10-20', 250, 'Denture fabrication test', '\"[\\\"intraoral_scan.obj\\\"]\"', 'Pacific Dental Lab', '2026-06-17 07:19:11.198', '2026-06-17 07:22:59.322'),
('f7481914-26cc-4d9a-819e-8c96d6da2bbf', 'clinic-1', 'pat-1', 'James Carter', 'Dr. Michael Chen', 'Crown', 'Ready', '2026-06-22', 300, 'Please match shade A1 perfectly.', '\"[]\"', 'Precision Dental Labs', '2026-06-15 13:39:05.299', '2026-06-17 07:11:33.939');

-- --------------------------------------------------------

--
-- Table structure for table `odontograms`
--

CREATE TABLE `odontograms` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `chartData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`chartData`)),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `odontograms`
--

INSERT INTO `odontograms` (`id`, `clinicId`, `patientId`, `chartData`, `createdAt`, `updatedAt`) VALUES
('1b146ffe-ebc9-4067-a58c-011e0e5d73bd', 'clinic-1', 'pat-1', '\"{\\\"8\\\":\\\"Cavity\\\",\\\"14\\\":\\\"Crown\\\",\\\"15\\\":\\\"Healthy\\\",\\\"24\\\":\\\"Cavity\\\"}\"', '2026-06-15 09:18:54.953', '2026-06-17 06:29:22.660'),
('949752c4-1e09-4031-b05b-a609f9cb20b5', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '{\"1\":\"Healthy\",\"2\":\"Healthy\",\"3\":\"Healthy\",\"4\":\"Healthy\",\"5\":\"Healthy\",\"6\":\"Cavity\",\"7\":\"Healthy\",\"8\":\"Implant\",\"9\":\"Implant\",\"10\":\"Healthy\",\"11\":\"Healthy\",\"12\":\"Healthy\",\"13\":\"Healthy\",\"14\":\"Healthy\",\"15\":\"Healthy\",\"16\":\"Healthy\",\"17\":\"Healthy\",\"18\":\"Healthy\",\"19\":\"Healthy\",\"20\":\"Cavity\",\"21\":\"Healthy\",\"22\":\"Healthy\",\"23\":\"Healthy\",\"24\":\"Healthy\",\"25\":\"Crown\",\"26\":\"Healthy\",\"27\":\"Healthy\",\"28\":\"Healthy\",\"29\":\"Healthy\",\"30\":\"Healthy\",\"31\":\"Healthy\",\"32\":\"Healthy\"}', '2026-06-15 12:13:34.779', '2026-06-15 12:15:55.676');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `userId` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `age` int(11) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Inactive',
  `vitals` text DEFAULT NULL,
  `allergies` varchar(191) DEFAULT NULL,
  `history` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `address` varchar(191) DEFAULT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `insuranceProvider` varchar(191) DEFAULT NULL,
  `perioChartData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`perioChartData`)),
  `riskProfileData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`riskProfileData`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `clinicId`, `userId`, `name`, `age`, `phone`, `email`, `status`, `vitals`, `allergies`, `history`, `createdAt`, `updatedAt`, `address`, `gender`, `insuranceProvider`, `perioChartData`, `riskProfileData`) VALUES
('fa0c556f-4746-4168-b9c2-c20e28b4de11', 'clinic-1', 'da6c734d-4e56-48de-a97b-2ffde89779e3', 'patient', 45, '2541364455', 'p@gmail.com', 'Active', '', 'peniclla', '', '2026-06-15 11:26:28.337', '2026-06-17 07:32:57.188', 'ksdfjj', 'Male', 'blue crioss', '{\"1\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"2\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"3\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"4\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"5\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"6\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"7\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"8\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"9\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"10\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"11\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"12\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"13\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"14\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"15\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"16\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"17\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"18\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"19\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"20\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"21\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"22\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"23\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":2},\"24\":{\"pocketDepth\":3,\"bleeding\":true,\"mobility\":1},\"25\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"26\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"27\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"28\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"29\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"30\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"31\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"32\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0}}', '{\"classification\":\"Medium\",\"lastAssessed\":\"2026-06-15\",\"riskFactors\":[\"rtfgsdfg\"],\"aiAdvice\":\"Perform routine scaling and prophy polishing. Focus patient flossing in molar segments. Assess localized pockets during the next 6-month checkup. Apply fluoride varnish to protect vulnerable root areas.\"}'),
('pat-1', 'clinic-1', 'usr-patient', 'James Carter', 45, '(206) 555-1212', 'patient@gmail.com', 'Active', 'BP: 120/80, Temp: 98.6 F, Pulse: 72 bpm', 'Penicillin', 'No systemic diseases. High hygiene compliance. Mild bruxism.', '2026-06-15 07:41:22.882', '2026-06-15 13:59:41.408', '123 Pine St, Seattle, WA', 'Male', 'MetLife Dental', '{\"1\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"2\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"3\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"4\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"5\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"6\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"7\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"8\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"9\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"10\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"11\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"12\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"13\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"14\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"15\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"16\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"17\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"18\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"19\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"20\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"21\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"22\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"23\":{\"pocketDepth\":3,\"bleeding\":true,\"mobility\":3},\"24\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"25\":{\"pocketDepth\":3,\"bleeding\":true,\"mobility\":0},\"26\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"27\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"28\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"29\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"30\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"31\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0},\"32\":{\"pocketDepth\":3,\"bleeding\":false,\"mobility\":0}}', NULL),
('pat-5', 'clinic-2', NULL, 'Robert Chen', 52, '(425) 555-9012', 'robert@chen.org', 'Active', 'BP: 125/82, Temp: 98.7 F', 'Sulfa', 'Requires pre-medication before surgical procedures.', '2026-06-15 07:41:22.898', '2026-06-15 07:41:22.898', '202 Bellevue Way, Bellevue, WA', 'Male', 'Aetna PPO', NULL, NULL),
('pat-6', 'clinic-2', NULL, 'Emily Davis', 26, '(425) 555-3456', 'emily.d@gmail.com', 'Active', 'BP: 110/68, Temp: 98.1 F', '', 'Occasional teeth sensitivity. Brushes twice daily.', '2026-06-15 07:41:22.902', '2026-06-15 07:41:22.902', '303 Red Wood Ave, Redmond, WA', 'Female', 'None', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `invoiceId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `amount` double NOT NULL,
  `method` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `note` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `clinicId`, `invoiceId`, `patientName`, `amount`, `method`, `date`, `note`, `createdAt`) VALUES
('pay-001', 'clinic-1', 'inv-1001', 'James Carter', 60, 'Card', '2026-05-14', 'Patient co-pay at checkout', '2026-06-15 07:41:23.098'),
('pay-002', 'clinic-1', 'inv-1001', 'James Carter', 120, 'Insurance', '2026-05-18', 'Blue Cross Blue Shield reimbursement', '2026-06-15 07:41:23.103'),
('pay-003', 'clinic-1', 'inv-1002', 'Mary Watson', 100, 'Cash', '2026-05-20', 'Partial cash payment at front desk', '2026-06-15 07:41:23.106'),
('pay-004', 'clinic-1', 'inv-1002', 'Mary Watson', 800, 'Insurance', '2026-05-26', 'Aetna insurance partial claim payout', '2026-06-15 07:41:23.110'),
('pay-1781516603833', 'clinic-1', 'inv-1781516549964', 'James Carter', 250, 'Card', '2026-06-15', 'Direct invoice payout', '2026-06-15 09:43:23.835');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `price` double NOT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`features`)),
  `maxClinics` int(11) NOT NULL DEFAULT 1,
  `maxUsers` int(11) NOT NULL DEFAULT 5,
  `maxPatients` int(11) NOT NULL DEFAULT 50,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `billingPeriod` varchar(191) NOT NULL DEFAULT 'Monthly',
  `status` varchar(191) NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `price`, `features`, `maxClinics`, `maxUsers`, `maxPatients`, `createdAt`, `updatedAt`, `billingPeriod`, `status`) VALUES
('79340637-c015-4c83-8a47-1491fc791c27', 'trial', 0, '[\"comon free paln\"]', 1, 5, 50, '2026-06-15 10:44:04.081', '2026-06-15 10:44:19.771', 'Monthly', 'Active'),
('plan-basic', 'Basic', 149, '[\"Up to 3 staff\",\"Basic Diagnostics\",\"Text Reminders\"]', 1, 5, 50, '2026-06-15 07:41:22.676', '2026-06-15 07:41:22.676', 'Monthly', 'Active'),
('plan-enterprise', 'Enterprise', 499, '[\"Unlimited staff\",\"Full AI Suite\",\"Multi-Location Aggregates\",\"24/7 Priority Support\"]', 1, 9999, 99999, '2026-06-15 07:41:22.686', '2026-06-15 07:41:22.686', 'Monthly', 'Active'),
('plan-pro', 'Premium', 299, '[\"Up to 10 staff\",\"AI Recall\",\"Full Diagnostics\",\"Custom SMS\"]', 1, 15, 500, '2026-06-15 07:41:22.681', '2026-06-15 07:41:22.681', 'Monthly', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `drug` varchar(191) NOT NULL,
  `dosage` varchar(191) NOT NULL,
  `frequency` varchar(191) NOT NULL,
  `duration` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `clinicId`, `patientId`, `drug`, `dosage`, `frequency`, `duration`, `date`, `createdAt`, `updatedAt`) VALUES
('0aa7d84b-3766-4cfa-847c-368bba6a7f99', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'parcetmol', '300', '7', '5', '2026-06-15', '2026-06-15 12:15:09.097', '2026-06-15 12:15:09.097'),
('2deb6af9-6a3f-45e9-b5d0-401b4792876a', 'clinic-1', 'pat-1', 'paracetamol', '500mg', 'asdfjk', '7days', '2026-06-15', '2026-06-15 09:29:42.733', '2026-06-15 09:29:42.733'),
('587fc46f-0f24-4359-9407-89ea64801ce1', 'clinic-1', 'pat-1', 'Amoxicillin 500mg', '1 Capsule', '3 times a day', '7 Days', '2026-06-15', '2026-06-15 13:39:05.292', '2026-06-15 13:39:05.292'),
('65252ce6-b101-46ed-a9a8-d99dd950842b', 'clinic-1', 'pat-1', 'Amoxicillin 500mg', '1 Capsule', '3 times a day', '7 Days', '2026-06-15', '2026-06-15 13:38:37.114', '2026-06-15 13:38:37.114'),
('e951c930-5cdc-4575-b960-c71ef61d43ef', 'clinic-1', 'pat-1', 'sadfas', '500', '2', '7', '2026-06-15', '2026-06-15 13:14:09.016', '2026-06-15 13:14:09.016'),
('fa122c0e-81b3-4662-810d-593a265caf70', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'parcetmol', '500', '7', '5', '2026-06-15', '2026-06-15 12:14:57.959', '2026-06-15 12:14:57.959');

-- --------------------------------------------------------

--
-- Table structure for table `refresh_tokens`
--

CREATE TABLE `refresh_tokens` (
  `id` varchar(191) NOT NULL,
  `token` text NOT NULL,
  `userId` varchar(191) NOT NULL,
  `expiresAt` datetime(3) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refresh_tokens`
--

INSERT INTO `refresh_tokens` (`id`, `token`, `userId`, `expiresAt`, `createdAt`) VALUES
('2f6511d7-6e8d-4d88-854d-084cf064db83', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1hc3Npc3RhbnQiLCJlbWFpbCI6ImFzc2lzdGFudEBnbWFpbC5jb20iLCJyb2xlIjoiZGVudGFsX2Fzc2lzdGFudCIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODE2ODM0ODMsImV4cCI6MTc4MjI4ODI4M30.3tAuUIml74MDRTw3gbvhkRSJ1-aoTroJPmHYXhWz4hM', 'usr-assistant', '2026-06-24 08:04:43.003', '2026-06-17 08:04:43.005'),
('be5a178f-2fcb-43a9-bb3d-864dff7736ea', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1jbGluaWNvd25lciIsImVtYWlsIjoiY2xpbmljb3duZXJAZ21haWwuY29tIiwicm9sZSI6ImNsaW5pY19vd25lciIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODE1MzIzOTMsImV4cCI6MTc4MjEzNzE5M30.NgirFNyDpUWGpkEaqQZEi3F4XaSYVhdXzwzir5AKVoI', 'usr-clinicowner', '2026-06-22 14:06:33.542', '2026-06-15 14:06:33.543'),
('e97ab0fd-0063-4468-a819-0f4748c85cf8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1oeWdpZW5pc3QiLCJlbWFpbCI6Imh5Z2llbmlzdEBnbWFpbC5jb20iLCJyb2xlIjoiaHlnaWVuaXN0IiwiY2xpbmljSWQiOiJjbGluaWMtMSIsImlhdCI6MTc4MTY4NTg2MCwiZXhwIjoxNzgyMjkwNjYwfQ.PTVV7KjjvoRmGJ95e9pXJroMpA9Gh7abzMh6yDWZG1Y', 'usr-hygienist', '2026-06-24 08:44:20.163', '2026-06-17 08:44:20.169'),
('ff4c61bc-3c01-400b-9528-30d5c0fe17d9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1mcm9udGRlc2siLCJlbWFpbCI6ImZyb250ZGVza0BnbWFpbC5jb20iLCJyb2xlIjoiZnJvbnRfZGVzayIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODE1MTA1OTEsImV4cCI6MTc4MjExNTM5MX0.M6aCHuYnbnHyry6UabYJC7kRc4aicSTfzqGylHhza6M', 'usr-frontdesk', '2026-06-22 08:03:11.288', '2026-06-15 08:03:11.291');

-- --------------------------------------------------------

--
-- Table structure for table `saas_invoices`
--

CREATE TABLE `saas_invoices` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `clinicName` varchar(191) NOT NULL,
  `amount` double NOT NULL,
  `issueDate` date NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Unpaid',
  `plan` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `stripeInvoiceId` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `saas_invoices`
--

INSERT INTO `saas_invoices` (`id`, `clinicId`, `clinicName`, `amount`, `issueDate`, `status`, `plan`, `createdAt`, `updatedAt`, `stripeInvoiceId`) VALUES
('sinv-101', 'clinic-1', 'Metropolitan Dental Care', 499, '2026-06-01', 'Paid', 'Enterprise', '2026-06-15 07:41:22.917', '2026-06-15 07:41:22.917', NULL),
('sinv-102', 'clinic-2', 'Apex Orthodontics & Pediatrics', 299, '2026-06-01', 'Paid', 'Premium', '2026-06-15 07:41:22.929', '2026-06-15 07:41:22.929', NULL),
('sinv-103', 'clinic-3', 'Northside Family Dentistry', 149, '2026-06-01', 'Unpaid', 'Basic', '2026-06-15 07:41:22.981', '2026-06-15 07:41:22.981', NULL),
('sinv-104', 'clinic-4', 'Westside Pediatric Dental', 0, '2026-06-01', 'Trial', 'Trial', '2026-06-15 07:41:22.986', '2026-06-15 07:41:22.986', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `statements`
--

CREATE TABLE `statements` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `generatedDate` date NOT NULL,
  `periodStart` date NOT NULL,
  `periodEnd` date NOT NULL,
  `totalBilled` double NOT NULL,
  `totalPaid` double NOT NULL,
  `balance` double NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `statements`
--

INSERT INTO `statements` (`id`, `clinicId`, `patientId`, `patientName`, `generatedDate`, `periodStart`, `periodEnd`, `totalBilled`, `totalPaid`, `balance`, `createdAt`) VALUES
('stmt-001', 'clinic-1', 'pat-1', 'James Carter', '2026-06-01', '2026-01-01', '2026-06-01', 180, 180, 0, '2026-06-15 07:41:23.127'),
('stmt-002', 'clinic-1', 'pat-2', 'Mary Watson', '2026-06-01', '2026-01-01', '2026-06-01', 1200, 900, 300, '2026-06-15 07:41:23.132'),
('stmt-1781529398092', 'clinic-1', 'pat-1', 'James Carter', '2026-06-15', '2026-01-01', '2026-06-15', 55282.5, 430, 54852.5, '2026-06-15 13:16:38.094');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `planId` varchar(191) NOT NULL,
  `stripeCustomerId` varchar(191) DEFAULT NULL,
  `stripeSubscriptionId` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'inactive',
  `startDate` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `endDate` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `clinicId`, `planId`, `stripeCustomerId`, `stripeSubscriptionId`, `status`, `startDate`, `endDate`, `createdAt`, `updatedAt`) VALUES
('0dc29039-766e-4d5a-8637-57ac9ce331c0', 'clinic-4', 'plan-basic', NULL, NULL, 'inactive', '2026-05-01 00:00:00.000', NULL, '2026-06-15 07:41:22.715', '2026-06-15 07:41:22.715'),
('5e8420c8-f859-4404-8220-212dd18df044', 'clinic-1', 'plan-enterprise', NULL, NULL, 'active', '2026-05-01 00:00:00.000', NULL, '2026-06-15 07:41:22.706', '2026-06-15 07:41:22.706'),
('83656226-b52a-44b4-a3fc-ec26c0eafade', 'clinic-2', 'plan-pro', NULL, NULL, 'active', '2026-05-01 00:00:00.000', NULL, '2026-06-15 07:41:22.710', '2026-06-15 07:41:22.710'),
('d245d4c6-c233-4918-8050-633d2bcb7e56', 'clinic-3', 'plan-basic', NULL, NULL, 'active', '2026-05-01 00:00:00.000', NULL, '2026-06-15 07:41:22.712', '2026-06-15 07:41:22.712');

-- --------------------------------------------------------

--
-- Table structure for table `treatment_plans`
--

CREATE TABLE `treatment_plans` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `tooth` varchar(191) NOT NULL,
  `procedure` varchar(191) NOT NULL,
  `cost` double NOT NULL,
  `status` enum('Proposed','Accepted','Completed','Rejected') NOT NULL DEFAULT 'Proposed',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `treatment_plans`
--

INSERT INTO `treatment_plans` (`id`, `clinicId`, `patientId`, `tooth`, `procedure`, `cost`, `status`, `createdAt`, `updatedAt`) VALUES
('28ad508c-df59-4a42-996a-38200403ae44', 'clinic-1', 'pat-1', '14', 'tooafas', 3000, 'Proposed', '2026-06-15 09:30:33.247', '2026-06-15 09:30:33.247'),
('4226a85d-d5e4-4c95-89b8-cf83a2004806', 'clinic-1', 'pat-1', '8', 'Porcelain Crown', 1200, 'Proposed', '2026-06-15 13:38:37.094', '2026-06-15 13:38:37.094'),
('5e799e5d-ddf3-4971-832d-b0a1ada68f19', 'clinic-1', 'pat-1', '15', 'Composite Filling', 250, 'Accepted', '2026-06-15 13:38:37.094', '2026-06-15 13:38:37.094'),
('66a48b05-f2b6-457e-a023-6c01bd14fda4', 'clinic-1', 'pat-1', '8', 'Porcelain Crown', 1200, 'Proposed', '2026-06-15 13:39:05.277', '2026-06-15 13:39:05.277'),
('92f46a93-28da-47aa-b344-fe24ebab0e14', 'clinic-1', 'pat-1', '14', 'Root Canal', 850, 'Completed', '2026-06-15 13:39:05.277', '2026-06-15 13:39:05.277'),
('b66bc370-f0ba-4aa8-9ae6-f90b47987e89', 'clinic-1', 'pat-1', '14', 'Root Canal', 850, 'Completed', '2026-06-15 13:38:37.094', '2026-06-15 13:38:37.094'),
('bf901cf3-78fc-4277-9db2-1b1f58fd5b7e', 'clinic-1', 'pat-1', '1+9', 'sdfgsadf', 300, 'Proposed', '2026-06-15 13:13:36.453', '2026-06-15 13:13:36.453'),
('d8d84e75-8c75-41e7-8c5b-1048710c80bf', 'clinic-1', 'pat-1', '15', 'Composite Filling', 250, 'Accepted', '2026-06-15 13:39:05.277', '2026-06-15 13:39:05.277'),
('f4c3f00d-a708-4dba-a6d0-9460a54b177f', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', '14', 'tootj meesing', 400, 'Proposed', '2026-06-15 12:14:14.344', '2026-06-15 12:14:14.344');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `role` enum('super_admin','clinic_owner','dentist','hygienist','front_desk','billing_staff','lab_coordinator','dental_assistant','patient') NOT NULL,
  `status` enum('Approved','Pending_Approval','Suspended') NOT NULL DEFAULT 'Pending_Approval',
  `avatarUrl` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `speciality` varchar(191) DEFAULT NULL,
  `assistantId` varchar(191) DEFAULT NULL,
  `hygienistId` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `clinicId`, `name`, `email`, `password`, `role`, `status`, `avatarUrl`, `createdAt`, `updatedAt`, `phone`, `speciality`, `assistantId`, `hygienistId`) VALUES
('8e71a7be-a7a1-4ec9-8052-6abaf6d771a8', 'clinic-1', 'hygienist', 'h@gmail.com', '$2a$12$SDNlIUtSRr8QtzKTLXdZ1e0D4Dy12AGaw8DenMVbO7XV9affmqnvq', 'hygienist', 'Approved', NULL, '2026-06-15 11:13:51.570', '2026-06-15 11:13:51.570', '12564513212', NULL, NULL, NULL),
('cc74ba84-db8e-41c9-bfe7-5259bdd5cdfd', 'clinic-2', 'apex', 'apex@gmail.com', '$2a$12$4oAm2aFW7dl8mxEj/oUYr./eZf0hYCrbwICLtGKzGLgOD4FK1LXKm', 'clinic_owner', 'Approved', NULL, '2026-06-15 10:50:18.861', '2026-06-15 10:50:18.861', NULL, NULL, NULL, NULL),
('d1e0dc0e-841d-4e7f-bce0-2c3c9752a7fb', 'clinic-1', 'dentist', 'd@gmail.com', '$2a$12$nQEx/KqsxIgKhi0Hgx2.DuMp9fgylYVS1na8I.oJcCCLXNhuINAw2', 'dentist', 'Approved', NULL, '2026-06-15 11:12:58.375', '2026-06-15 11:15:26.658', '1521541212', 'jsdkfjasdk', 'f9caeeaa-f47f-4c58-a365-65fd826b4d94', '8e71a7be-a7a1-4ec9-8052-6abaf6d771a8'),
('da6c734d-4e56-48de-a97b-2ffde89779e3', 'clinic-1', 'patient', 'p@gmail.com', '$2a$12$RzTas03miHx7p5L.FF/6c.5Hpkt8OJO/md0Az1ubCgwlmzPb7FWmu', 'patient', 'Approved', NULL, '2026-06-15 11:26:28.328', '2026-06-15 11:26:28.328', NULL, NULL, NULL, NULL),
('f32e1e32-cec4-4891-b47d-7ada471b0b57', 'clinic-1', 'lab', 'l@gmail.com', '$2a$12$MuGiTkuYXicw8nt51.qmAex3/EWbWBcENe829oKuNLuxy1/54SsVu', 'lab_coordinator', 'Approved', NULL, '2026-06-15 12:29:09.015', '2026-06-15 12:29:09.015', '865451231554', NULL, NULL, NULL),
('f9caeeaa-f47f-4c58-a365-65fd826b4d94', 'clinic-1', 'assistant', 'a@gmail.com', '$2a$12$8X0K7XRijYTDHIeUoZ.WbOn9E0dORqrzGMYlgNta6TQhNskYxFaS2', 'dental_assistant', 'Approved', NULL, '2026-06-15 11:15:05.945', '2026-06-15 11:15:05.945', '884564512', NULL, NULL, NULL),
('usr-assistant', 'clinic-1', 'David Miller', 'assistant@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'dental_assistant', 'Approved', NULL, '2026-06-15 07:41:22.859', '2026-06-15 07:41:22.859', '(206) 555-0102', NULL, NULL, NULL),
('usr-billing', 'clinic-1', 'Samantha Billing', 'billingstaff@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'billing_staff', 'Approved', NULL, '2026-06-15 07:41:22.867', '2026-06-15 07:41:22.867', '(206) 555-0105', NULL, NULL, NULL),
('usr-clinicowner', 'clinic-1', 'Dr. Arthur Vance', 'clinicowner@gmail.com', '$2a$12$clGWp083DofZ3GXLomtUgeUPbp4qTETfS3Z8tHSzn/zxlulNDW08a', 'clinic_owner', 'Approved', NULL, '2026-06-15 07:41:22.853', '2026-06-15 10:52:29.368', '(206) 555-0100', NULL, NULL, NULL),
('usr-dentist', 'clinic-1', 'Dr. Michael Chen, DDS', 'dentist@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'dentist', 'Approved', NULL, '2026-06-15 07:41:22.856', '2026-06-15 07:41:22.856', '(206) 555-0101', 'Dentistry', 'usr-assistant', 'usr-hygienist'),
('usr-frontdesk', 'clinic-1', 'Amara Lopez', 'frontdesk@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'front_desk', 'Approved', NULL, '2026-06-15 07:41:22.865', '2026-06-15 07:41:22.865', '(206) 555-0104', NULL, NULL, NULL),
('usr-hygienist', 'clinic-1', 'Elena Rostova, RDH', 'hygienist@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'hygienist', 'Approved', NULL, '2026-06-15 07:41:22.862', '2026-06-15 07:41:22.862', '(206) 555-0103', 'Hygiene', NULL, NULL),
('usr-lab', 'clinic-1', 'Marcus Vance', 'labcoordinator@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'lab_coordinator', 'Approved', NULL, '2026-06-15 07:41:22.871', '2026-06-15 07:41:22.871', '(206) 555-0106', NULL, NULL, NULL),
('usr-owner-clinic-3', 'clinic-3', 'Dr. Rajesh Sharma', 'rajesh@sharmadental.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'clinic_owner', 'Pending_Approval', NULL, '2026-06-15 07:41:22.877', '2026-06-15 07:41:22.877', NULL, NULL, NULL, NULL),
('usr-owner-clinic-4', 'clinic-4', 'Dr. Jane Miller', 'jane.miller@millerdental.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'clinic_owner', 'Suspended', NULL, '2026-06-15 07:41:22.879', '2026-06-15 07:41:22.879', NULL, NULL, NULL, NULL),
('usr-patient', 'clinic-1', 'James Carter', 'patient@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'patient', 'Approved', NULL, '2026-06-15 07:41:22.874', '2026-06-15 07:41:22.874', NULL, NULL, NULL, NULL),
('usr-superadmin', NULL, 'Sarah Jenkins', 'superadmin@gmail.com', '$2a$10$UeAvrHpbR6z67OKRA9VoneH0dE/2ZSUKcyGQxNCZAAmEVJqo4ux1y', 'super_admin', 'Approved', NULL, '2026-06-15 07:41:22.848', '2026-06-15 07:41:22.848', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `waitlist_items`
--

CREATE TABLE `waitlist_items` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientName` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `preferredTime` varchar(191) NOT NULL,
  `priority` varchar(191) NOT NULL,
  `reason` varchar(191) NOT NULL,
  `addedTime` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `waitlist_items`
--

INSERT INTO `waitlist_items` (`id`, `clinicId`, `patientName`, `phone`, `preferredTime`, `priority`, `reason`, `addedTime`) VALUES
('13cb3911-488b-49b0-b9fe-817e82e78045', 'clinic-1', 'patient', '2541364455', 'Morning', 'Medium', '', '2026-06-17 07:04:52.433'),
('4db742a7-b374-49d0-8031-1522af35c640', 'clinic-1', 'James Carter', '(206) 555-1212', 'Morning', 'Medium', 'fghdf', '2026-06-15 13:52:53.913');

-- --------------------------------------------------------

--
-- Table structure for table `xray_files`
--

CREATE TABLE `xray_files` (
  `id` varchar(191) NOT NULL,
  `clinicId` varchar(191) NOT NULL,
  `patientId` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `isScanned` tinyint(1) NOT NULL DEFAULT 0,
  `aiReport` text DEFAULT NULL,
  `fileUrl` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `xray_files`
--

INSERT INTO `xray_files` (`id`, `clinicId`, `patientId`, `name`, `date`, `notes`, `isScanned`, `aiReport`, `fileUrl`, `createdAt`, `updatedAt`) VALUES
('0ea0d6bd-b74d-4815-8395-b580f3c869b8', 'clinic-1', 'pat-1', '[Periapical] WhatsApp Image 2026-06-10 at 4.06.41 AM.jpeg', '2026-06-15', '[Assistant Upload] dfgsdf', 1, 'AI Dental Audit Report: Detected radiolucency suspicious of occlusal caries on tooth #14. Bordering enamel index standard.', '', '2026-06-15 09:05:04.638', '2026-06-17 06:27:56.363'),
('2e80f880-7f8f-4081-84a5-6c7cdbca79c2', 'clinic-1', 'pat-1', 'ChatGPT Image Jun 9, 2026, 06_36_09 AM.png', '2026-06-17', '[Panoramic] gdfgdfg', 0, '', '/uploads/xrays/16e4cbf2-426a-43e9-94c4-73b41773f10a.png', '2026-06-17 06:53:07.224', '2026-06-17 06:53:07.224'),
('4b5fca3f-3ff7-4458-94e7-0c47dc033bb5', 'clinic-1', 'fa0c556f-4746-4168-b9c2-c20e28b4de11', 'ChatGPT Image Jun 9, 2026, 06_36_09 AM.png', '2026-06-17', '[Bitewing] asdgdsf', 0, '', '/uploads/xrays/f8c8f56f-2520-48bd-b674-b9ea2e283d46.png', '2026-06-17 07:09:10.472', '2026-06-17 07:09:10.472');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_logs`
--
ALTER TABLE `ai_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_logs_clinicId_fkey` (`clinicId`),
  ADD KEY `ai_logs_userId_fkey` (`userId`);

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alerts_clinicId_fkey` (`clinicId`),
  ADD KEY `alerts_userId_fkey` (`userId`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointments_clinicId_fkey` (`clinicId`),
  ADD KEY `appointments_patientId_fkey` (`patientId`),
  ADD KEY `appointments_dentistId_fkey` (`dentistId`),
  ADD KEY `appointments_assignedDoctorId_fkey` (`assignedDoctorId`),
  ADD KEY `appointments_assignedAssistantId_fkey` (`assignedAssistantId`),
  ADD KEY `appointments_assignedHygienistId_fkey` (`assignedHygienistId`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_clinicId_fkey` (`clinicId`),
  ADD KEY `audit_logs_userId_fkey` (`userId`);

--
-- Indexes for table `chairside_sessions`
--
ALTER TABLE `chairside_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `chairside_sessions_appointmentId_key` (`appointmentId`),
  ADD KEY `chairside_sessions_patientId_fkey` (`patientId`);

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clinical_notes`
--
ALTER TABLE `clinical_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clinical_notes_patientId_fkey` (`patientId`);

--
-- Indexes for table `clinics`
--
ALTER TABLE `clinics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `crown_cases`
--
ALTER TABLE `crown_cases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `crown_cases_caseId_key` (`caseId`);

--
-- Indexes for table `implant_cases`
--
ALTER TABLE `implant_cases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `implant_cases_caseId_key` (`caseId`);

--
-- Indexes for table `insurance_checks`
--
ALTER TABLE `insurance_checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `insurance_checks_clinicId_fkey` (`clinicId`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoices_clinicId_fkey` (`clinicId`),
  ADD KEY `invoices_patientId_fkey` (`patientId`);

--
-- Indexes for table `lab_cases`
--
ALTER TABLE `lab_cases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lab_cases_clinicId_fkey` (`clinicId`),
  ADD KEY `lab_cases_patientId_fkey` (`patientId`);

--
-- Indexes for table `odontograms`
--
ALTER TABLE `odontograms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `odontograms_patientId_key` (`patientId`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `patients_userId_key` (`userId`),
  ADD KEY `patients_clinicId_fkey` (`clinicId`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plans_name_key` (`name`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prescriptions_patientId_fkey` (`patientId`);

--
-- Indexes for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refresh_tokens_userId_fkey` (`userId`);

--
-- Indexes for table `saas_invoices`
--
ALTER TABLE `saas_invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `saas_invoices_stripeInvoiceId_key` (`stripeInvoiceId`),
  ADD KEY `saas_invoices_clinicId_fkey` (`clinicId`);

--
-- Indexes for table `statements`
--
ALTER TABLE `statements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscriptions_clinicId_key` (`clinicId`),
  ADD UNIQUE KEY `subscriptions_stripeSubscriptionId_key` (`stripeSubscriptionId`),
  ADD KEY `subscriptions_planId_fkey` (`planId`);

--
-- Indexes for table `treatment_plans`
--
ALTER TABLE `treatment_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `treatment_plans_patientId_fkey` (`patientId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_key` (`email`),
  ADD KEY `users_clinicId_fkey` (`clinicId`);

--
-- Indexes for table `waitlist_items`
--
ALTER TABLE `waitlist_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `waitlist_items_clinicId_fkey` (`clinicId`);

--
-- Indexes for table `xray_files`
--
ALTER TABLE `xray_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `xray_files_patientId_fkey` (`patientId`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_logs`
--
ALTER TABLE `ai_logs`
  ADD CONSTRAINT `ai_logs_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `ai_logs_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `alerts`
--
ALTER TABLE `alerts`
  ADD CONSTRAINT `alerts_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `alerts_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_assignedAssistantId_fkey` FOREIGN KEY (`assignedAssistantId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_assignedDoctorId_fkey` FOREIGN KEY (`assignedDoctorId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_assignedHygienistId_fkey` FOREIGN KEY (`assignedHygienistId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_dentistId_fkey` FOREIGN KEY (`dentistId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `audit_logs_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `chairside_sessions`
--
ALTER TABLE `chairside_sessions`
  ADD CONSTRAINT `chairside_sessions_appointmentId_fkey` FOREIGN KEY (`appointmentId`) REFERENCES `appointments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chairside_sessions_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `clinical_notes`
--
ALTER TABLE `clinical_notes`
  ADD CONSTRAINT `clinical_notes_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `crown_cases`
--
ALTER TABLE `crown_cases`
  ADD CONSTRAINT `crown_cases_caseId_fkey` FOREIGN KEY (`caseId`) REFERENCES `lab_cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `implant_cases`
--
ALTER TABLE `implant_cases`
  ADD CONSTRAINT `implant_cases_caseId_fkey` FOREIGN KEY (`caseId`) REFERENCES `lab_cases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `insurance_checks`
--
ALTER TABLE `insurance_checks`
  ADD CONSTRAINT `insurance_checks_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `invoices_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `lab_cases`
--
ALTER TABLE `lab_cases`
  ADD CONSTRAINT `lab_cases_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lab_cases_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `odontograms`
--
ALTER TABLE `odontograms`
  ADD CONSTRAINT `odontograms_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `patients_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD CONSTRAINT `refresh_tokens_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `saas_invoices`
--
ALTER TABLE `saas_invoices`
  ADD CONSTRAINT `saas_invoices_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `subscriptions_planId_fkey` FOREIGN KEY (`planId`) REFERENCES `plans` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `treatment_plans`
--
ALTER TABLE `treatment_plans`
  ADD CONSTRAINT `treatment_plans_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `waitlist_items`
--
ALTER TABLE `waitlist_items`
  ADD CONSTRAINT `waitlist_items_clinicId_fkey` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `xray_files`
--
ALTER TABLE `xray_files`
  ADD CONSTRAINT `xray_files_patientId_fkey` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
