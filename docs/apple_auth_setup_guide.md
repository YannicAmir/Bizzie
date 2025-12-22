# Apple Sign-In Setup Guide

This guide details the specific steps required to enable **Sign in with Apple** for your Bizzie application across all three environments (Dev, QA, Prod).

## 1. Xcode Configuration (Local Project)

This step tells your local Xcode project that you intend to use this feature.

1.  Open `ios/Runner.xcworkspace` in Xcode.
2.  Click on the **Runner** project in the left Project Navigator (the blue icon at the very top).
3.  In the main view, select the **Runner** target (under "Targets").
4.  Tab over to **Signing & Capabilities**.
5.  Ensure **All** is selected (or verify for both Debug and Release tabs).
6.  Click **+ Capability** (top left corner of the tab).
7.  Search for **Sign in with Apple**.
8.  Double-click to add it.
    *   *Result:* You should see a "Sign in with Apple" section appear in the capabilities list. A `Runner.entitlements` file is created/updated in your project files.

## 2. Apple Developer Portal (Remote Permissions)

Adding the capability in Xcode is not enough. You must explicitly allow this service for your App IDs on Apple's servers.

> [!IMPORTANT]
> **Repeat for ALL 3 App IDs**
> You must perform the steps below for:
> 1.  **Dev ID:** `io.getbizzie.bizzieapp.dev` (example)
> 2.  **QA ID:** `io.getbizzie.bizzieapp.qa` (example)
> 3.  **Prod ID:** `io.getbizzie.bizzieapp` (example)

### Step-by-Step

1.  Log in to the [Apple Developer Portal](https://developer.apple.com/account).
2.  Go to **Certificates, Identifiers & Profiles**.
3.  Select **Identifiers** from the sidebar.
4.  Find and click on your **Dev App ID** (e.g., `Bizzie Dev`).
5.  Scroll down the "Capabilities" list.
6.  Find **Sign in with Apple** and check the box ☑️.
    *   *Note:* It usually says "Edit" next to it. For a basic app setup, you typically do not need to configure the "Edit" settings.
    *   **Already Checked?** If this is *already* checked, it means Xcode's "Automatically manage signing" feature successfully communicated with the portal when you added the Capability in Step 1. **This is good!** It means you don't need to change anything here, just verify it's active for all 3 Identifiers.
7.  Click **Save** (top right).
8.  It may warn you that "Modifying this identifier will invalidate provisioning profiles". Click **Confirm**.

**Now repeat steps 4-8 for your QA and Prod App IDs.**

## 3. Refreshing Provisioning Profiles

Since you modified the App ID capabilities on the portal, your local "Provisioning Profiles" (the permission slips stored on your Mac) are now outdated because they don't list "Sign in with Apple".

### If using "Automatically manage signing" (Likely)
**You do NOT need to download anything manually.**
1.  Go back to **Xcode** > **Signing & Capabilities**.
2.  Briefly wait. Xcode usually sees the change and creates a new managed profile in the background.
3.  **Verification:** If you don't see any red errors under "Provisioning Profile", you are done. The system has auto-updated your permissions.

### If using Manual Signing (Rare for initial setup)
1.  Go to the **Profiles** section in Apple Developer Portal.
2.  Find your profiles (Dev/Distribution). They will likely be marked "Invalid".
3.  Edit each one, re-save/download, and install them by double-clicking.


## 4. Troubleshooting

### "Sign Up Not Completed" Error (Physical Device)

If you see a generic "Sign Up Not Completed" error on a physical device (especially after a Release/Distribution build via GitHub Actions) but it works on Simulator:

**Cause:** The Provisioning Profile being used by GitHub Actions is outdated or "stale," even if the portal says "Enabled".

**Fix (The "Uncheck/Recheck" Method):**
1.  Go to the **Apple Developer Portal** > **Identifiers**.
2.  Select your App ID (e.g., `com.example.bizzie.dev`).
3.  **Uncheck** "Sign in with Apple".
4.  Click **Save** (Confirm warnings).
5.  Wait 5 seconds.
6.  **Check** "Sign in with Apple" again.
7.  Click **Save**.
8.  **CRITICAL:** Go to **Profiles**, find your Distribution profile (e.g., `Dist_Dev`). It will likely be "Invalid".
9.  Edit -> Save -> Download the new profile.
10. Update your **GitHub Secret** (`DEV_IOS_PROVISION_PROFILE_BASE64`) with the new file base64.
