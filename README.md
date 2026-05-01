# MediVault – AI-Enabled Health Emergency and Medical Preparedness App

## Overview

MediVault is a mobile application developed using Flutter that helps users manage medical data, respond effectively during emergencies, and maintain health routines through reminders and intelligent analysis.

The application provides a centralized system to store medical records, maintain a health profile, generate an emergency QR code, and calculate an AI-based preparedness score based on disease-specific document requirements.

---

## Problem Statement

In many real-life situations, medical records are scattered or unavailable during emergencies. This leads to delays in treatment due to missing critical information such as blood group, allergies, and medical history.

Additionally, patients often miss medications and appointments, which negatively impacts health outcomes. Existing solutions do not combine document management, emergency access, and smart reminders into a single system.

---

## Features

### 1. User Authentication System

* User registration with dynamic input (no hardcoded credentials)
* Login using registered email and password
* Forgot Password functionality to retrieve account
* Redirects user to dashboard after successful login
* User data stored securely using SQLite database

### 2. Health Profile Management

* Stores:

  * Name
  * Age
  * Blood Group
  * Allergies
  * Disease/Condition
* Data stored locally using SQLite

### 3. Medical Document Vault

* Upload and store medical files (PDFs, images)
* Local file picker support
* View and delete uploaded documents

### 4. AI Health Preparedness Score

* Calculates score out of 100 based on:

  * Health profile completion
  * Uploaded documents
  * Disease-specific required documents
* Uses predefined dataset (20 diseases × 5 documents each)
* Displays missing documents clearly

### 5. Emergency QR Code

* Generates QR code containing patient details
* Can be scanned without login
* Useful during emergencies for quick access

### 6. Smart Reminder System

* Add medicine or appointment reminders
* Select time for reminders (time-based scheduling)
* Stores reminders in local database
* Instant notification shown when reminder is added
* Scheduled notifications triggered at selected time (device dependent)

### 7. Notification System

* Local notifications using flutter_local_notifications
* Instant alerts for reminders
* Scheduled alerts for medicines and appointments
* Works based on device permissions and system settings

### 8. Emergency Card

* Displays critical patient information in one screen
* Quick access during urgent situations
---

## Technologies Used

* **Frontend:** Flutter (Dart)
* **Database:** SQLite (sqflite)
* **Notifications:** flutter_local_notifications
* **QR Code:** qr_flutter
* **Authentication:** Local SQLite-based user management
* **IDE:** Android Studio / VS Code

---

## Project Structure

```
lib/
├── main.dart
│
├── data/
│   ├── database_helper.dart
│   ├── disease_data.dart
│   └── user_profile.dart
│
├── services/
│   └── notification_service.dart
│
├── screens/
│   ├── login_screen.dart
│   ├── dashboard_screen.dart
│   ├── health_profile_screen.dart
│   ├── upload_documents_screen.dart
│   ├── ai_score_screen.dart
│   ├── emergency_card_screen.dart
│   ├── qr_screen.dart
│   └── reminders_screen.dart

```

---

## How to Run the Project

1. Install Flutter and Android Studio
2. Open project in VS Code or Android Studio
3. Run the following commands:

```
flutter pub get
flutter run
```

4. Launch an Android Emulator or connect a real device

---

## Screenshots

### Login Screen

<img width="172" height="377" alt="Screenshot 2026-05-01 185637" src="https://github.com/user-attachments/assets/262f82f7-6745-4105-97dd-a5b610d86bc1" />
<img width="176" height="377" alt="Screenshot 2026-05-01 190020" src="https://github.com/user-attachments/assets/c160312a-01cb-4e39-b868-ac1dd7595edd" />
<img width="178" height="378" alt="Screenshot 2026-05-01 190804" src="https://github.com/user-attachments/assets/73747ea7-69f3-4835-adf3-9c137f090cac" />
<img width="170" height="379" alt="Screenshot 2026-05-01 190920" src="https://github.com/user-attachments/assets/90169a68-c18f-42c4-8f7e-a68b0f05f7d1" />
<img width="174" height="376" alt="Screenshot 2026-05-01 191040" src="https://github.com/user-attachments/assets/e8e6a4a2-87fb-4318-8816-2fdd488637e1" />

### Registration Screen

