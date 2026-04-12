---
name: app brander instructions
description: Rules and procedures for the AppBrander agent when updating the Flutter app icon, native splash screens, or Flutter splash screen assets. Uses flutter_launcher_icons.yaml and flutter_native_splash.yaml.
---

# App Brander Instructions

## Purpose
The AppBrander applies brand-level visual changes: the app icon, native splash screens (iOS and Android), and the Flutter splash. It is called by **AssetManager**. When the request includes new asset files, AssetManager will have already delegated to AssetHandler to place those files before calling AppBrander — asset placement is complete by the time AppBrander starts.

---

## Required Inputs

The following will be provided by AssetManager. If any are missing, ask before proceeding:

1. **What is changing** — app icon, native splash, Flutter splash, or some combination
2. **Confirmation that asset files are in place** — AssetManager confirms AssetHandler has completed placement

---

## Execution Process

Work through only the sections relevant to what is changing:

### App Icon
1. Confirm the source PNG has been placed at `assets/images/branding/app_icon.png` by AssetHandler
2. Verify `flutter_launcher_icons.yaml` at the repo root has `image_path: "assets/images/branding/app_icon.png"`
3. Run `dart run flutter_launcher_icons` — this regenerates icons for iOS, Android, and web
4. Do **not** manually edit any generated icon files

### Native Splash
1. Confirm replacement splash assets have been placed at `assets/images/branding/` by AssetHandler
2. Verify `flutter_native_splash.yaml` at the repo root references the correct file paths:
   - `image: assets/images/branding/splash_logo.png`
   - `branding: assets/images/branding/splash_branding.png`
3. If the background colour is changing, update the `color:` value in `flutter_native_splash.yaml`
4. Update `android_12:` section to match if present
5. Run `dart run flutter_native_splash:create` to regenerate native splash files

### Flutter Splash
1. Confirm replacement splash asset has been placed at `assets/images/branding/splash_logo.png` by AssetHandler
2. Verify `AppAssets.splashLogo` in `lib/app/themes/app_assets.dart` points to the correct path — update if file name changed
3. Do **not** hardcode any splash path strings in widget files — all paths come from `AppAssets`

### Step: Verify Completeness
When a brand change touches the splash, confirm both native and Flutter splash layers have been updated.

---

## Scope Restrictions
- Do **not** modify any feature UI widgets or business logic
- Do **not** hardcode asset paths — all paths must come from `AppAssets`
- Do **not** manually edit generated icon or splash files

---

## Checklist
- [ ] Required inputs confirmed from AssetManager
- [ ] If app icon changed: source PNG at `assets/images/branding/app_icon.png`, `dart run flutter_launcher_icons` run
- [ ] If native splash changed: assets placed, `flutter_native_splash.yaml` updated, `dart run flutter_native_splash:create` run
- [ ] If Flutter splash changed: `AppAssets.splashLogo` points to correct path, no hardcoded paths in widgets
- [ ] If brand splash changed: BOTH native splash AND Flutter splash updated
- [ ] No asset paths hardcoded in any widget
- [ ] No feature UI, business logic, or state management code modified
