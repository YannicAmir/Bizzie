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

You can run this command from **any** folder in your terminal. We will save the file specifically to your **Home Directory** so you can find it easily.

1.  **Open your Terminal app.**
2.  **Paste and Run** the following command:

    ```bash
    keytool -genkey -v -keystore ~/upload-keystore.jks \
            -keyalg RSA -keysize 2048 -validity 10000 \
            -alias upload
    ```

    > **Note:** The `~` symbol stands for your user home folder (e.g., `/Users/yannicamir/`). So `~/upload-keystore.jks` means "save this file named `upload-keystore.jks` right inside my home folder."

3.  **Answer the Prompts:**
    *   **Enter keystore password:** Type a strong password (it won't show on screen as you type). Press Enter.
    *   **Re-enter new password:** Type it again.
    *   **What is your first and last name?:** Enter "Bizzie Team" (or your name).
    *   **Organizational Unit / Organization / City / State / Country:** You can fill these or just leave them blank (press Enter).
    *   **Is CN=..., C=... correct?:** Type `yes` and press Enter.

---

## Verifying the File

Once the command finishes, check if the file exists:

1.  Run this command to listed the file details:
    ```bash
    ls -l ~/upload-keystore.jks
    ```
2.  If it prints a line like `-rw-r--r--  1 yannicamir  staff  2345 ...`, the file is there!
3.  You can now use this path (`~/upload-keystore.jks`) for the Base64 encoding step in the CI/CD guide.

## Next Steps

Now that you have the `upload-keystore.jks` file, go back to the [CI/CD Setup Guide](cicd_setup_guide.md) to **Base64 encode** it and add it to GitHub Secrets.
