# RevenueCat Subscription Testing Guide (iOS Simulator)

This guide explains how to use **StoreKit Testing** to simulate purchases on the iOS Simulator without needing a real sandbox account or an internet connection to Apple's servers.

---

## 0. CRITICAL: Run via Xcode (NOT Flutter CLI)
> [!IMPORTANT]
> **Use Xcode to Run the App for IAP Testing**
> The command `flutter run` often **IGNORES** the StoreKit Configuration injection set in the Xcode Scheme.
> If you run via terminal, the app may default to "Standard Mode" and repeatedly ask you to "Sign in to Apple Account" (Production/Sandbox fallback).
>
> **The Fix:**
> 1. Open `ios/Runner.xcworkspace`.
> 2. Select the `dev` scheme.
> 3. Click the **Play Button** in Xcode to launch the app.
> This guarantees the `.storekit` mock environment is injected correctly.

## 1. StoreKit Configuration (Xcode)

**StoreKit Configuration** creates a local "Mini App Store" on your Mac.

### Set up the Configuration File:
1.  Open `ios/Runner.xcworkspace` in Xcode.
2.  Look for `Bizzie.storekit` in the project navigator.
3.  Ensure your products (e.g., `bizzie_plus_annual`) match the **Product IDs** in the Apple App Store and RevenueCat.

### Activate the Configuration:
1.  In Xcode, click on the **Run Scheme** (the app name at the top next to the Play button).
2.  Select **Edit Scheme...**.
3.  Go to **Run** (on the left) > **Options** (at the top).
4.  Find **StoreKit Configuration** and select `Bizzie.storekit` from the dropdown.
5.  Click **Close**.

---

## 2. Syncing with RevenueCat

RevenueCat needs to verify the purchases made on your Mac using a Public Certificate.

### Export the Certificate:
1.  In Xcode, select your `Bizzie.storekit` file.
2.  In the top Mac menu bar, go to **Editor > Save Public Certificate**.
3.  Save it as `StoreKitTestCertificate.cer` in `ios/Runner/`.

### Upload to RevenueCat:
1.  Go to your **RevenueCat Dashboard** > **Projects** > **Bizzie (Dev)**.
2.  Go to **Apps & providers** > select your iOS App.
3.  Expand the **StoreKit testing framework** section.
4.  Toggle **Enable StoreKit testing** to `ON`.
5.  Upload the `StoreKitTestCertificate.cer` file you just saved.
6.  Click **Save Changes**.

---

## 3. How to Test & Reset

One of the main benefits of StoreKit testing is the ability to instantly reset your purchase history.

### Testing a Purchase:
1.  Run the app on your simulator.
2.  Open the paywall and tap a package.
3.  You will see a "StoreKit" themed payment sheet. Confirm the purchase.

### Resetting for Retesting:
If you want to "Clear" the subscription so you can see the paywall again:
1.  While the app is running, stay in **Xcode**.
2.  In the top Mac menu bar, go to **Debug > StoreKit > Manage Transactions...**.
3.  A window will appear showing all local purchases.
4.  Select the transaction and click the **Trash Icon** (Delete) or right-click > **Delete Transaction**.
5.  Restart your app or trigger a refresh in the BLoC. Your user will instantly be "Unsubscribed."

---

## 4. Testing the "Free Trial Loop" (Eligibility)

To check if your app correctly hides the Free Trial for users who have already had one:

### Step 1: Accelerate Time
To make a week pass in seconds:
1.  **Launch the App** via Xcode (`dev` scheme).
2.  **While the App is Running**:
3.  Go to the Mac Menu Bar: **Debug** > **StoreKit** > **Time Rate**.
4.  Select **Monthly Renewal Every 30 Seconds**.
    *   *Note: This makes a 1-week trial expire in ~7 seconds.*

### Step 2: The First Purchase (Has Trial)
1.  Tap "Start Free Trial".
2.  Notice the payment sheet says "7 Days Free". Confirm.
3.  **Result**: You are now subscribed.

### Step 3: Expire & Lapse
1.  Wait ~10 seconds (Trial converts to Paid).
2.  Wait ~30 more seconds (Subscription renews).
3.  To force it to stop (mimic expiration):
    *   Go to **Debug** > **StoreKit** > **Manage Transactions**.
    *   **Right-Click** on the transaction row.
    *   **If "Expire" is missing**: Double-click the row to open Options, select **Cancel Subscription**, and click **Done**.
    *   **Wait** ~30 seconds for the current period to finish. It will turn "Expired".

### Step 4: The Second Purchase (No Trial)
1.  Restart the app (or trigger a UI refresh).
2.  The Paywall should appear (since you are expired).
3.  **Verify UI**: The "7 Days Free" badge should be **GONE**.
4.  Tap the button.
5.  **Verify Payment Sheet**: It should say "Pay $X.XX" immediately, **NOT** "7 Days Free".

---
*   **Use Bizzie (Dev):** Always perform StoreKit testing in your `Dev` RevenueCat project to avoid polluting your Production or QA analytics.
*   **Version Control:** Keep the `.storekit` file and `.cer` certificate in `ios/Runner` so other developers on the team can test immediately without setup.
*   **Sandbox for Final QA:** Only use real "Sandbox Tester" accounts for final verification before a release. StoreKit Testing is for rapid feature development and UI testing.
