# Firebase Options Setup Guide

This guide details the **manual steps** required to generate the environment-specific `FirebaseOptions` files for Bizzie.
These files are required for Authentication and GenUI features to work correctly.

## Prerequisites
1.  **Firebase CLI**:
    *   The Agent has installed `firebase-tools`.
    *   **Action Required:** Run the following to authenticate:
        ```bash
        firebase login
        ```
    *   **Verify:**
        ```bash
        firebase --version
        # Should show version ~13.x.x
        ```

2.  **FlutterFire CLI**:
    *   **CRITICAL FIX:** If the latest version is crashing. Run this to use a stable version:
    ```bash
    dart pub global activate flutterfire_cli 0.2.7
    ```

## Configuration Commands

Run the following commands in your terminal from the project root (`/Users/yannicamir/developer/Bizzie`).

### 1. Development (Dev)
**Project ID:** `bizzie-dev-7199b`
**Package/Bundle ID:** `io.getbizzie.bizzieapp.dev`

```bash
flutterfire configure \
  --project=bizzie-dev-7199b \
  --out=lib/config/firebase/firebase_options_dev.dart \
  --ios-bundle-id=io.getbizzie.bizzieapp.dev \
  --android-package-name=io.getbizzie.bizzieapp.dev \
  --platforms=android,ios \
  --yes
```

### 2. Quality Assurance (QA)
**Project ID:** `bizzie-dev-7199b` (Note: Using Dev project for QA based on typical setup, or `bizzie-qa-e2f9c` if exists. *Correction*: Based on extracting `google-services.json`, the ID is `bizzie-qa-e2f9c*`)
*(Self-correction: I will use the ID `bizzie-qa-e2f9c` extracted from the previous turn)*

**Project ID:** `bizzie-qa-e2f9c`
**Package/Bundle ID:** `io.getbizzie.bizzieapp.qa`

```bash
flutterfire configure \
  --project=bizzie-qa-e2f9c \
  --out=lib/config/firebase/firebase_options_qa.dart \
  --ios-bundle-id=io.getbizzie.bizzieapp.qa \
  --android-package-name=io.getbizzie.bizzieapp.qa \
  --platforms=android,ios \
  --yes
```

### 3. Production (Prod)
**Project ID:** `bizzie-prod`
**Package/Bundle ID:** `io.getbizzie.bizzieapp`

```bash
flutterfire configure \
  --project=bizzie-prod \
  --out=lib/config/firebase/firebase_options_prod.dart \
  --ios-bundle-id=io.getbizzie.bizzieapp \
  --android-package-name=io.getbizzie.bizzieapp \
  --platforms=android,ios \
  --yes
```

## Verification
After running these commands, check the `lib/config/firebase/` directory. You should see three files:
*   `firebase_options_dev.dart`
*   `firebase_options_qa.dart`
*   `firebase_options_prod.dart`

Open them and verify they contain a `DefaultFirebaseOptions` class with actual API keys, NOT the `UnimplementedError` stub.

### 4. Secure Your Configuration (Git Ignore)
Since these files contain API keys and project IDs, it is best practice to keep them out of public version control.

**Action:** Add the directory to your `.gitignore`:
```bash
echo "lib/config/firebase/" >> .gitignore
```

### 5: Firebase Options (Dart)
Since these files are now ignored, your CI/CD pipeline (GitHub Actions) will fail because it cannot find them. You must inject them as secrets. These files are critical for Auth and GenUI but are ignored from Git. Use the same Base64 encoding strategy.

1.  **Dev Environment:**
    ```bash
    base64 -i lib/config/firebase/firebase_options_dev.dart | pbcopy
    ```
    *   Secret: `DEV_FIREBASE_OPTIONS_DART_BASE64`
    *   Value: [Paste Base64 String]

2.  **QA Environment:**
    ```bash
    base64 -i lib/config/firebase/firebase_options_qa.dart | pbcopy
    ```
    *   Secret: `QA_FIREBASE_OPTIONS_DART_BASE64`
    *   Value: [Paste Base64 String]

3.  **Prod Environment:**
    ```bash
    base64 -i lib/config/firebase/firebase_options_prod.dart | pbcopy
    ```
    *   Secret: `PROD_FIREBASE_OPTIONS_DART_BASE64`
    *   Value: [Paste Base64 String]

### 6. Update CI Workflow (Agent Task)
If your `deploy.yml` has not been updated yet, ask the Agent to do it for you.

**Prompt to copy-paste to Agent:**
> "Update the `.github/workflows/deploy.yml` pipeline to handle the new Firebase Options secrets.
> 1. Map `DEV_FIREBASE_OPTIONS_DART_BASE64` (and QA/PROD) to env vars.
> 2. Add a build step to decode them into `lib/config/firebase/firebase_options_{env}.dart` before the build starts."

---

## Troubleshooting

### Error: "Failed to list Firebase projects (401/400)" or "Found 0 Firebase projects"
If `flutterfire configure` fails to find your projects, your local token might be stale or corrupt.

**Fix:**
1.  Run `firebase logout`
2.  Run `firebase login` (this refreshes the token via browser)
3.  Retry the configuration command.

### Prompt: "Enable Gemini in Firebase features?"
You may see this prompt when running `firebase login`:
```text
i  The Firebase CLI’s MCP server feature can optionally make use of Gemini in Firebase.
? Enable Gemini in Firebase features? (y/n)
```
*   **What it is:** This enables AI features *within the CLI itself* (e.g. asking it to write Firestore rules).
*   **Recommendation:** You can safely say **No (`n`)** if you just want to proceed with setup. Saying Yes/No does **NOT** affect your app's ability to use the Gemini API (GenUI).
