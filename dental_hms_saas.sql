-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2026 at 07:39 AM
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

--
-- Dumping data for table `ai_logs`
--

INSERT INTO `ai_logs` (`id`, `clinicId`, `userId`, `module`, `prompt`, `response`, `createdAt`) VALUES
('177958c4-0cc6-4d25-b16b-24ca2aaec106', 'clinic-1', 'usr-clinicowner', 'summarize', 'Notes: \"Patient presented with localized minor swelling on tooth #19. Drank ice cold water and felt immediate throbbing pain. Dental crown checked for leakage.\".', '{\"status\":\"FALLBACK\",\"tokenUsage\":null,\"data\":{\"summary\":[\"Patient presented with localized minor swelling on tooth #19. Drank ice cold ...\"]}}', '2026-06-12 12:27:05.306'),
('521223d0-c84f-441d-96d1-2f30e556260f', 'clinic-1', 'usr-clinicowner', 'alerts-analyze', 'Patient: Alex Johnson (ID: pat-3). Symptoms: \"Routine prophylaxis check\". History: \"Highly allergic to Penicillin and latex materials\".', '{\"status\":\"FALLBACK\",\"tokenUsage\":null,\"data\":{\"hasAlert\":true,\"alertMessage\":\"Critical Safety Alert: Patient has documented Penicillin/Latex allergies. Verify scripts.\",\"severity\":\"critical\"}}', '2026-06-12 12:27:05.330'),
('8ce9c049-bcca-4a36-b1a0-2ea73383e491', 'clinic-1', 'usr-clinicowner', 'diagnosis', 'Patient Age: 42. Symptoms: \"severe throbbing pain on molar jaw\". Medical History: \"Penicillin allergy, regular dental hygiene smoker\". Previous Treatments: \"None\". Dentist Notes: \"Clinical presentation check\".', '{\"status\":\"FALLBACK\",\"tokenUsage\":null,\"data\":{\"conditions\":[\"Irreversible Pulpitis\",\"Acute Apical Periodontitis\"],\"riskLevel\":\"High\",\"recommendation\":\"Endodontic therapy (root canal treatment) and post-treatment crown placement suggested.\"}}', '2026-06-12 12:27:05.263'),
('a6098475-a67e-4f2c-9864-f07aa9537672', 'clinic-1', 'usr-clinicowner', 'treatment-plan', 'Diagnosis: \"Irreversible Pulpitis\". History: \"No allergies\". Notes: \"Requires root canal prep\".', '{\"status\":\"FALLBACK\",\"tokenUsage\":null,\"data\":{\"plan\":[\"Administer local block anesthesia\",\"Establish endodontic access cavity\",\"Extirpate diseased pulpal tissue\",\"Debride, clean, and shape root canals using rotary files\",\"Irrigate using sodium hypochlorite\",\"Obturate root canals with gutta-percha sealant\",\"Apply temporary sealing cement (Cavit)\"],\"duration\":\"2 sessions\"}}', '2026-06-12 12:27:05.287'),
('b0382464-f591-4f20-954a-5f93de785d44', 'clinic-1', 'usr-clinicowner', 'diagnosis', 'Patient Age: 42. Symptoms: \"severe throbbing pain on molar jaw\". Medical History: \"Penicillin allergy, regular dental hygiene smoker\". Previous Treatments: \"None\". Dentist Notes: \"Clinical presentation check\".', '{\"status\":\"FALLBACK\",\"tokenUsage\":null,\"data\":{\"conditions\":[\"Irreversible Pulpitis\",\"Acute Apical Periodontitis\"],\"riskLevel\":\"High\",\"recommendation\":\"Endodontic therapy (root canal treatment) and post-treatment crown placement suggested.\"}}', '2026-06-12 12:27:05.239');

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
('18b62163-7250-483f-8765-29f0483e771f', 'clinic-1', 'usr-dentist', 'dentist', 'New Patient Assigned', 'Patient Alex Johnson has been assigned to you.', 'info', 0, '2026-06-12 13:03:11.313'),
('1c94e52f-3967-451e-9c79-636de2e6c218', 'clinic-1', NULL, 'front_desk', 'Appointment Completed', 'Appointment for James Carter is completed.', 'success', 0, '2026-06-12 13:14:12.450'),
('62fc0a9b-c1e1-4e96-b16b-3e8f3cf96fc1', 'clinic-1', NULL, 'front_desk', 'Patient Checked In', 'Patient James Carter has checked in and is ready.', 'info', 0, '2026-06-12 13:09:30.794'),
('64893422-05ef-478c-a1bf-fe9cc591747f', 'clinic-1', 'usr-dentist', 'dentist', 'Treatment Stage Updated', 'Appointment for James Carter is now IN PROGRESS.', 'info', 0, '2026-06-12 13:10:17.776'),
('68355fa9-38d6-4291-89b0-0932e69fa09c', 'clinic-1', NULL, 'dentist', 'High-Risk Clinical Warning', 'Clinical AI detected high-risk condition: \"Irreversible Pulpitis\" for patient Alex Johnson. Urgent treatment check suggested.', 'critical', 0, '2026-06-12 12:27:05.233'),
('765f5514-74bf-483a-848b-83256fe5bdc6', 'clinic-1', NULL, 'front_desk', 'Patient In Treatment', 'Patient James Carter is now in treatment stage: IN PROGRESS.', 'info', 0, '2026-06-12 13:10:17.783'),
('a5137ae9-5848-40af-a890-44c092333760', 'clinic-1', NULL, 'billing_staff', 'Billing Triggered', 'Billing triggered for patient James Carter\'s completed treatment.', 'success', 0, '2026-06-12 13:14:12.459'),
('ae6d8489-017b-48a7-a244-bf615b8dad6a', 'clinic-1', NULL, 'clinic_owner', 'Clinical Workflow Advanced', 'Appointment for James Carter advanced to IN PROGRESS.', 'info', 0, '2026-06-12 13:10:17.791'),
('af581985-a560-4aa8-8c04-a0a864fd5933', 'clinic-1', 'usr-dentist', 'dentist', 'New Patient Assigned', 'Patient James Carter has been assigned to you.', 'info', 0, '2026-06-12 13:05:40.388'),
('c68abe5d-9ea8-4172-af9f-e0fbce5bc93b', 'clinic-1', NULL, 'front_desk', 'New Appointment Scheduled', 'A new appointment has been scheduled for patient Alex Johnson.', 'info', 0, '2026-06-12 13:03:11.293'),
('cbf4c730-c203-43c9-9aed-32c7449fbd84', 'clinic-1', NULL, 'front_desk', 'New Appointment Scheduled', 'A new appointment has been scheduled for patient Mary Watson.', 'info', 0, '2026-06-12 13:20:44.012'),
('d05e3ce6-3e01-4f54-a713-c4d2f356b054', 'clinic-1', NULL, 'front_desk', 'Patient Checked In', 'Patient Mary Watson has checked in and is ready.', 'info', 0, '2026-06-12 13:22:27.925'),
('d5d2c18e-e14f-49ba-b1b1-2cb0c19ed2f9', 'clinic-1', NULL, 'front_desk', 'New Appointment Scheduled', 'A new appointment has been scheduled for patient James Carter.', 'info', 0, '2026-06-12 13:05:40.372'),
('df1fa684-aa08-4997-9372-726de7078748', 'clinic-1', 'usr-dentist', 'dentist', 'New Patient Assigned', 'Patient Mary Watson has been assigned to you.', 'info', 0, '2026-06-12 13:20:44.033'),
('e795fdc8-1fe9-42b4-bbe8-d53beecf595c', 'clinic-1', NULL, 'clinic_owner', 'Appointment Completed', 'Clinician completed the treatment session for James Carter.', 'success', 0, '2026-06-12 13:14:12.468');

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
('375f0cc0-ef22-4e5e-abad-1ac5a9051f14', 'clinic-1', 'pat-1', 'usr-dentist', 'James Carter', 'Dr. Michael Chen, DDS', NULL, '2026-06-12', '08:00', 45, 'Completed', 'Cleaning', 'sdfasdf', 'hygienist', '2026-06-12 13:05:40.344', '2026-06-12 13:56:55.354', NULL, 'usr-dentist', NULL, 'COMPLETED'),
('a47e12e7-820d-491c-aeb6-1c00d94dc535', 'clinic-1', 'pat-2', 'usr-dentist', 'Mary Watson', 'Dr. Michael Chen, DDS', NULL, '2026-06-12', '09:00', 45, 'Checked_In', 'Crown', 'hedgh', 'dentist', '2026-06-12 13:20:43.980', '2026-06-12 13:22:27.911', NULL, 'usr-dentist', NULL, 'CHECKED_IN');

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
('39a8ea36-ce83-455d-b847-65fa42f48f52', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-12 12:54:55.791', '2026-06-12 12:54:55.792'),
('4243145c-b6f1-4cc1-8783-167a1b2fc570', NULL, 'usr-superadmin', 'Created new SaaS Pricing Plan: free plan ($0/mo)', 'Global', '2026-06-12 12:57:58.732', '2026-06-12 12:57:58.733'),
('4648e428-aa1d-4a63-8483-1d578f14cee1', NULL, 'usr-superadmin', 'Toggled AI recallSMS module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-12 12:54:56.492', '2026-06-12 12:54:56.494'),
('7495f6d2-b28e-4db7-aba8-0b6c213914f5', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-12 12:54:54.360', '2026-06-12 12:54:54.361'),
('9c79f729-5870-44e7-b919-c66a519d9b3c', NULL, 'usr-superadmin', 'Deleted SaaS invoice #de0d3cb5-c938-4e4f-9fc4-bece57353aeb for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-12 12:54:37.602', '2026-06-12 12:54:37.604'),
('aed98b69-7dcb-4665-bbd7-16f9c178c878', NULL, 'usr-superadmin', 'Toggled AI diagnostic module for Northside Family Dentistry', 'Northside Family Dentistry', '2026-06-12 12:54:57.152', '2026-06-12 12:54:57.155'),
('log-1', NULL, 'usr-superadmin', 'Upgraded Apex Orthodontics to Premium Plan', 'Apex Orthodontics & Pediatrics', '2026-06-08 09:12:00.000', '2026-06-12 12:01:29.280'),
('log-2', NULL, 'usr-superadmin', 'Enabled AI Diagnosis Module for Metropolitan Dental Care', 'Metropolitan Dental Care', '2026-06-08 08:45:00.000', '2026-06-12 12:01:29.296'),
('log-3', NULL, 'usr-superadmin', 'Registered new clinic location: Westside Pediatric Dental', 'Westside Pediatric Dental', '2026-06-07 14:20:00.000', '2026-06-12 12:01:29.307');

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
('35b0ac2b-f70a-4d39-94c9-a6135618a45a', 'clinic-1', 'pat-1', '[CHIEF COMPLAINT]\nPatient reports mild discomfort in the lower left jaw when chewing.\n\n[DIAGNOSIS]\nOcclusal caries detected on Tooth #19; localized gingival inflammation.\n\n[TREATMENT PERFORMED]\nAdministered local infiltration (2% Lidocaine with 1:100k Epinephrine). Completed composite restoration on Tooth #19. Excavated decay and applied bonding agent.\n\n[RECOMMENDATIONS]\nAvoid chewing hard foods on the lower left side for 24 hours. Maintain standard flossing and brush with fluoridated toothpaste twice daily. Follow up in 6 months.', 'usr-dentist', '2026-06-12 13:12:57.704', '2026-06-12 13:12:57.704');

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
('clinic-1', 'Metropolitan Dental Care', 'Downtown Seattle, WA', '(206) 555-0192', 'Active', 'Premium', 299, 94, '{\"diagnostic\":true,\"recallSMS\":true,\"workload\":true}', '2026-06-12 12:01:28.559', '2026-06-12 12:07:13.369'),
('clinic-2', 'Apex Orthodontics & Pediatrics', 'Bellevue, WA', '(425) 555-0143', 'Active', 'Premium', 299, 89, '{\"diagnostic\":true,\"recallSMS\":true,\"workload\":false}', '2026-06-12 12:01:28.576', '2026-06-12 12:01:28.576'),
('clinic-3', 'Northside Family Dentistry', 'Everett, WA', '(425) 555-0187', 'Active', 'Basic', 149, 81, '{\"diagnostic\":false,\"recallSMS\":false,\"workload\":false}', '2026-06-12 12:01:28.593', '2026-06-12 12:54:57.132'),
('clinic-4', 'Westside Pediatric Dental', 'Tacoma, WA', '(253) 555-0210', 'Suspended', 'Trial', 0, 78, '{\"diagnostic\":true,\"recallSMS\":false,\"workload\":false}', '2026-06-12 12:01:28.611', '2026-06-12 12:07:13.014');

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
('498effea-f200-470e-92b7-a18b80c47297', 'clinic-1', 'James Carter', 'ksdfj', '4545212', 'Pending', '', '2026-06-12 13:15:29.899');

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
('7828eadb-f6b5-48b3-be8c-891af66af461', 'clinic-1', 'pat-1', '{\"1\":\"Healthy\",\"2\":\"Healthy\",\"3\":\"Healthy\",\"4\":\"Healthy\",\"5\":\"Healthy\",\"6\":\"Healthy\",\"7\":\"Healthy\",\"8\":\"Crown\",\"9\":\"Healthy\",\"10\":\"Healthy\",\"11\":\"Healthy\",\"12\":\"Healthy\",\"13\":\"Healthy\",\"14\":\"Healthy\",\"15\":\"Healthy\",\"16\":\"Healthy\",\"17\":\"Healthy\",\"18\":\"Healthy\",\"19\":\"Healthy\",\"20\":\"Healthy\",\"21\":\"Healthy\",\"22\":\"Healthy\",\"23\":\"Healthy\",\"24\":\"Implant\",\"25\":\"Healthy\",\"26\":\"Healthy\",\"27\":\"Healthy\",\"28\":\"Healthy\",\"29\":\"Healthy\",\"30\":\"Healthy\",\"31\":\"Healthy\",\"32\":\"Healthy\"}', '2026-06-12 13:11:44.603', '2026-06-12 13:11:46.980');

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
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `vitals` text DEFAULT NULL,
  `allergies` varchar(191) DEFAULT NULL,
  `history` text DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `address` varchar(191) DEFAULT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `insuranceProvider` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `clinicId`, `userId`, `name`, `age`, `phone`, `email`, `status`, `vitals`, `allergies`, `history`, `createdAt`, `updatedAt`, `address`, `gender`, `insuranceProvider`) VALUES
('pat-1', 'clinic-1', 'usr-patient', 'James Carter', 45, '(206) 555-1212', 'patient@gmail.com', 'Active', 'BP: 120/80, Temp: 98.6 F, Pulse: 72 bpm', 'Penicillin', 'No systemic diseases. High hygiene compliance. Mild bruxism.', '2026-06-12 12:01:29.079', '2026-06-12 12:01:29.079', '123 Pine St, Seattle, WA', 'Male', 'MetLife Dental'),
('pat-2', 'clinic-1', NULL, 'Mary Watson', 34, '(206) 555-8989', 'mary.watson@gmail.com', 'Active', 'BP: 118/75, Temp: 98.2 F, Pulse: 68 bpm', 'Latex', 'Prefers local sedation. Mild gingivitis reported in lower mandibular segment.', '2026-06-12 12:01:29.096', '2026-06-12 12:01:29.096', '456 Oak St, Seattle, WA', 'Female', 'Delta Dental'),
('pat-4', 'clinic-1', NULL, 'Sarah Jenkins', 38, '(206) 555-7788', 's.jenkins@hms-saas.com', 'Active', 'BP: 115/70, Temp: 98.4 F', '', 'Standard comprehensive review. Normal health chart.', '2026-06-12 12:01:29.116', '2026-06-12 12:01:29.116', '101 Broadway, Seattle, WA', 'Female', 'Guardian Dental'),
('pat-5', 'clinic-2', NULL, 'Robert Chen', 52, '(425) 555-9012', 'robert@chen.org', 'Active', 'BP: 125/82, Temp: 98.7 F', 'Sulfa', 'Requires pre-medication before surgical procedures.', '2026-06-12 12:01:29.127', '2026-06-12 12:01:29.127', '202 Bellevue Way, Bellevue, WA', 'Male', 'Aetna PPO'),
('pat-6', 'clinic-2', NULL, 'Emily Davis', 26, '(425) 555-3456', 'emily.d@gmail.com', 'Active', 'BP: 110/68, Temp: 98.1 F', '', 'Occasional teeth sensitivity. Brushes twice daily.', '2026-06-12 12:01:29.137', '2026-06-12 12:01:29.137', '303 Red Wood Ave, Redmond, WA', 'Female', 'None');

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
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `price`, `features`, `maxClinics`, `maxUsers`, `maxPatients`, `createdAt`, `updatedAt`) VALUES
('plan-basic', 'Basic', 99, '[\"Core HMS\",\"Basic Reports\"]', 1, 5, 50, '2026-06-12 12:01:28.470', '2026-06-12 12:01:28.470'),
('plan-enterprise', 'Enterprise', 499, '[\"Core HMS\",\"Unlimited Reports\",\"AI Copilot Widget\",\"AI Recall SMS Campaigns\"]', 1, 9999, 99999, '2026-06-12 12:01:28.543', '2026-06-12 12:01:28.543'),
('plan-pro', 'Pro', 299, '[\"Core HMS\",\"Extended Reports\",\"AI Copilot Widget\"]', 1, 15, 500, '2026-06-12 12:01:28.526', '2026-06-12 12:01:28.526');

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
('e6427ebf-643f-4902-8d90-15914f7cc443', 'clinic-1', 'pat-1', 'Clindamycin 300mg', '500mg (1 capsule)', 'Three times daily', '7 days', '2026-06-12', '2026-06-12 13:12:47.767', '2026-06-12 13:12:47.767');

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
('02cc78ac-18cd-4100-a2aa-31384668846d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1jbGluaWNvd25lciIsImVtYWlsIjoiY2xpbmljb3duZXJAZ21haWwuY29tIiwicm9sZSI6ImNsaW5pY19vd25lciIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODEyNjcyMDYsImV4cCI6MTc4MTg3MjAwNn0.1epBVeF6_pdjWlR-3HL8t2fmxXj9kU8KpSVO7Zn0j-w', 'usr-clinicowner', '2026-06-19 12:26:46.722', '2026-06-12 12:26:46.724'),
('13e3d952-c86e-4a99-a51f-eb6a20bbe425', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1jbGluaWNvd25lciIsImVtYWlsIjoiY2xpbmljb3duZXJAZ21haWwuY29tIiwicm9sZSI6ImNsaW5pY19vd25lciIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODEyNjU5ODksImV4cCI6MTc4MTg3MDc4OX0.s0rxK0ImhieNvi3qBK6JqRqazlyL5wHeybsvZvoxhDw', 'usr-clinicowner', '2026-06-19 12:06:29.615', '2026-06-12 12:06:29.617'),
('77647cac-0880-421d-b9f8-4fcdb8997646', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1jbGluaWNvd25lciIsImVtYWlsIjoiY2xpbmljb3duZXJAZ21haWwuY29tIiwicm9sZSI6ImNsaW5pY19vd25lciIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODEyNjgzOTAsImV4cCI6MTc4MTg3MzE5MH0.YF3h7tTGYux9KXz35SHeP4PJFdQJ6zsp1kKmbPvgEPc', 'usr-clinicowner', '2026-06-19 12:46:30.190', '2026-06-12 12:46:30.192'),
('8a071c14-e31b-4518-918b-859667defec9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1jbGluaWNvd25lciIsImVtYWlsIjoiY2xpbmljb3duZXJAZ21haWwuY29tIiwicm9sZSI6ImNsaW5pY19vd25lciIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODEyNjYwMzMsImV4cCI6MTc4MTg3MDgzM30.ElAi7vwlFs7MqmPlDnMnX9GfDkzrZeTuSx4tdu0qhkw', 'usr-clinicowner', '2026-06-19 12:07:13.275', '2026-06-12 12:07:13.276'),
('93684fd9-e654-470e-b15d-5ecea8f0460e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1jbGluaWNvd25lciIsImVtYWlsIjoiY2xpbmljb3duZXJAZ21haWwuY29tIiwicm9sZSI6ImNsaW5pY19vd25lciIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODEyNjcyMjUsImV4cCI6MTc4MTg3MjAyNX0.aW1ZGME4e0HBnyLrJoMh9I-PsqFEzlJTe8fq_3K2BK4', 'usr-clinicowner', '2026-06-19 12:27:05.045', '2026-06-12 12:27:05.047'),
('a6c51ce2-f57b-4c74-8a4f-910ac3be4b13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1vd25lci1jbGluaWMtMyIsImVtYWlsIjoicmFqZXNoQHNoYXJtYWRlbnRhbC5jb20iLCJyb2xlIjoiY2xpbmljX293bmVyIiwiY2xpbmljSWQiOiJjbGluaWMtMyIsImlhdCI6MTc4MTI2NjAzMywiZXhwIjoxNzgxODcwODMzfQ.IbOKWOFirQg1lCcFXCSHLOZeh5XXh9GpB-Jb9T0cOlg', 'usr-owner-clinic-3', '2026-06-19 12:07:13.710', '2026-06-12 12:07:13.711'),
('c9891195-35a8-47c5-bc8d-6431e3d8981b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1vd25lci1jbGluaWMtNCIsImVtYWlsIjoiamFuZS5taWxsZXJAbWlsbGVyZGVudGFsLmNvbSIsInJvbGUiOiJjbGluaWNfb3duZXIiLCJjbGluaWNJZCI6ImNsaW5pYy00IiwiaWF0IjoxNzgxMjY2MDMzLCJleHAiOjE3ODE4NzA4MzN9.8di2dARHwK6GayanJpAIMWIRL3HDICs9ZdoCtnZDAHQ', 'usr-owner-clinic-4', '2026-06-19 12:07:13.544', '2026-06-12 12:07:13.546'),
('dd1276d8-ddd0-4270-bb21-ae9d76c057b6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1mcm9udGRlc2siLCJlbWFpbCI6ImZyb250ZGVza0BnbWFpbC5jb20iLCJyb2xlIjoiZnJvbnRfZGVzayIsImNsaW5pY0lkIjoiY2xpbmljLTEiLCJpYXQiOjE3ODEyNzMyODIsImV4cCI6MTc4MTg3ODA4Mn0.aRzO__WiTF56c6vWOh-GHYBg1VhCHs2lr_EfcRgaC64', 'usr-frontdesk', '2026-06-19 14:08:02.596', '2026-06-12 14:08:02.597'),
('f38a5e09-12ff-4904-89ae-0b7ea52b99fa', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzci1zdXBlcmFkbWluIiwiZW1haWwiOiJzdXBlcmFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsImNsaW5pY0lkIjpudWxsLCJpYXQiOjE3ODEyNjc5NjMsImV4cCI6MTc4MTg3Mjc2M30.-UmPEUNN9joPHIspL0wMV6GBIaEsP9o4E8_lRY520KM', 'usr-superadmin', '2026-06-19 12:39:23.455', '2026-06-12 12:39:23.459');

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
('7b3bc7d8-8e48-4666-af15-f08051a86152', 'clinic-1', 'Metropolitan Dental Care', 299, '2026-06-12', 'Paid', 'Pro', '2026-06-12 12:07:13.376', '2026-06-12 12:07:13.376', NULL),
('sinv-101', 'clinic-1', 'Metropolitan Dental Care', 499, '2026-06-01', 'Paid', 'Enterprise', '2026-06-12 12:01:29.233', '2026-06-12 12:01:29.233', NULL),
('sinv-102', 'clinic-2', 'Apex Orthodontics & Pediatrics', 299, '2026-06-01', 'Paid', 'Premium', '2026-06-12 12:01:29.242', '2026-06-12 12:01:29.242', NULL),
('sinv-103', 'clinic-3', 'Northside Family Dentistry', 149, '2026-06-01', 'Unpaid', 'Basic', '2026-06-12 12:01:29.258', '2026-06-12 12:01:29.258', NULL),
('sinv-104', 'clinic-4', 'Westside Pediatric Dental', 0, '2026-06-01', 'Trial', 'Trial', '2026-06-12 12:01:29.264', '2026-06-12 12:01:29.264', NULL);

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
('25914b93-c57e-453b-9299-21efeca9fa80', 'clinic-4', 'plan-basic', NULL, NULL, 'inactive', '2026-05-01 00:00:00.000', NULL, '2026-06-12 12:01:28.697', '2026-06-12 12:07:13.009'),
('89cf1f66-c661-4c7d-94d9-1da7fc46429d', 'clinic-1', 'plan-pro', 'cus_test_l2r5d', 'sub_test_o04bkn', 'active', '2026-06-12 12:07:13.361', '2026-07-12 12:07:13.361', '2026-06-12 12:01:28.627', '2026-06-12 12:07:13.362'),
('d4eb160f-159e-48df-aa9c-53d5c8ee1b68', 'clinic-2', 'plan-pro', NULL, NULL, 'active', '2026-05-01 00:00:00.000', NULL, '2026-06-12 12:01:28.644', '2026-06-12 12:01:28.644'),
('ddf8d7c9-73eb-4413-83f7-16bacc054f97', 'clinic-3', 'plan-basic', NULL, NULL, 'active', '2026-05-01 00:00:00.000', NULL, '2026-06-12 12:01:28.679', '2026-06-12 12:01:28.679');

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
('be967531-5da6-46c8-a83f-a814e49c4320', 'clinic-1', 'pat-1', '15', 'Porcelain PFM Crown', 950, 'Proposed', '2026-06-12 13:12:17.204', '2026-06-12 13:12:27.968'),
('e635db37-9635-4ee6-85a4-3e486ff8e4dc', 'clinic-1', 'pat-1', '14', 'Porcelain PFM Crown', 950, 'Proposed', '2026-06-12 13:12:00.671', '2026-06-12 13:12:26.017');

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
  `speciality` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `clinicId`, `name`, `email`, `password`, `role`, `status`, `avatarUrl`, `createdAt`, `updatedAt`, `phone`, `speciality`) VALUES
('usr-assistant', 'clinic-1', 'David Miller', 'assistant@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'dental_assistant', 'Approved', NULL, '2026-06-12 12:01:28.979', '2026-06-12 12:01:28.979', NULL, NULL),
('usr-billing', 'clinic-1', 'Samantha Billing', 'billingstaff@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'billing_staff', 'Approved', NULL, '2026-06-12 12:01:29.010', '2026-06-12 12:01:29.010', NULL, NULL),
('usr-clinicowner', 'clinic-1', 'Dr. Arthur Vance', 'clinicowner@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'clinic_owner', 'Approved', NULL, '2026-06-12 12:01:28.956', '2026-06-12 12:01:28.956', NULL, NULL),
('usr-dentist', 'clinic-1', 'Dr. Michael Chen, DDS', 'dentist@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'dentist', 'Approved', NULL, '2026-06-12 12:01:28.965', '2026-06-12 12:01:28.965', NULL, NULL),
('usr-frontdesk', 'clinic-1', 'Amara Lopez', 'frontdesk@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'front_desk', 'Approved', NULL, '2026-06-12 12:01:28.998', '2026-06-12 12:01:28.998', NULL, NULL),
('usr-hygienist', 'clinic-1', 'Elena Rostova, RDH', 'hygienist@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'hygienist', 'Approved', NULL, '2026-06-12 12:01:28.990', '2026-06-12 12:01:28.990', NULL, NULL),
('usr-lab', 'clinic-1', 'Marcus Vance', 'labcoordinator@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'lab_coordinator', 'Approved', NULL, '2026-06-12 12:01:29.024', '2026-06-12 12:01:29.024', NULL, NULL),
('usr-owner-clinic-3', 'clinic-3', 'Dr. Rajesh Sharma', 'rajesh@sharmadental.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'clinic_owner', 'Pending_Approval', NULL, '2026-06-12 12:01:29.047', '2026-06-12 12:07:15.731', NULL, NULL),
('usr-owner-clinic-4', 'clinic-4', 'Dr. Jane Miller', 'jane.miller@millerdental.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'clinic_owner', 'Suspended', NULL, '2026-06-12 12:01:29.060', '2026-06-12 12:07:15.737', NULL, NULL),
('usr-patient', 'clinic-1', 'James Carter', 'patient@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'patient', 'Approved', NULL, '2026-06-12 12:01:29.039', '2026-06-12 12:01:29.039', NULL, NULL),
('usr-superadmin', NULL, 'Sarah Jenkins', 'superadmin@gmail.com', '$2a$10$iOhnQwb/7.X6J3mJRB/6U.tVN5gDCFEjKXwp.4wPnHKXM7EWMZPEm', 'super_admin', 'Approved', NULL, '2026-06-12 12:01:28.943', '2026-06-12 12:01:28.943', NULL, NULL);

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
('a929afc7-9509-4ff5-a264-01e74cd815b4', 'clinic-1', 'pat-1', 'radiograph_audit.jpg', '2026-06-12', 'Right molar view checkup.', 0, '', '', '2026-06-12 13:12:34.937', '2026-06-12 13:12:34.937');

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
