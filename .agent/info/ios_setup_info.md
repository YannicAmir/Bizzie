# iOS Environment Setup Guide for Flutter

This guide outlines the steps to configure **Dev**, **QA**, and **Prod** environments for your iOS app. This setup ensures that you can install all three versions of the app on the same device simultaneously, each with its own Bundle ID, Display Name, and backend configuration.

## Prerequisites
- Open `ios/Runner.xcworkspace` in Xcode.
- Ensure you have your `main_dev.dart`, `main_qa.dart`, and `main_prod.dart` files ready in `lib/`.

---

## Step 1: Create Build Configurations
Build configurations allow you to define different settings (like Bundle ID and App Name) for each environment.

1. In Xcode, select the **Runner** project (the blue icon at the very top of the left navigation pane).
2. Select the **Info** tab in the main editor area.
3. Locate the **Configurations** section. You will see `Debug`, `Release`, and `Profile`.
4. We need to duplicate these for each environment (Dev, QA, Prod).
   - **Dev**:
     - Click the `+` icon -> **Duplicate "Debug" Configuration** -> Rename to `Debug-dev`
     - Click the `+` icon -> **Duplicate "Release" Configuration** -> Rename to `Release-dev`
     - Click the `+` icon -> **Duplicate "Profile" Configuration** -> Rename to `Profile-dev`
   - **QA**:
     - Repeat the process (Duplicate Debug/Release/Profile) -> Rename to `Debug-qa`, `Release-qa`, `Profile-qa`.
   - **Prod**:
     - Repeat the process -> Rename to `Debug-prod`, `Release-prod`, `Profile-prod`.
   - *Optional: You can keep the original Debug/Release/Profile as "Prod" if you prefer, but being explicit (`*-prod`) is cleaner.*

---

## Step 2: Configure Schemes
Schemes tell Xcode which configuration to use when you build or run the app.

1. Click on the active scheme name (next to the play/stop buttons in the top toolbar) -> **Manage Schemes...**
2. Select the existing `Runner` scheme and click the `...` (or just hit Enter to rename) -> Rename it to `dev`.
3. With `dev` selected, click **Edit...**
   - **Run** (Debug): Set "Build Configuration" to `Debug-dev`.
   - **Test**: Set "Build Configuration" to `Debug-dev`.
   - **Profile**: Set "Build Configuration" to `Profile-dev`.
   - **Analyze**: Set "Build Configuration" to `Debug-dev`.
   - **Archive** (Release): Set "Build Configuration" to `Release-dev`.
   - Close the dialog.
4. Back in "Manage Schemes", duplicate the `dev` scheme logic for `qa` and `prod`:
   - Click `+` to add a new scheme. Target: `Runner`. Name: `qa`.
   - Edit `qa` scheme configuration to use `*-qa` configurations.
   - Click `+` to add a new scheme. Target: `Runner`. Name: `prod`.
   - Edit `prod` scheme configuration to use `*-prod` configurations.
5. Ensure the "Shared" checkbox is checked for all 3 schemes so they are committed to git.

---

## Step 3: Configure Build Settings (Bundle ID & App Name)
Now we define the unique properties for each environment.

1. Select the **Runner** target (under "Targets" in the project settings view).
2. Go to the **Build Settings** tab.
3. **Product Bundle Identifier**:
   - Filter for `Product Bundle Identifier`.
   - Expand the setting to see all configurations.
   - Set unique IDs for each:
     - `Debug-dev`, `Release-dev`, etc. -> `io.getbizzie.bizzie.dev`
     - `Debug-qa`, `Release-qa`, etc. -> `io.getbizzie.bizzie.qa`
     - `Debug-prod`, `Release-prod`, etc. -> `io.getbizzie.bizzie` (Your main ID)
4. **App Display Name** (User-Friendly Name):
   - Filter for `Product Name` or `Display Name`. If `Display Name` isn't there, you can use a user-defined setting or modify `Info.plist`.
   - **Recommended**: Add a User-Defined Setting.
     - Scroll to the bottom (or click `+` -> Add User-Defined Setting).
     - Name it `APP_DISPLAY_NAME`.
     - Set values:
       - `*-dev`: `Bizzie Dev`
       - `*-qa`: `Bizzie QA`
       - `*-prod`: `Bizzie`
5. Update `Info.plist`:
   - Open `ios/Runner/Info.plist`.
   - Find the key `Bundle display name` (or `CFBundleDisplayName`).
   - Change its value to `$(APP_DISPLAY_NAME)`.

---

## Step 4: Run the App
To run the app in a specific environment, use the `--flavor` flag along with the correct entry point.

### CLI
```bash
# Dev
flutter run --flavor dev -t lib/main_dev.dart

# QA
flutter run --flavor qa -t lib/main_qa.dart

# Prod
flutter run --flavor prod -t lib/main_prod.dart
```

### VS Code (launch.json)
You likely already have this, but ensure your `launch.json` configurations look like this:

```json
{
    "name": "Bizzie Dev",
    "request": "launch",
    "type": "dart",
    "program": "lib/main_dev.dart",
    "args": ["--flavor", "dev"]
},
{
    "name": "Bizzie QA",
    "request": "launch",
    "type": "dart",
    "program": "lib/main_qa.dart",
    "args": ["--flavor", "qa"]
}
```

---

## Summary of Results
- **Dev App**: Bundle ID `...dev`, Name "Bizzie Dev"
- **QA App**: Bundle ID `...qa`, Name "Bizzie QA"
- **Prod App**: Bundle ID `...`, Name "Bizzie"

You can now install all three on your iPhone or Simulator simultaneously!
