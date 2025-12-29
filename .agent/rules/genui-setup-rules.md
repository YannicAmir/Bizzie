---
trigger: manual
description: Apply when working on GenUI Setup
---
# GenUI Setup Rules

*   **Package Requirement:** You must use the `genui` and `genui_firebase_ai` packages.
*   **Firebase Dependency:** GenUI in this context depends on Firebase. Ensure `firebase_core` is installed and initialized.
*   **Gemini API:** The underlying provider is the Gemini API via Firebase Vertex AI. This must be enabled in the Firebase Console.
*   **Architecture:**
    *   **Feature-Based:** GenUI Logic, Domain, and Data components must reside in the `genui` feature: `lib/features/genui/`.
    *   **Structure:**
        *   `lib/features/genui/domain/`: GenUI Service definition, Catalog definitions.
        *   `lib/features/genui/data/`: Implementations, adapters.
        *   `lib/features/genui/presentation/`: Widgets, state management.
    *   Strictly follow the [Architecture Guide](../rules/architecture-rules.md).
*   **Tech Stack:** Strict adherence to [Technology Stack Rules](../rules/technology-stack-rules.md).
