---
name: tech stack
description: Approved technology stack and package list for all Bizzie technology agents. No package outside this list may be introduced without explicit approval.
---

# Bizzie Technology Stack

This document serves as the **Single Source of Truth** for the tools, libraries, and services used in the Bizzie application. All Agents (Architects, Builders, Testers) must reference this file before adding new dependencies.

## 1. Development Environment
* **IDEs:** Claude Code, VS Code, Cursor
* **Language:** Dart (Latest Stable, SDK ^3.8.0)
* **Framework:** Flutter (Latest Stable)

## 2. Core Architecture & Frontend
* **Architecture Pattern:** Feature-Driven Clean Architecture (Data / Domain / Presentation)
* **State Management:** `flutter_bloc` (v9+) — **BLoC with Events** (not Cubit)
* **State / Event Models:** `freezed` (union types + pattern matching) — used for ALL state, event, domain model, and DTO classes
* **Functional Programming:** `dartz` (`Either<Failure, T>`, `Option`)
* **Navigation/Routing:** `go_router` (v17+)
* **Dependency Injection:** `get_it` + `injectable` (annotation-driven — never manual registration)
* **Charts & Graphs:** `syncfusion_flutter_charts` (Standard for all data visualisation)
* **Generative UI:** `genui` + `genui_firebase_ai`
* **Local Storage:** `shared_preferences`
* **Cloud Functions:** Firebase Cloud Functions (`cloud_functions`)
* **Networking:** `dio` (v5+), `connectivity_plus`, `internet_connection_checker_plus`

## 3. Backend & Infrastructure (Firebase)
* **Base Core:** `firebase_core`
* **Authentication:** `firebase_auth`, `google_sign_in`, `sign_in_with_apple`
* **Database:** Cloud Firestore (`cloud_firestore`) — primary data store
* **Cloud Functions/Tasks:** Google Cloud Platform (Scheduled Tasks)
* **Storage:** Firebase Storage (`firebase_storage`)

## 4. Security & Secrets
* **RASP (Runtime App Self Protection):** `freerasp` (Detects rooting, tampering, hooks)
* **Secrets Management:** `envied` & `envied_generator` (Obfuscated API keys in binary)

## 5. Operations & Telemetry
* **Analytics:** `firebase_analytics` — always accessed via `IAnalyticsService`, never directly
* **Crash Reporting:** `firebase_crashlytics`
* **Logging:** `logging` (wrapped in `BizzieLogger`)
* **A/B Testing:** `firebase_remote_config`
* **Notifications:** `firebase_messaging` (FCM), `flutter_local_notifications`

## 6. External Integrations & APIs
* **Financial Data:** Financial Modeling Prep API
* **Deep Linking:** Branch.io (`url_launcher`)
* **AI/LLM:** Google Gemini API (`firebase_ai`), `genui`, `genui_firebase_ai`
* **In-App Purchases / Subscriptions:** RevenueCat (`purchases_flutter`)
* **Review Prompt:** `in_app_review`

## 7. CI/CD Pipeline
* **Continuous Integration (CI):** GitHub Actions
* **Continuous Delivery (CD):** Firebase App Distribution

## 8. Styling & Design System
* **Theme Source:** `lib/app/themes/app_theme.dart`
* **Color Palette:** `lib/app/themes/app_colors.dart` (Strict Source of Truth)
* **Typography:** `lib/app/themes/app_text_styles.dart` (Strict Source of Truth)
    * **Rule:** Do NOT use `GoogleFonts` or inline `TextStyle`. Always define a constant in `AppTextStyles` and reference it.
* **UI Components:** `flutter_svg`, `cached_network_image`, `smooth_page_indicator`, `custom_refresh_indicator`, `flutter_native_splash`

## 9. Utilities & Helpers
* **Device Info:** `device_info_plus`, `package_info_plus`
* **Permissions:** `permission_handler`
* **Date & Time:** `intl`, `timeago`, `timezone`
* **Collections & Async:** `collection`, `async`, `rxdart`, `bloc_concurrency`
* **Others:** `path_provider`, `nanoid`

## 10. Development & Testing
* **Linting:** `flutter_lints`
* **Code Generation:** `build_runner`, `freezed`, `json_serializable`, `injectable_generator`, `envied_generator`
    * **Rule:** Run `dart run build_runner build --delete-conflicting-outputs` after ANY `@freezed`, `@injectable`, or `json_serializable` change — this applies to BOTH domain and data layers.
* **Unit / BLoC Testing:** `flutter_test`, `mocktail`, `bloc_test`
* **Integration / Fake:** `fake_cloud_firestore`, `fake_async`
* **Asset / Icons:** `flutter_launcher_icons`

## Agent Guidelines
* **StateArchitect:** Use `flutter_bloc` with `@freezed` events and states. Always BLoC with events — never Cubit. Prefer `@freezed` unions over sealed classes or Equatable.
* **DataBuilder:** Use `FirestoreService` for all Firestore access. Use `@freezed` + `json_serializable` for all DTOs. Use `injectable` annotations for DI — never manual `GetIt` registration.
* **DomainBuilder:** All domain models `@freezed`. Use cases implement `UseCase<Result, Params>`. Repository interfaces return `Either<Failure, T>`.
* **AnalyticsBuilder:** Feature-scoped `@lazySingleton` tracker class in `presentation/analytics/`. Uses `IAnalyticsService`. Never calls Firebase Analytics directly.
* **TestBuilder:** Use `blocTest` for BLoC tests. Mock naming `MockXxx` (public). Test naming `[Method]_[Scenario]_[ExpectedBehavior]`. `setUpAll` for `registerFallbackValue`.
* **SecOps:** All secrets in `Envied` configs — never hardcoded.
