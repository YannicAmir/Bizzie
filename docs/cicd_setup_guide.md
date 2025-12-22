# CI/CD Setup Guide for Bizzie

This guide walks you through setting up the GitHub Actions pipeline for Bizzie. By the end of this guide, you will be able to manually deploy to Dev, QA, and Prod environments using GitHub Actions.

## Prerequisites

*   Administrative access to this GitHub repository.
*   Access to the Firebase Console (Service Accounts).
*   Access to the Google Play Console (Upload Key).
*   Access to the Apple Developer Portal (Certificates & Profiles).
*   A terminal on macOS or Linux (for encoding files).

*   A terminal on macOS or Linux (for encoding files).

---

## Part 0: Versioning Strategy

To avoid "duplicate build" errors in Firebase App Distribution, we use a hybrid versioning approach:

1.  **Marketing Version (Name):** Controlled by `pubspec.yaml` (e.g., `1.0.0`). This is what users see.
2.  **Build Number (Internal):** Controlled by **GitHub Actions Run ID**.
    *   Every time the pipeline runs, GitHub assigns a unique, incrementing integer (e.g., Run #45).
    *   We inject this as the build number: `1.0.0+45`.
    *   **Result:** You can deploy the *same* code commit multiple times, and each one will be treated as a unique build by Firebase/AppStore.

---

## Part 1: Secrets Management (The "Hard" Part)

GitHub Actions needs permission to sign your app and upload it to Firebase. We can't commit these sensitive files (keys, certificates) to the repo. Instead, we **Base64 encode** them and store them as **GitHub Secrets**.

### Secrets Management

To enable automated builds and deployments, you must add the following **actions secrets** to your GitHub repository.

Go to: **Settings** > **Secrets and variables** > **Actions** > **New repository secret**.

### How to Encode a File
We will use the command line to turn your binary files into text strings that GitHub can store. All file-based secrets (JSON, Keystore, Certificates) must be **Base64 encoded**.
To encode a file on macOS/Linux:

**Command:**
```bash
base64 -i <path-to-your-file> | pbcopy
# On Linux (no pbcopy), use: base64 -i <path-to-your-file>
```
*This command encodes the file and copies the result to your clipboard immediately.*

---

### Step 1: Firebase Service Accounts
These allow the CI pipeline to upload the APK/IPA to Firebase App Distribution.

1.  Go to the **Firebase Console** > Project Settings > Service accounts.
2.  Generate a new private key (JSON file) for **Dev**, **QA**, and **Prod** projects.
3.  **Action:**

    **Dev Environment:**
    ```bash
    # Replace path with your downloaded file location
    base64 -i ~/Downloads/firebase-adminsdk-dev.json | pbcopy
    ```
    *   Create Secret Name: `DEV_FIREBASE_SERVICE_ACCOUNT_JSON`
    *   Value: [Paste Base64 String]

    **QA Environment:**
    ```bash
    base64 -i ~/Downloads/firebase-adminsdk-qa.json | pbcopy
    ```
    *   Create Secret Name: `QA_FIREBASE_SERVICE_ACCOUNT_JSON`
    *   Value: [Paste Base64 String]


    **Prod Environment:**
    ```bash
    base64 -i ~/Downloads/firebase-adminsdk-prod.json | pbcopy
    ```
    *   Create Secret Name: `PROD_FIREBASE_SERVICE_ACCOUNT_JSON`
    *   Value: [Paste Base64 String]

---

### Step 2: Android Signing (Upload Keystore)
This is the key used to sign the Android `app-release.apk`.

> **Need help finding or creating this file?**
> 👉 **[Read the Android Signing Setup Guide](android_signing_setup.md)** for step-by-step instructions.

1.  Locate your `upload-keystore.jks` file (IMPORTANT: This should NOT be in your git repo).
2.  **Action:**
    ```bash
    # Use the path to where you keep your keystore
    base64 -i ~/safe_storage/upload-keystore.jks | pbcopy
    ```
    *   Create Secret Name: `DEV_ANDROID_KEYSTORE_BASE64` (Can reuse for QA/Prod).
    *   Create Secret Name: `QA_ANDROID_KEYSTORE_BASE64`
    *   Create Secret Name: `PROD_ANDROID_KEYSTORE_BASE64`

---

### Step 3: iOS Signing (Certificates & Profiles)
Apple requires a helper certificate and provisioning profile to build the `.ipa`.

> **Need help generating Certificates & Profiles?**
> 👉 **[Read the iOS Signing Setup Guide](ios_signing_setup.md)** for detailed instructions on using the Apple Developer Portal.

#### A. Distribution Certificate (.p12)
1.  Export your Apple Distribution Certificate from Keychain Access as a `.p12` file.
2.  **Action:**
    ```bash
    base64 -i ~/Desktop/distr_cert.p12 | pbcopy
    ```
    *   Encode the `.p12` file.
    *   Create Secret: `IOS_DIST_CERTIFICATE_BASE64`
    *   Value: [Paste Base64 String]
    *   Create Secret: `IOS_DIST_CERTIFICATE_PASSWORD` (The password string itself, NOT base64).
    *   Value: [Paste Password String]

    > **Note:** This single certificate secret is used for **Dev**, **QA**, and **Prod** environments.

#### B. Provisioning Profiles (.mobileprovision)
1.  Download the **Ad Hoc** provisioning profile for each environment from Apple Developer Portal.
    *   `Dist_Dev.mobileprovision` (Matches `com.example.bizzie.dev`)
    *   `Dist_QA.mobileprovision` (Matches `com.example.bizzie.qa`)
    *   `Dist_Prod.mobileprovision` (Matches `com.example.bizzie`)
2.  **Action:**

    **Dev Profile:**
    ```bash
    base64 -i ~/Downloads/Dist_Dev.mobileprovision | pbcopy
    ```
    *   Secret: `DEV_IOS_PROVISION_PROFILE_BASE64`
    *   Value: [Paste Base64 String] 

    **QA Profile:**
    ```bash
    base64 -i ~/Downloads/Dist_QA.mobileprovision | pbcopy
    ```
    *   Secret: `QA_IOS_PROVISION_PROFILE_BASE64`
    *   Value: [Paste Base64 String]

    **Prod Profile:**
    ```bash
    base64 -i ~/Downloads/Dist_Prod.mobileprovision | pbcopy
    ```
    *   Secret: `PROD_IOS_PROVISION_PROFILE_BASE64`
    *   Value: [Paste Base64 String]

---

### Step 4: Configuration Files (Google Services)
These files contain the implementation details for Firebase and ARE in your project structure (if you added them).

1.  **Android Configs:**
    Run these commands from your project root:

    ```bash
    # Dev
    base64 -i android/app/src/dev/google-services.json | pbcopy
    ```
    *   Secret: `DEV_GOOGLE_SERVICES_JSON_BASE64`
    *   Value: [Paste Base64 String]

    ```bash
    # QA
    base64 -i android/app/src/qa/google-services.json | pbcopy
    ```
    *   Secret: `QA_GOOGLE_SERVICES_JSON_BASE64`
    *   Value: [Paste Base64 String]

    ```bash
    # Prod
    base64 -i android/app/src/prod/google-services.json | pbcopy
    ```
    *   Secret: `PROD_GOOGLE_SERVICES_JSON_BASE64`
    *   Value: [Paste Base64 String]

2.  **iOS Configs:**

    ```bash
    # Dev
    base64 -i ios/config/dev/GoogleService-Info.plist | pbcopy
    ```
    *   Secret: `DEV_GOOGLE_SERVICE_INFO_PLIST_BASE64`

    ```bash
    # QA
    base64 -i ios/config/qa/GoogleService-Info.plist | pbcopy
    ```
    *   Secret: `QA_GOOGLE_SERVICE_INFO_PLIST_BASE64`

    ```bash
    # Prod
    base64 -i ios/config/prod/GoogleService-Info.plist | pbcopy
    ```
    *   Secret: `PROD_GOOGLE_SERVICE_INFO_PLIST_BASE64`

---

### Step 5: Firebase App Distribution Setup
Before running your first build, you must configure the "testers" group in Firebase.

If you see an error like `Requested entity was not found`, it usually means this group is missing.

**To fix/configure this:**
1.  Go to **Firebase Console** > **App Distribution** > **Testers & Groups**.
2.  Create a new group named `testers` (must be lowercase to match our workflow default).
3.  **Add your email** to this group.
4.  (Optional) Re-run the build manually in GitHub Actions, and you will receive the email invite!

---

## Part 2: App IDs (for Deploy Workflow)

The deployment workflow needs to know specifically which App to upload to in Firebase.

1.  Open `.github/workflows/deploy.yml`.
2.  **Android:** Locate Section 4 (Upload to Firebase or Android steps).
    *   Replace `DEV_APP_ID_PLACEHOLDER` with your Android Dev App ID.
    *   Replace `QA_APP_ID_PLACEHOLDER` with your Android QA App ID.
    *   Replace `PROD_APP_ID_PLACEHOLDER` with your Android Prod App ID.
3.  **iOS:** Locate the "Upload iOS to Firebase" step.
    *   Replace `DEV_IOS_APP_ID_PLACEHOLDER` with your iOS Dev App ID.
    *   Replace `QA_IOS_APP_ID_PLACEHOLDER` with your iOS QA App ID.
    *   Replace `PROD_IOS_APP_ID_PLACEHOLDER` with your iOS Prod App ID.
    *   *You can find these IDs in the **Firebase Console** (Settings > General > Your Apps).*
    *   Example ID: `1:123456789:ios:abcdef123456`

---

## Part 3: Branch Protection (The Quality Gate)

GitHub Team subscription is required for this feature. Ensure no code enters `main` without passing tests.

1.  Go to **GitHub Repo Settings** > **Branches**.
2.  **Add branch protection rule** for `main`.
3.  Check **"Require status checks to pass before merging"**.
4.  Search for `Analyze and Test`.
5.  Select it and save.

## Verification

To verify everything works, we will trigger a manual build for the **Dev** environment.

1.  **Open your Repository on GitHub.**
2.  Click the **Actions** tab in the top horizontal menu (between Pull requests and Projects).
3.  **Locate the Workflow:**
    *   On the left sidebar, look for **Manual Deployment**. Click it.
4.  **Trigger the Run:**
    *   On the right side of the blue banner, click the **Run workflow** dropdown button.
    *   **Use workflow from:** Ensure `main` is selected.
    *   **Which environment to deploy?:** Select `dev` (for first test).
    *   *Note: In the future, you can select `qa` or `prod` here to deploy to those environments.*
    *   Click the green **Run workflow** button.
5.  **Monitor the Build:**
    *   After a few seconds, a new row will appear in the list with a yellow spinning circle.
    *   Click on the title (e.g., "Manual Deployment") to see the live logs.
    *   You can click into the **Deploy to Firebase (dev)** job to watch each step (Setting up Java, Map Secrets, Build APK, etc.).
6.  **Success:**
    *   When the circle turns ✅ **Green**, the build is complete.
    *   Check your **email** (the one associated with your Firebase account). You should receive an invitation to test the new release.
    *   Alternatively, go to the **Firebase Console** > **App Distribution** for the Bizzie Dev project, and you will see the new release listed there.
