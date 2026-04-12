# Firebase SHA-1 & Google Auth Guide

This guide explains the "SHA-1 Fingerprint" requirement and how to configure the Google Sign-In settings in the Firebase Console.

## 1. What is a SHA-1 Fingerprint?

A **SHA-1 Fingerprint** is a unique alphanumeric string that acts as a digital "ID card" for your app's signing certificate.
*   **Android Only:** This concept is specific to Android. iOS uses "Bundle IDs" and "Provisioning Profiles" instead.
*   **Why is it here?** Even if you are testing on iOS right now, because Bizzie is a Flutter app (cross-platform), Firebase often disables the "Google" provider button until it verifies *at least one* valid Android fingerprint, or generates the necessary OAuth credentials on the backend.

## 2. Why do I need it?

Google's servers need to ensure that the app asking to log in as "Bizzie" is arguably *your* Bizzie app and not a hacker's fake version.
*   **Debug Key:** When you run the app locally from your computer, it is signed with a temporary "Debug" key. You must tell Firebase this key's SHA-1 so you can log in during development.
*   **Release Key:** When you publish to the Play Store, the app is signed with a secure "Release" key. You must valid that SHA-1 too, or users downloading from the store won't be able to log in.

## 3. How to get your Debug SHA-1

You can generate this straightforwardly using the terminal in your project root.

### mac/Linux
```bash
cd android
./gradlew signingReport
```

### Windows
```cmd
cd android
gradlew signingReport
```

**Output:**
Scroll through the output until you find the section for `Task :app:signingReport`. Look for **Variant: debug**.
```text
Variant: debug
Config: debug
Store: /Users/[username]/.android/debug.keystore
Alias: AndroidDebugKey
MD5:  ...
SHA1: 5E:8F:16:06:2E:A3:CD:2C:4A...  <-- COPY THIS
SHA-256: ...
```

## 4. How to get your Release SHA-1 (For Production)

**You do NOT need this yet for local development.** This is only required when you publish your app to the Google Play Store.

### Modern Method (Play App Signing)
Most new apps use "Google Play App Signing," where Google manages the release key for you.
1.  **Upload** your App Bundle (`.aab`) to the **Google Play Console** (Internal/Closed Testing track).
2.  Go to **Release** > **Setup** > **App Integrity**.
3.  Look for the **"App signing key certificate"** tab.
4.  Copy the **SHA-1 certificate fingerprint**.
5.  Go to **Firebase Console (Prod Project)** > **Project Settings**.
6.  Add this new SHA-1 fingerprint to your Android App.
    *   *Result:* Users downloading the app from the Play Store can now log in.

## 6. Updating iOS Configuration (Vital Step)

After you have added the SHA-1 fingerprints and enabled Google Sign-In in the Firebase Console, you **MUST** re-download the configuration files for **all 3 environments**. The old files do not have the necessary `REVERSED_CLIENT_ID`.

### Step-by-Step for Each Environment

#### 1. Dev Environment
1.  Open Firebase Console > Select **Bizzie Dev** project.
2.  Go to **Project Settings** > **Your apps** > **iOS App**.
3.  Click the button **"GoogleService-Info.plist"** to download it.
4.  **Rename** the file if needed to exactly `GoogleService-Info.plist`.
5.  **Move** it to: `ios/config/dev/GoogleService-Info.plist` (Replace existing).

#### 2. QA Environment
1.  Open Firebase Console > Select **Bizzie QA** project.
2.  Go to **Project Settings** > **Your apps** > **iOS App**.
3.  Click **Download**.
4.  **Move** it to: `ios/config/qa/GoogleService-Info.plist` (Replace existing).

#### 3. Production Environment
1.  Open Firebase Console > Select **Bizzie** (Prod) project.
2.  Go to **Project Settings** > **Your apps** > **iOS App**.
3.  Click **Download**.
4.  **Move** it to: `ios/config/prod/GoogleService-Info.plist` (Replace existing).

> [!TIP]
> **Verification:** Open one of the new files in a text editor. You should now see the `<key>REVERSED_CLIENT_ID</key>` present.

## Summary Checklist
1.  [ ] Run `./gradlew signingReport` in `android/`.
2.  [ ] Copy the `SHA1` for `debug`.
3.  [ ] Add it to **Project Settings > Android App** in Firebase (Dev, QA, Prod).
4.  [ ] Go to **Authentication > Google** (Enabled).
5.  [ ] Ensure "Web SDK configuration" feels populated.
6.  [ ] **Perform Section 6 above** (Download & Replace plists).