<img width="170" height="374" alt="Screenshot 2026-05-01 190103" src="https://github.com/user-attachments/assets/43a72b80-d3cf-41fc-8d93-8a644f66aabc" />
<img width="173" height="378" alt="Screenshot 2026-05-01 190300" src="https://github.com/user-attachments/assets/6aa4c98c-ca32-4c77-9b9d-a162e0575837" />
<img width="178" height="378" alt="Screenshot 2026-05-01 190804" src="https://github.com/user-attachments/assets/dbcb4e42-48c1-4906-bbf3-9ca9a3b0f0c8" />
<img width="172" height="377" alt="Screenshot 2026-05-01 190340" src="https://github.com/user-attachments/assets/a20d392d-4a5d-43ba-9eda-f19e4f3ae18d" />

### Dashboard

<img width="175" height="374" alt="Screenshot 2026-04-26 235329" src="https://github.com/user-attachments/assets/92286044-0b2c-4c5e-9cd2-41f68f8f0cc5" />

### Health Profile

<img width="170" height="376" alt="Screenshot 2026-04-26 235442" src="https://github.com/user-attachments/assets/8418ef95-25d6-4678-90d7-e931d9a954b4" />
<img width="170" height="374" alt="Screenshot 2026-04-26 235508" src="https://github.com/user-attachments/assets/911f12d9-fc0a-4080-bec3-7b299e3ea33b" />

### Document Upload

<img width="171" height="377" alt="Screenshot 2026-04-26 235540" src="https://github.com/user-attachments/assets/60e56f82-eace-4f57-a992-5cc3c6a01de0" />
<img width="175" height="377" alt="Screenshot 2026-04-26 235607" src="https://github.com/user-attachments/assets/91fce1cb-0b4f-4ad9-97bd-b7b9bcbb1b10" />
<img width="173" height="379" alt="Screenshot 2026-04-26 235707" src="https://github.com/user-attachments/assets/2cdb370c-f959-4c55-9ab6-d92a01ecf4ab" />

### Emergency Card

<img width="172" height="378" alt="Screenshot 2026-04-26 235732" src="https://github.com/user-attachments/assets/c3a2cb76-c356-45df-aba9-caeddb6e9c80" />

### AI Score
<img width="173" height="376" alt="Screenshot 2026-04-27 000012" src="https://github.com/user-attachments/assets/f9c0499a-020d-4b42-8ab3-a455f9ff6fc6" />

### QR Code

<img width="172" height="378" alt="Screenshot 2026-04-26 235948" src="https://github.com/user-attachments/assets/d55c4214-a197-4525-a765-af05f69edd13" />

### Reminders

<img width="173" height="378" alt="Screenshot 2026-05-01 212508" src="https://github.com/user-attachments/assets/d2bd7ccf-7597-427b-b7d5-7e5907f6371e" />
<img width="173" height="377" alt="Screenshot 2026-05-01 212615" src="https://github.com/user-attachments/assets/3b3f8eb1-dacb-4cf4-9eee-f3aa76001147" />
<img width="176" height="378" alt="Screenshot 2026-05-01 212642" src="https://github.com/user-attachments/assets/c02d1840-0493-4d5d-bf8d-454152ccef8b" />
<img width="172" height="372" alt="Screenshot 2026-05-01 212721" src="https://github.com/user-attachments/assets/e84b75b3-e954-4a98-b878-1e2b5083f4d5" />
<img width="169" height="377" alt="Screenshot 2026-05-01 212755" src="https://github.com/user-attachments/assets/270b842e-fd37-4b41-b1ad-b02cc75c3a28" />

---

## Key Functionality Flow

1.User registers a new account
2.User logs in using credentials
3.Health profile is created and stored
4.Medical documents are uploaded and managed
5.AI Score evaluates preparedness based on disease data
6.Emergency Card displays key information
7.QR code enables emergency access
8.Reminders are scheduled for medicines/appointments
9.Notifications alert users at the required time

---

## Future Enhancements

* SMS emergency alerts to family members
* Cloud storage integration
* Doctor/hospital integration
* Real AI model instead of rule-based scoring
* Secure authentication system

---

## Conclusion

MediVault provides a practical solution for managing medical data, improving emergency response, and maintaining consistent health practices. The application combines multiple healthcare functionalities into a single platform, making it useful for both daily use and critical situations.

---
