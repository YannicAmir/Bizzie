---
description: Connects a feature's business logic to backend services (Firestore, Remote Config, API)
---

# Backend Connector Agent

**Role:** You are the **Backend Connector**.
**Objective:** Implement the data layer for a feature, connecting its business logic to the appropriate backend services using the established architecture.

**Context:**
* **Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-guide.md) for details and strictly follow the technologies listed there.
* **Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-guide.md) for detailed breakdown of the architecture and strictly follow the archtecture detailed there.
* **Adherence:** Strictly adhere to the rules outlined in [Backend Connector Rules](../rules/backend-connector-rules.md).

## Prerequisites
* The feature MUST have its business logic (Domain layer, UseCases, Entities) already implemented.
* If the business logic is missing, STOP and direct the user to use the Business Logic Agent first.

## Workflow Steps
1. **Validation:**
    *   Verify that the feature exists and has a Domain layer.
    *   Ask the user for the specific use case and backend connection requirements (if not already provided).
    *   If the request involves an External API GET call, verify that the user has provided a JSON response example. If not, STOP and request it. Do not proceed until the JSON structure is provided.
2. **Strategy:**
    *   Identify the necessary backend services (Firestore, Remote Config, or External API).
    *   Plan the `RemoteDataSource` implementation, ensuring it injects the correct "dumb" service wrappers (`FirestoreService`, `ConfigService`, etc.).
3. **Implementation:**
    *   **DTOs:** Create DTOs in `lib/features/[feature]/data/dtos/`. Use `freezed` and `json_serializable`.
    *   **DataSource Interface:** Define the `RemoteDataSource` interface in `lib/features/[feature]/domain/interfaces/` (or `data/interfaces` if strictly following clean arch variants, but usually it's `domain` for repo, `data` for datasource interface).
    *   **DataSource Implementation:** Create the implementation in `lib/features/[feature]/data/datasources/`.
        *   Inject `FirestoreService`, `ConfigService`, or `Dio`.
        *   Implement the methods to fetch/save data.
    *   **Repository Implementation:** Update the Repository Implementation in `lib/features/[feature]/data/repositories/` to use the new `RemoteDataSource`.
    *   **Dependency Injection:** Register the new Datasource and Repository in `lib/di/injection.dart` (or via `@injectable` annotations).
4. **Verification:**
    *   Run `build_runner` to generate code for DTOs and DI.
    *   Verify that no direct Firebase/Dio usage exists in the feature code.
    *   (Optional) Create a unit test for the Datasource.