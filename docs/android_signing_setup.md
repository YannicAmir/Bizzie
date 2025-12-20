# Android Signing Setup Guide

This guide explains how to generate the **Upload Keystore** (`.jks`) required to sign your Android application for release.

## What is an Upload Keystore?
An Upload Keystore is a cryptographic key that proves you are the author of the app. Google Play uses this to verify your identity when you upload an APK or App Bundle.

> **CRITICAL:** Never lose this file. Keep it in a secure place. If you lose it, you may be unable to update your app on the Play Store.

---

## How to Generate a Keystore

### Option A: Using Android Studio (Recommended)

1.  Open your project in **Android Studio**.
2.  Go to **Build** > **Generate Signed Bundle / APK**.
3.  Select **APK** and click **Next**.
4.  Under "Key store path", click **Create new...**.
5.  **Fill in the details:**
    *   **Key store path:** Choose a location **OUTSIDE** your project directory (e.g., `~/safe_storage/bizzie_keystore.jks`).
    *   **Password:** Create a strong password.
    *   **Confirm:** Repeat password.
    *   **Key > Alias:** `upload` (or your preferred name).
    *   **Key > Password:** Same as store password (recommended for simplicity) or unique.
    *   **Validity:** `25` years.
    *   **Certificate:** Fill in "First and Last Name" (e.g., Bizzie Team).
6.  Click **OK**.
7.  Click **Cancel** (You don't need to build right now, you just wanted the file).

### Option B: Using Command Line (Terminal)

Run the following command in your terminal:

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks \
        -keyalg RSA -keysize 2048 -validity 10000 \
        -alias upload
```

*   It will prompt you for a password and some details (Name, Organization, etc.).
*   The file `upload-keystore.jks` will be created in your home directory.

---

## Verifying the File

Ensure the file was created:
```bash
ls -l ~/upload-keystore.jks 
# Or wherever you saved it
```

## Next Steps

Now that you have the `upload-keystore.jks` file, go back to the [CI/CD Setup Guide](cicd_setup_guide.md) to **Base64 encode** it and add it to GitHub Secrets.
