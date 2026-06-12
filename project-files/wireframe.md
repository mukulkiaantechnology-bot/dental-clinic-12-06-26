# 🦷 Dental HMS - Frontend Wireframe & Flow

---

# 🔐 1. AUTHENTICATION

## Login Roles:

* Dentist
* Assistant
* Hygienist
* Front Desk
* Billing
* Clinic Owner
* Patient

---

# 👨‍⚕️ 2. DENTIST PANEL

## Dashboard

* Today’s Appointments
* Pending Treatments
* Alerts (AI Insights)

## Patient Module

* Patient List
* Search Patient
* Patient Profile

### Inside Patient Profile:

#### Tabs:

1. Overview
2. Medical History
3. Treatment Plan
4. Notes ⭐ (AI ENABLED)

   * Generate AI Note
   * Voice to Note
5. X-Ray ⭐ (AI ENABLED)
6. Prescription ⭐ (Drug Safety AI)

---

# 🧑‍⚕️ 3. ASSISTANT PANEL

## Dashboard

* Assigned Tasks
* Upcoming Appointments

## Patient Access

* View Patient Profile
* Add Basic Notes (AI LIMITED)

---

# 🧼 4. HYGIENIST PANEL

## Dashboard

* Daily Patient Queue

## Modules:

* Perio Chart ⭐ (AI Supported)
* Cleaning Records

## AI Recall Suggestions ⭐

* Overdue Patients List
* Suggested Follow-ups

---

# 🧾 5. FRONT DESK PANEL

## Dashboard

* Appointment Calendar
* Patient Check-in

## Appointment Module

* Book Appointment
* Reschedule
* Cancel

## AI Scheduling ⭐

* No-show Prediction
* Smart Replacement Suggestions

---

# 💰 6. BILLING PANEL

## Dashboard

* Pending Payments
* Completed Transactions

## Billing Module

* Generate Invoice
* Payment Tracking

## AI Highlights

* High Value Patients
* Unpaid Alerts

---

# 👑 7. CLINIC OWNER PANEL

## Dashboard ⭐ (AI HEAVY)

* Revenue Overview
* AI Insights:

  * Untreated Value
  * Patient Drop-offs
  * Monthly Trends

## Reports

* Financial Reports
* Patient Reports

## Communication

* AI Recall Campaigns
* Notifications

---

# 🧍‍♂️ 8. PATIENT PANEL

## Dashboard

* Upcoming Appointments
* Prescriptions

## AI Suggestions ⭐

* Next Visit Reminder
* Treatment Recommendations

---

# 🤖 9. GLOBAL AI COPILOT

## Available For:

* Dentist
* Owner
* Front Desk

## UI:

* Floating Button (Bottom Right)

## Features:

* Ask anything:

  * “Show overdue patients”
  * “Today’s revenue”
  * “Pending treatments”

---

# 🚫 10. EXCLUDED MODULES

## Pharmacy ❌

* Not included in current scope
* Can be added later as separate module

---

# 🧠 AI FEATURE SUMMARY

| Feature       | Role            | Location        |
| ------------- | --------------- | --------------- |
| AI Notes      | Dentist         | Patient → Notes |
| AI X-Ray      | Dentist         | Patient → X-Ray |
| Drug Safety   | Dentist         | Prescription    |
| AI Recall     | Owner/Hygienist | Communication   |
| AI Scheduling | Front Desk      | Calendar        |
| AI Business   | Owner           | Dashboard       |
| AI Copilot    | Multiple        | Global          |

---

# 📍 FINAL STRUCTURE FLOW

Login → Role  Dashboard → Modules → AI Features → Actions

---

# 🚀 NEXT STEP

* Convert this into:

  * API structure
  * Database schema
  * Backend flow
