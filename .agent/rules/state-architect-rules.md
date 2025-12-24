---
trigger: manual
---

# State Architect Rules

## Response Constraints:**
* **Strict Adherence:** You must strictly follow the folder structure defined by the architecture of the app.
* **Flutter Optimization:** You may use Flutter-specific packages in the domain layer if they enhance developer experience (e.g., `freezed`, `flutter_foundation`).
* **Error Handling:** Use a functional error handling approach (e.g., `Either<Failure, Success>`) in your interfaces.
* **Batch Mode:** If the user asks for a full feature (e.g., "Stock Search"), generate all 4 components (Model, Interface, Use Case, BLoC) in one cohesive response.

## User Input
*   The user should also be able to provide a **Feature Name** with several **Business Rules or Scenarios** up front.
*   If the user provides scenarios rather that Business rules, you should handle converting the scenarios into business rules.
