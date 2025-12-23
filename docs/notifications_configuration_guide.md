# Notification Configuration Guide

> [!CRITICAL]
> **Reading this guide is mandatory.** Notification setup is complex and error-prone. Follow these steps precisely.

## 1. Apple Developer Portal (The Key)
### Generate APNs Auth Key (.p8)
1.  Log in to [Apple Developer Portal](https://developer.apple.com/account/).
2.  Go to **Certificates, Identifiers & Profiles** > **Keys**.
3.  Click **+** to create a new key.
4.  Name it "Bizzie APNs Key".
5.  Check **Apple Push Notifications service (APNs)**.
6.  Click the **Configure** button next to the checkbox.
7.  In the "Environment" dropdown, select **Sandbox & Production** (this ensures the key works for all environments).
8.  Click **Continue/Save** -> **Register**.
    > [!NOTE]
    > You may see a warning: *"It's recommended to use different, environment-specific keys..."*. **You can safely ignore this.** For Firebase Cloud Messaging, using a single "Sandbox & Production" key is the standard, simplified workflow.
9.  **Download** the `.p8` file.
    > [!WARNING]
    > **You only get one chance to download this key.**
    > 1.  **DO NOT** check this file into Git/GitHub.
    > 2.  **DO** open your Password Manager (1Password, Bitwarden, LastPass, etc.).
    > 3.  Create a new "Secure Note" item.
    > 4.  Attach the `.p8` file to that note (or copy-paste the text inside it).
    > 5.  Name it "Bizzie APNs Key" and save it.
    > 6.  Once you have verified it's safe, you can delete the copy in your Downloads folder.
    >
    > **Mac Native Option (If you don't have a Password Manager):**
    > 1.  Open the `.p8` file with a text editor (TextEdit, VS Code, etc.).
    > 2.  **Copy** the entire text content (it generates a private key string).
    > 3.  Open **Notes** and create a new note "Bizzie APNs Key".
    > 4.  **Paste** the key text into the note.
    > 5.  Click the **Lock** icon to encrypt it. (Notes with file attachments often cannot be locked, so pasting the text is safer).
    > 6.  Delete the file from Downloads.

### Record Key Details
You will need:
-   **Key ID**: (Displayed on the Key details page)
-   **Team ID**: (Displayed in the top right of your account or Membership details)

## 2. Xcode Capabilities
1.  Open `ios/Runner.xcworkspace` in Xcode.
2.  Select the **Runner** project in the left navigator.
3.  Select the **Runner** target.
4.  Go to the **Signing & Capabilities** tab.
    > [!NOTE]
    > **Troubleshooting Signing Errors:**
    > If you see a red error saying **"Revoke certificate"**, this is unrelated to the APNs key but blocks you from proceeding.
    > *   This means your Mac is missing the private key for your existing Apple Development certificate.
    > *   **Fix:** Click **Revoke Certificate**. Xcode will automatically generate a new valid one for this computer.
5.  Click **+ Capability**.
6.  Add **Push Notifications**.
7.  Click **+ Capability** again.
8.  Add **Background Modes**.
8.  Add **Background Modes**.
9.  Check **Remote notifications**.

## 3. Firebase Console (x3 Environments)
You must repeat this for **ALL 3** Firebase projects (**Bizzie Dev**, **Bizzie QA**, **Bizzie Prod**).

1.  Go to [Firebase Console](https://console.firebase.google.com/).
2.  Select your project (Start with **Bizzie Dev**, then repeat for **Bizzie QA** and **Bizzie Prod**).
3.  Click the **Gear icon** (Project Settings) -> **Cloud Messaging** tab.
4.  Scroll to **Apple app configuration**.
5.  You will likely see two slots: **Development APNs auth key** and **Production APNs auth key**.
6.  **Upload the SAME `.p8` file to BOTH slots.**
    *   Since we created a "Sandbox & Production" key, it is valid for both.
7.  For each upload, enter the **Key ID** and **Team ID** and click **Upload**.
    > [!TIP]
    > **Ignore the "APNs Certificates" section below it.**
    > You are using the modern **APNs Authentication Key (.p8)** method, which supersedes the old certificate (.p12) method. Leave the certificates section empty.

> [!NOTE]
> You use the **same** `.p8` key for all environments. This is standard practice.

## 4. Android Setup
### Notification Channel
Ensure `AndroidManifest.xml` (in `android/app/src/main/`) has the following metadata inside the `<application>` tag (this should be handled by the plugin, but verifying is good practice):

```xml
<meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="default_channel_id" />
```

This matches the channel ID used in `LocalNotificationDataSource.dart`.

## 5. Simulator Testing
Since real Push Notifications often fail on the iOS Simulator, use the generated fixture to test logic.

**Command (Run in Terminal):**
```bash
xcrun simctl push booted io.getbizzie.bizzieapp.dev test/fixtures/payload.apns
```

*   **Background:** Minimize app -> Run command -> See Banner.
*   **Foreground:** Open app -> Run command -> See Local Notification (Heads Up).
