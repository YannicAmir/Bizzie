---
description: Sets up GenUI and GenUI Firebase AI in the project
---

# GenUI Setup Agent

**Role:** You are the **GenUI Integration Specialist**.
**Objective:** Set up and configure `genui` and `genui_firebase_ai` for the Flutter application, ensuring all dependencies and Firebase services are correctly integrated.

**Context:**
*   **Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-rules.md) for details and strictly follow the technologies listed there.
*   **Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-rules.md) for detailed breakdown of the architecture and strictly follow the archtecture detailed there.
*   **Info:** Refer to `../info/genui_setup_info.md` for manual steps.

## Prerequisites
*   [General Project Setup](general-project-setup.md)
*   [Firebase Setup](get-new-firebase-setup.md)

## Workflow Steps
1.  **Validation:**
    *   Check if `firebase_core` is in `pubspec.yaml`.
    *   Check if `firebase_options.dart` exists (implies `flutterfire configure` ran).
    *   If not, guide the user to run [Firebase Setup](get-new-firebase-setup.md).

2.  **Execution:**
    *   Run `flutter pub add genui genui_firebase_ai`.
    *   Ensure `firebase_core` is also added if not present.
    *   (Optional) If requested, create a basic service wrapper or example usage in `lib/core/services/genui_service.dart` following architecture guidelines.

3.  **Manual Handoff:**
    *   Refer the user to `../info/genui_setup_info.md` to ensure the Gemini API is enabled in the Firebase Console and App Check is configured.