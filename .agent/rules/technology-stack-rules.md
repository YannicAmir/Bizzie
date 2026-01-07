---
trigger: always_on
---

# Bizzie Technology Stack

This document serves as the **Single Source of Truth** for the tools, libraries, and services used in the Bizzie application. All Agents (Architects, Builders, Testers) must reference this file before adding new dependencies.

## 1. Development Environment
* **IDE:** Google Antigravity (Agentic IDE)
* **Language:** Dart (Latest Stable)
* **Framework:** Flutter (Latest Stable)

## 2. Core Architecture & Frontend
* **Architecture Pattern:** Feature-Driven Clean Architecture (Data/Domain/Presentation)
* **State Management:** `flutter_bloc` + `freezed` (for State Unions & Pattern Matching)
* **Data Models:** `freezed` + `json_annotation` + `json_serializable`
* **Navigation/Routing:** `go_router`
* **Dependency Injection:** `get_it` + `injectable`
* **Charts & Graphs:** `syncfusion_flutter_charts` (Standard for all data visualization)
* **Generative UI:** `genui` + `genui_firebase_ai`
* **Local Storage:** `shared_preferences`

## 3. Backend & Infrastructure (Firebase)
* **Authentication:** `firebase_auth` (Email, Google, Apple)
* **Database:** Cloud Firestore (`cloud_firestore`)
* **Cloud Functions/Tasks:** Google Cloud Platform (Scheduled Tasks)
* **Storage:** Firebase Storage 

## 4. Security & Secrets
* **RASP (Runtime App Self Protection):** `freerasp` (Detects rooting, tampering, hooks)
* **Secrets Management:** `envied` & `envied_generator` (Obfuscated API keys in binary)

## 5. Operations & Telemetry
* **Analytics:** `firebase_analytics` & Google Analytics
* **Crash Reporting:** `firebase_crashlytics`
* **Logging:** `logging`
* **A/B Testing:** `firebase_remote_config` (A/B Testing)
* **Notifications:** `firebase_messaging` (FCM)

## 6. External Integrations & APIs
* **Financial Data:** Financial Modeling Prep API
* **Deep Linking:** Branch.io
* **AI/LLM:** Google Gemini API, genui, genui_firebase_ai & firebase_ai
* **In-App Purchases / Subscriptions:** RevenueCat

## 7. CI/CD Pipeline
* **Continuous Integration (CI):** GitHub Actions
* **Continuous Delivery (CD):** Firebase App Distribution

## 8. Styling & Design System
* **Theme Source:** `lib/app/themes/app_theme.dart`
* **Color Palette:** `lib/app/themes/app_colors.dart` (Strict Source of Truth)
* **Typography:** `lib/app/themes/app_text_styles.dart` (Strict Source of Truth)
    * **Rule:** Do NOT use `GoogleFonts` or `TextStyle` inline. Always define a constant in `AppTextStyles` and reference it.

## Agent Guidelines
* **StateArchitect:** Use `flutter_bloc` with `freezed` unions for all logic. Do not use Equatable.
* **MockBuilder:**
    * Use `go_router` for all navigation.
    * Use `syncfusion_flutter_charts` for any chart/graph requirements. Do not use `fl_chart` or `charts_flutter`.
* **BackendConnector:** All data persists to Firestore unless it is financial data (fetch from API).
* **SecOps:** Ensure all keys are stored in `Envied` configs, never hardcoded.