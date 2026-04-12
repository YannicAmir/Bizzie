# iOS App Attest & Provisioning Profile Guide

This guide details the "Advanced" steps required if you choose **App Attest** as your App Check provider. Enabling this capability changes your App ID, which invalidates your existing Provisioning Profiles.

## 1. Add "App Attest" Capability (Xcode)
**Why?** This tells Apple your app is allowed to use the cryptographic hardware (Secure Enclave) for validation.
1.  Open your Flutter project's `ios` folder in Xcode (`open ios/Runner.xcworkspace`).
2.  In the left navigator, verify you have selected the root **Runner** project.
3.  In the main view, select the **Runner** target (under "Targets").
4.  Select the **Signing & Capabilities** tab.
5.  Click the **+ Capability** button (top left of the tabs row).
6.  Search for **App Attest**.
7.  Double-click it to add it.
    *   *Result:* You will see "App Attest" appear in the capabilities list. Xcode might show a "Provisioning Profile" error immediately (Red text) — this is expected.

## 2. Update App ID (Apple Developer Portal)
**Why?** Your online configuration must match your local Xcode configuration.
1.  Go to [developer.apple.com](https://developer.apple.com/account).
2.  Navigate to **Certificates, Identifiers & Profiles**.
3.  Click **Identifiers**.
4.  Find and click your app's Identifier (e.g., `io.getbizzie.bizzieapp.dev`).
5.  Scroll down the "Capabilities" list.
6.  Check the box for **App Attest**.
7.  Click **Save** (top right) and confirm any warnings.

## 3. Regenerate Provisioning Profiles
**Why?** Your old profile says "This app has capabilities A, B". Your new app needs "A, B, App Attest". The mismatch prevents building.
1.  In the Apple Developer Portal, go to **Profiles**.
2.  Find the profile matching your app (e.g., `Bizzie Dev Profile`).
    *   *Note:* The status might say "Invalid" because you changed the ID in Step 2.
3.  Click the profile name -> **Edit**.
4.  **Important**: Don't change anything, just click **Save** (or "Generate"). This forces Apple to re-sign the profile with the new capabilities.
5.  Click **Download**.

## 4. Install New Profile
1.  Delete the old profile from your computer (optional but recommended to avoid confusion).
2.  Double-click the downloaded `.mobileprovision` file. This installs it to Xcode.
3.  **Back in Xcode**:
    *   Go to **Signing & Capabilities**.
    *   If "Automatically manage signing" is **checked**: Xcode might fix itself after a few seconds. If not, click "Try Again".
    *   If "Automatically manage signing" is **unchecked**: Manually select the new profile in the dropdown.

## 5. Verify Entitlements
1.  In Xcode's project navigator, look for a file named `Runner.entitlements`.
2.  Open it.
3.  Ensure there is a key called `App Attest Environment`.
4.  **Value**:
    *   For **Production/TestFlight**: usually `production`.
    *   For **Development**: strictly speaking, App Attest works best in production, but ensure the key exists.
