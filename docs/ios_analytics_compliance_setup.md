# Beginner's Guide: iOS Analytics Compliance (2026)

This guide provides step-by-step instructions to ensure your iOS app is fully compliant with Apple's 2026 privacy requirements after implementing Firebase Analytics.

---

## Phase 1: Native Configuration in Xcode

### Step 1: Add the Google Services Config
1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  **Repeat for each Environment (Dev, QA, Prod)**:
    *   Switch to the corresponding Firebase project.
    *   Go to **Project Settings** > **General**.
    *   Under **Your apps**, download the `GoogleService-Info.plist`.
3.  **Xcode & Projects Setup (The Bizzie Way)**:
    *   Bizzie uses a special script to swap these files automatically based on your build flavor (Dev, QA, Prod).
    *   Open your project folder in **Finder**.
    *   Navigate to `ios/config/`.
    *   Replace the existing `GoogleService-Info.plist` in each subfolder (`dev/`, `qa/`, `prod/`) with the new version you just downloaded for that specific environment.
    *   **Pro Tip (Manual Fix)**: If `IS_ANALYTICS_ENABLED` still shows as `NO` in Xcode after replacing the file, you can manually fix it:
        1. Open the file (`ios/config/[env]/GoogleService-Info.plist`) in your code editor.
        2. Find the key `<key>IS_ANALYTICS_ENABLED</key>`.
        3. Change the following line from `<false></false>` to `<true></true>`.
    *   **Note**: The version you see in Xcode's `Runner` folder is just a placeholder. The script will pick the correct one from these folders during the build process.

### Step 1.1: Update GitHub Secrets (CI/CD)
Since our app uses GitHub Actions for deployment, we must update the secrets to include the new analytics-enabled config.

**Run these commands in your project terminal**:

*   **For DEV**:
    ```bash
    base64 -i ios/config/dev/GoogleService-Info.plist | pbcopy
    ```
    *Paste into `DEV_GOOGLE_SERVICE_INFO_PLIST_BASE64` in GitHub.*

*   **For QA**:
    ```bash
    base64 -i ios/config/qa/GoogleService-Info.plist | pbcopy
    ```
    *Paste into `QA_GOOGLE_SERVICE_INFO_PLIST_BASE64` in GitHub.*

*   **For PROD**:
    ```bash
    base64 -i ios/config/prod/GoogleService-Info.plist | pbcopy
    ```
    *Paste into `PROD_GOOGLE_SERVICE_INFO_PLIST_BASE64` in GitHub.*

### Step 2: Set the Linker Flag
1.  In Xcode, click on the blue **Runner** project icon at the top of the left sidebar.
2.  Select the **Runner target** under "Targets".
3.  Go to the **Build Settings** tab.
4.  Search for **"Other Linker Flags"**.
5.  Double-click the value and add `-ObjC` on a new line (Note: This may already be present if you have other dependencies).

---

## Phase 2: Privacy and Permissions

### Step 3: Add the Tracking Usage Description (Optional)
**Important Update (2026)**: If you only use analytics to improve your own app (and don't share data with other apps for ads), you can set **NSPrivacyTracking to NO** in your manifest. 
*   **Result**: You do **NOT** need the `NSUserTrackingUsageDescription` key in `Info.plist`.
*   **Benefit**: Users won't see the "Allow to Track" pop-up, which increases trust and retention.
*   **Action**: Only add this if you plan to run paid ad campaigns that require cross-app tracking.

### Step 4: Create the Privacy Manifest
Apple 2026 strictly requires a `PrivacyInfo.xcprivacy` file.
1.  In Xcode, right-click the **Runner** folder and select **New File...**
2.  Search for **"App Privacy"** or **"Property List"**. Save the file as `PrivacyInfo.xcprivacy`.
3.  **Gold Standard Declarations (for Bizzie)**:
    *   **NSPrivacyTracking**: Set to `NO` (Recommended for Privacy-first apps).
    *   **NSPrivacyCollectedDataTypes**:
        *   **Device ID** (Purpose: Analytics).
        *   **Product Interaction** (Purpose: Analytics, App Functionality).
    *   **NSPrivacyAccessedAPITypes**: Declare use of `FileTimestamp` and `UserDefaults` (used by Firebase).

---

## Phase 3: App Store Connect

### Step 5: Fill out Nutrition Labels
When you upload your app for review, you must disclose data collection:
1.  Go to **App Store Connect** > **App Privacy**.
2.  Check the following categories if you are using the onboarding analytics we built:
    *   **Identifiers**: User ID, Device ID.
    *   **Usage Data**: Product Interaction (tracking how users finish onboarding).
    *   **Diagnostics**: Crash Data.

### Step 6: AI Disclosure (If Applicable)
If the data collected (like `selected_sector`) is used to train or prompt a personalized AI for the user:
1.  In your **Privacy Policy** (linked in App Store Connect), state that professional/preference data is used for personalized AI recommendations.
2.  Ensure you have a toggle in the app settings to allow users to opt-out of AI-driven personalization.

---

## Checklist for Final Review:
- [ ] `GoogleService-Info.plist` is visible in Xcode sidebar.
- [ ] `-ObjC` is in Build Settings.
- [ ] `PrivacyInfo.xcprivacy` exists in the bundle.
- [ ] `NSUserTrackingUsageDescription` is in `Info.plist`.
