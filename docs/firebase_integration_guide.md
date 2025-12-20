# Firebase Integration Guide

This guide details the steps to fully integrate Firebase with your Flutter environment, supporting Dev, QA, and Prod environments.

## 1. Firebase Console Setup

You need to create 3 separate Firebase projects (or one project with 3 apps if preferred, but separate projects are cleaner) to correspond to your environments.

### Project & App Creation

#### **Environment: Dev**
*   **Project Name:** `Bizzie Dev`
*   **Android Package Name:** `io.getbizzie.bizzieapp.dev`
*   **iOS Bundle ID:** `io.getbizzie.bizzieapp.dev`
*   **Action:** Download `google-services.json` and `GoogleService-Info.plist`.

#### **Environment: QA**
*   **Project Name:** `Bizzie QA`
*   **Android Package Name:** `io.getbizzie.bizzieapp.qa`
*   **iOS Bundle ID:** `io.getbizzie.bizzieapp.qa`
*   **Action:** Download `google-services.json` and `GoogleService-Info.plist`.

#### **Environment: Prod**
*   **Project Name:** `Bizzie`
*   **Android Package Name:** `io.getbizzie.bizzieapp`
*   **iOS Bundle ID:** `io.getbizzie.bizzieapp`
*   **Action:** Download `google-services.json` and `GoogleService-Info.plist`.

---

## 2. File Placement

Move the downloaded configuration files into the project structure we created.

### Android
*   **Dev:** Place `google-services.json` in `android/app/src/dev/`
*   **QA:** Place `google-services.json` in `android/app/src/qa/`
*   **Prod:** Place `google-services.json` in `android/app/src/prod/`

### iOS
*   **Dev:** Place `GoogleService-Info.plist` in `ios/config/dev/`
*   **QA:** Place `GoogleService-Info.plist` in `ios/config/qa/`
*   **Prod:** Place `GoogleService-Info.plist` in `ios/config/prod/`

**Note:** `ios/config/` and `**/google-services.json` are Git-ignored to prevent secrets from leaking. You should likely set up a secure way to inject these in CI.

---

## 3. iOS Xcode Configuration

Since iOS doesn't support source sets natively like Android, we use a build script to swap the configuration file.

1.  Open `ios/Runner.xcworkspace` in Xcode.
2.  Select the **Runner** target in the project navigator.
3.  Go to the **Build Phases** tab.
4.  Click the **+** button at the top left of the tab and select **New Run Script Phase**.
5.  Name the phase: `Setup Firebase Configuration`.
6.  **Drag and move this phase upwards** so it runs **BEFORE** "Copy Bundle Resources".
7.  In the script text area, paste the following command:
    ```bash
    "$PROJECT_DIR/scripts/setup_firebase_config.sh"
    ```
8.  Uncheck "Based on dependency analysis" to ensure it runs every time (optional, but safer).
9.  **Build Settings Setup (If not already done):**
    Ensure your Build configurations (Debug-dev, Release-prod, etc.) match the logic in the script or use Flutter Flavors. Our script automatically detects `dev`, `qa`, or defaults to `prod` based on the configuration name or `FLUTTER_FLAVOR`.

---

## 4. Verification

 Run the app in different flavors to verify the correct Firebase project is connected.

```bash
# Run Dev
flutter run --flavor dev -t lib/main_dev.dart  

# Run QA
flutter run --flavor qa -t lib/main_qa.dart

# Run Prod
flutter run --flavor prod -t lib/main.dart
```

If the iOS build fails with "GoogleService-Info.plist not found", ensure you have placed the files correctly in step 2.
