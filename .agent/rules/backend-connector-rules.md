---
trigger: manual
description: Apply when connecting a feature to the backend
---

# Backend Connector Rules

* **Firestore:** MUST use `FirestoreService` (`lib/services/firestore_service.dart`). Distinct feature datasources should inject this service. **DO NOT** use `FirebaseFirestore.instance` directly.

* **Remote Config:** MUST use `ConfigService` (`lib/services/config_service.dart`) for all feature flagging and configuration. **DO NOT** use `FirebaseRemoteConfig.instance` directly.

* **External APIs:** MUST use the pre-configured `Dio` client (e.g., `@Named('FmpDio')`) injected via `get_it`. **DO NOT** instantiate `Dio` or `http` clients manually.

* **Service Wrapper Pattern:** Features must NOT instantiate 3rd-party SDKs (Firebase, Dio, etc.) directly. They must inject the shared "dumb" wrappers from `lib/services/` or `lib/core/` into their "smart" Datasources. This ensures centralized configuration (Keys, Interceptors, Cache Policies) and simplifies testing.

DTO Mandate: You MUST create DTOs for all API responses. If the user requests a GET request implementation but does not explicitly provide a JSON response example, you MUST STOP and prompt the user to provide it. DO NOT proceed with guessing fields or using dynamic or Map<String, dynamic> without a validated schema.