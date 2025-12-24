---
trigger: manual
description: Apply when working on GenUI Setup
---
# GenUI Setup Rules

*   **Package Requirement:** You must use the `genui` and `genui_firebase_ai` packages.
*   **Firebase Dependency:** GenUI in this context depends on Firebase. Ensure `firebase_core` is installed and initialized.
*   **Gemini API:** The underlying provider is the Gemini API via Firebase Vertex AI. This must be enabled in the Firebase Console.
*   **Architecture:** Place GenUI initialization logic within `lib/core/genui/` or similar infrastructure layer if creating a wrapper, or within the specific feature if isolated. However, strictly follow the [Architecture Guide](../rules/architecture-rules.md).
*   **Tech Stack:** Strict adherence to [Technology Stack Rules](../rules/technology-stack-rules.md).
