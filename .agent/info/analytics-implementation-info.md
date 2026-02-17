# Analytics Verification Manual Guide

This guide details how to verify that your Firebase Analytics events are being correctly tracked and sent to the Firebase Console.

---

## 1. Verifying with Firebase DebugView
DebugView allows you to see the events being logged from your development device in near real-time.

### **Android Setup**
1.  Connect your Android device or simulator.
2.  Open your terminal and run:
    ```bash
    adb shell setprop debug.firebase.analytics.app [YOUR_PACKAGE_NAME]
    ```
    *   *Note: Replace `[YOUR_PACKAGE_NAME]` with your app ID (e.g., `io.getbizzie.app`).*
3.  To disable DebugView later, run:
    ```bash
    adb shell setprop debug.firebase.analytics.app .none.
    ```

### **iOS Setup**
1.  Open the project in Xcode (`ios/Runner.xcworkspace`).
2.  Go to **Product > Scheme > Edit Scheme**.
3.  Select **Run** from the left menu.
4.  Select the **Arguments** tab.
5.  In the **Arguments Passed On Launch** section, click `+` and add:
    ```text
    -FIRDebugEnabled
    ```
6.  To disable DebugView later, remove this argument or add `-FIRDebugDisabled`.

### **Verification Steps**
1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  Select your project and navigate to **Analytics > DebugView**.
3.  Interact with the app. You should see events appearing in the timeline.
4.  Click on an event (e.g., `auth_login_success`) to verify that the **parameters** (timestamp, screen_name, etc.) are correct.

---

## 2. Common Troubleshooting

### **Events Not Appearing in Dashboard**
*   **Latency**: Standard Analytics reports (outside of DebugView) can take up to 24-48 hours to populate. Always use DebugView for real-time verification.
*   **Initialization**: Ensure that `Firebase.initializeApp()` is called in `main.dart` before any analytics events are triggered.
*   **Collection Disabled**: Check if `setAnalyticsCollectionEnabled(false)` was called accidentally.

### **Missing Parameters**
*   Ensure you are passing the parameters Map correctly to `logEvent`.
*   Check that the parameter keys follow the `snake_case` rule; otherwise, they may be filtered by Firebase.

---

## 3. Opt-Out Implementation (Privacy)
If you need to test user opt-out:
1.  Navigate to the App Settings in the UI (if implemented).
2.  Toggle "Share Analytics Data".
3.  Verify that subsequent actions do NOT appear in DebugView.
