# iOS Signing Setup Guide

This guide explains how to generate the **Certificates** and **Provisioning Profiles** required to build and deploy your iOS app via Firebase App Distribution (Ad Hoc distribution).

## Prerequisites
*   An active **Apple Developer Program** membership.
*   Access to the [Apple Developer Portal](https://developer.apple.com/account).
*   A Mac with Xcode installed.

---

## Part 1: Distribution Certificate (.p12)

This certificate certifies your organization's identity.

### 1. Create a Certificate Request (CSR)
> **Note:** You only need **ONE** Distribution Certificate for your entire Apple Team. You can use the same certificate to sign Dev, QA, and Prod apps.

1.  Open **Keychain Access** on your Mac.
2.  Go to **Keychain Access** > **Certificate Assistant** > **Request a Certificate From a Certificate Authority**.
3.  **User Email Address:** Your email (e.g., `yannic@getbizzie.io`).
4.  **Common Name:** Your Name or Company Name (e.g., Bizzie App).
5.  **CA Email Address:** Leave this field **EMPTY**.
6.  **Request is:** Select **Saved to disk**. (This is crucial; it disables the CA Email requirement).
7.  Click **Continue** and save the `CertificateSigningRequest.certSigningRequest` to your Desktop.

### 2. Generate the Certificate
1.  Log in to [Apple Developer Portal](https://developer.apple.com/account).
2.  Go to **Certificates, IDs & Profiles** > **Certificates**.
3.  Click the blue **(+)** button next to Certificates.
4.  Select **Apple Distribution** (or "iOS Distribution (App Store and Ad Hoc)").
5.  Click **Continue**.
6.  Upload the CSR file you created in Step 1.
7.  Click **Continue** and then **Download**.
8.  Double-click the downloaded `.cer` file to install it into Keychain Access.

### 3. Export as .p12
1.  Open **Keychain Access**.
2.  Select the **"login"** keychain and **"My Certificates"** tab.
3.  Find your **"Apple Distribution: [Team Name]"** certificate.
4.  Right-click it and select **Export "Apple Distribution..."**.
5.  Save it as `Certificates.p12` to your Desktop.
6.  **Important:** You will be asked to create a password. **Remember this password!** You will need it for the `DEV_IOS_CERTIFICATE_PASSWORD` secret.

---

## Part 2: App IDs

You need specific Identifiers for each environment flavor.

> **Check First:** Look at your "Identifiers" list. If you already see IDs named like `XC io getbizzie...` or `io.getbizzie...`, check if their **Identifier** matches the ones listed below. **If they match, you can SKIP creating new ones.**

1.  Go to **Identifiers** in the Apple Developer Portal.
2.  Click **(+)** to register a new App ID (Only if they don't exist).
3.  Select **App IDs** > **App**.
4.  **Dev Environment:**
    *   **Description:** Bizzie Dev
    *   **Bundle ID:** `io.getbizzie.bizzieapp.dev` (Matches your project)
5.  **QA Environment:**
    *   **Description:** Bizzie QA
    *   **Bundle ID:** `io.getbizzie.bizzieapp.qa`
6.  **Prod Environment:**
    *   **Description:** Bizzie
    *   **Bundle ID:** `io.getbizzie.bizzieapp`

---

## Part 3: Devices (Ad Hoc Only)

> **Important:** This step is done in the **Apple Developer Portal** (developer.apple.com). Use the "Devices" tab in the left sidebar of the Apple portal.

For **Firebase App Distribution** (Ad Hoc), Apple requires you to whitelist the specific iPhones/iPads that will run the app.

1.  Go to **Devices** in the [Apple Developer Portal](https://developer.apple.com/account/resources/devices/list).
2.  Click **(+)**.
3.  Enter the **Device Name** (e.g., "Yannic's iPhone") and **UDID**.
    *   *Tip:* Testers can find their UDID by plugging their phone into a Mac (Finder/Music app) or using a website like `get.udid.io`.
4.  *Note:* Without this, testers cannot install the app on their phones, even if they download it from Firebase.

---

## Part 4: Provisioning Profiles

These profiles link your App ID, Certificate, and Devices together.

1.  Go to **Profiles**.
2.  Click **(+)**.
3.  Select **Distribution** > **Ad Hoc**.
4.  Click **Continue**.

### A. Create Dev Profile
1.  **App ID:** Select `Bizzie Dev` (or `XC io getbizzie bizzieapp dev`).
2.  **Offline Support:** Select **No** (Default).
3.  **Continue:** Click Continue.
4.  **Certificate:** Select the Distribution Certificate you created in Part 1.
5.  **Devices:** Select ALL registered devices.
6.  **Profile Name:** `Dist_Dev` (Keep it simple).
7.  **Download** and save as `Dist_Dev.mobileprovision`.

### B. Create QA Profile
1.  Repeat the steps but choose App ID: `Bizzie QA`.
2.  Profile Name: `Dist_QA`.
3.  **Download** and save as `Dist_QA.mobileprovision`.

### C. Create Prod Profile
1.  Repeat the steps but choose App ID: `Bizzie`.
2.  Profile Name: `Dist_Prod`.
3.  **Download** and save as `Dist_Prod.mobileprovision`.

---

## Next Steps

Now that you have:
1.  `Certificates.p12` (+ Password)
2.  `Dist_Dev.mobileprovision`
3.  `Dist_QA.mobileprovision`
4.  `Dist_Prod.mobileprovision`

Go back to the [CI/CD Setup Guide](cicd_setup_guide.md) to **Base64 encode** them and add them to GitHub Secrets.
