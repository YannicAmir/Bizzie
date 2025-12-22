# Auth Configuration Guide (iOS)

This guide outlines the manual configuration steps required to enable Google Sign-In and Sign in with Apple for the iOS version of Bizzie.

## 1. Google Sign-In Configuration

> [!CRITICAL]
> **Environment Verification Required**
> You MUST have **3 separate Firebase Projects** created in the Firebase Console:
> 1.  `Bizzie Dev` (Package: `com.example.bizzie.dev`)
> 2.  `Bizzie QA` (Package: `com.example.bizzie.qa`)
> 3.  `Bizzie` (Prod) (Package: `com.example.bizzie`)
>
> If you miss configuration for ANY of these, authentication will fail in that specific environment. Verify EVERY step below for ALL 3 projects.

You must configure the URL schemes for **all three environments** (Dev, QA, Prod).

### Step 1.1: Locate `REVERSED_CLIENT_ID` for each environment
Locate the `GoogleService-Info.plist` file for each environment. Based on the project structure, they are likely in:
- **Dev:** `ios/config/dev/GoogleService-Info.plist`
- **QA:** `ios/config/qa/GoogleService-Info.plist`
- **Prod:** `ios/config/prod/GoogleService-Info.plist`

> [!WARNING]
> **Missing `REVERSED_CLIENT_ID`?**
> If your `GoogleService-Info.plist` does NOT contain this key, it means **Google Sign-In is not enabled** in your Firebase Console yet.
> 1. Go to Firebase Console > Authentication > Sign-in method.
> 2. Javascript/Web: No extra setup usually, but ensure Google is "Enabled".
> 3. **Crucial:** You must strictly ensure the **Android App** in Project Settings has the SHA-1 fingerprint. **This step is often required to "unlock" the generation of the `REVERSED_CLIENT_ID` for iOS.**
>    - *See detailed instructions in: [`docs/firebase_sha1_guide.md`](./firebase_sha1_guide.md)*
> 4. **Action:** After adding the SHA-1 and enabling Google Sign-In, **Download the `GoogleService-Info.plist` again.** The new file will contain the `CLIENT_ID` and `REVERSED_CLIENT_ID`.
> 5. Replace the files in `ios/config/{env}/` with the new versions.

For **each** file:
1. Open the plist file.
2. Find the `REVERSED_CLIENT_ID` key.
3. Copy the value (e.g., `com.googleusercontent.apps.123456...`).

### Step 1.2: Update `Info.plist`
1. Open `ios/Runner/Info.plist`.
2. Find or create the `CFBundleURLTypes` key.
3. Add entries for **all three** reversed client IDs.
   - *For a detailed explanation of `CFBundleURLTypes` and why we use the "Editor" role, see [`docs/ios_url_schemes_explanation.md`](./ios_url_schemes_explanation.md).*

```xml
<key>CFBundleURLTypes</key>
<array>
    <!-- DEV Environment -->
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.YOUR_DEV_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
    <!-- QA Environment -->
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.YOUR_QA_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
    <!-- PROD Environment -->
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.YOUR_PROD_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
</array>
    </dict>
</array>
```

### Step 1.3: Configure `GIDClientID` (Agent Task)

`google_sign_in` version 7+ requires a `GIDClientID` key in `Info.plist`.

**AI Agent Instruction:**
Check `ios/scripts/setup_firebase_config.sh`. Ensure it includes the following logic to automatically inject the `GIDClientID` from the environment's `GoogleService-Info.plist` into the built `Info.plist`. If missing, apply this code block after the plist copy step:

```bash
# --------------------------------------------------------------------------
# UPDATE GIDClientID IN Info.plist
# --------------------------------------------------------------------------
INFO_PLIST_PATH="${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/Info.plist"

echo "🔧 Updating GIDClientID in Info.plist..."

# 1. Extract CLIENT_ID from GoogleService-Info.plist
CLIENT_ID=$(/usr/libexec/PlistBuddy -c "Print :CLIENT_ID" "${SOURCE_PATH}")

if [ -z "$CLIENT_ID" ]; then
    echo "⚠️ WARNING: CLIENT_ID not found in ${SOURCE_PATH}. Google Sign-In may fail."
else
    echo "Found CLIENT_ID: $CLIENT_ID"

    # 2. Add/Update GIDClientID in the App's Info.plist
    # Try to delete if exists to ensure we don't error on 'Add'
    /usr/libexec/PlistBuddy -c "Delete :GIDClientID" "${INFO_PLIST_PATH}" 2>/dev/null || true
    /usr/libexec/PlistBuddy -c "Add :GIDClientID string ${CLIENT_ID}" "${INFO_PLIST_PATH}"

    echo "✅ Successfully updated GIDClientID in Info.plist"
fi
fi
```

**Critical: Build Phase Ordering**
The `Info.plist` is created during the "Copy Bundle Resources" phase. If this script runs before that, the `Info.plist` will not exist (or be overwritten), and the injection will fail.

**Agent Instruction:**
Verify `ios/Runner.xcodeproj/project.pbxproj`. Ensure the "Setup Firebase Configuration" build phase is the **LAST** item in the `buildPhases` list for the Runner target. If it is not last, move it to the end.

## 2. Sign in with Apple Configuration

### Step 2.1: Add Capability in Xcode
1. Open `ios/Runner.xcworkspace` in Xcode.
2. Select the **Runner** project in the Project Navigator.
3. Select the **Runner** target.
4. Go to **Signing & Capabilities**.
5. Click **+ Capability** and add **"Sign in with Apple"**.
   - *Note:* This capability applies to the Target, covering all build configurations (Debug-Dev, Release-Prod, etc.), but ensure your Provisioning Profiles for **all 3 App IDs** support "Sign in with Apple" in the Apple Developer Portal.
   - **Detailed Instructions:** See [`docs/apple_auth_setup_guide.md`](./apple_auth_setup_guide.md) for step-by-step portal configuration.

### Step 2.2: Enable in Firebase Console (All Projects)
You likely have 3 separate Firebase Projects (Dev, QA, Prod). You must perform this interaction for **each one**.

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Select your **Dev** project.
3. Go to **Authentication** > **Sign-in method** > **Add new provider** > **Apple**.
4. Enable the toggle switch.
5. **Leave the rest blank.**
   - **Services ID:** Leave empty (default).
   - **OAuth code flow:** Leave default.
   - *Reason:* These fields are only required for Android or Web support. For native iOS, the Bundle ID is sufficient.
6. Click **Save**.
5. **Repeat** for your **QA** and **Prod** Firebase projects.

## 3. Firebase Console Auditing

> [!IMPORTANT]
> **Repeat for EVERY Project**
> You must switch between your Dev, QA, and Prod projects in the Firebase Console and ensure the providers below are enabled in **each one**.

Ensure the following are enabled for **Dev, QA, and Prod** projects:
- **Email/Password**: Enabled. (This automatically enables "Password Reset").
- **Google**: Enabled. (Ensure SHA-1/SHA-256 fingerprints are added for each environment app).
- **Apple**: Enabled.
- **Account Deletion**: No API configuration required (handled by client SDK).
