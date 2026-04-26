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

### 1. User Login

* Simple authentication system
* Redirects user to dashboard after successful login

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
* Stores reminders in local database
* Integrated with local notification system

### 7. Emergency Card

* Displays critical patient information in one screen
* Quick access during urgent situations

---

## Technologies Used

* **Frontend:** Flutter (Dart)
* **Database:** SQLite (sqflite)
* **Notifications:** flutter_local_notifications
* **QR Code:** qr_flutter
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
<img width="175" height="377" alt="Screenshot 2026-04-26 235022" src="https://github.com/user-attachments/assets/856ea1ba-3498-4d15-8df2-2ac262f08cbf" />
<img width="173" height="374" alt="Screenshot 2026-04-26 235111" src="https://github.com/user-attachments/assets/93f25ca9-4c91-4208-9c1b-84751a7ed448" />
<img width="172" height="377" alt="Screenshot 2026-04-26 235259" src="https://github.com/user-attachments/assets/571df2e8-6b2e-4f02-9ddb-65e47216e4db" />

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

<img width="173" height="377" alt="Screenshot 2026-04-26 235759" src="https://github.com/user-attachments/assets/d00e9072-0f5f-4131-8bd4-c652dd041ac9" />
<img width="172" height="378" alt="Screenshot 2026-04-26 235915" src="https://github.com/user-attachments/assets/cb1908e1-3cfa-493c-943f-a3e863bbda57" />

---

## Key Functionality Flow

1. User logs in
2. Creates health profile
3. Uploads medical documents
4. AI Score evaluates preparedness
5. Emergency Card displayed
6. QR code generated for emergency use
7. Reminders help maintain health routine

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
