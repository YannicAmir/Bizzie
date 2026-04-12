---
name: asset handler instructions
description: Rules and procedures for the AssetHandler agent when placing new asset files into the Flutter project, registering them in pubspec.yaml, and adding AppAssets constants.
---

# Asset Handler Instructions

## Purpose
The AssetHandler places new image, icon, or SVG files into the correct `assets/images/` subfolder, registers any new subfolder in `pubspec.yaml`, and adds the corresponding `AppAssets` constant. It is called by **AssetManager** — either for a pure asset addition, or as the first step in a branding workflow.

---

## Required Inputs

The following must be confirmed before any work begins. If missing, ask before proceeding:

1. **The asset file** — the file the user wants to add
2. **The intended use** — what the asset is for (UI icon, feature image, branding asset, etc.) — determines which folder it belongs in

---

## Execution Process

### Step 1: Determine the Correct Folder

| Asset type | Target folder |
|---|---|
| Auth feature asset | `assets/images/auth/` |
| Branding / launcher / splash | `assets/images/branding/` |
| Company profile asset | `assets/images/company_profile/` |
| Home / nav icon | `assets/images/home/` |
| Onboarding asset | `assets/images/onboarding/` |
| Search feature asset | `assets/images/search/` |
| Shared / app-wide asset | `assets/images/shared/` |
| New feature | `assets/images/<feature>/` |

If no existing folder fits, ask the user to confirm a new subfolder name before creating it.

### Step 2: Place the File
Copy the asset file to the determined folder path.

### Step 3: Register in pubspec.yaml (new subfolders only)
If the target folder is **new** (not yet declared in `pubspec.yaml`), add it under `flutter.assets`:
```yaml
flutter:
  assets:
    - assets/images/my_new_feature/
```
Existing folders with a trailing `/` already cover all files — do not re-register them.

### Step 4: Add the AppAssets Constant
Open `lib/app/themes/app_assets.dart`. Locate the correct feature section comment and add a `static const String`:
```dart
// New Feature
static const String myNewIcon = 'assets/images/my_new_feature/my_new_icon.svg';
```
Name the constant using `lowerCamelCase` with a feature prefix (e.g., `authEmailIcon`, `homeSelectedIcon`).

---

## Scope Restrictions
- Do **not** modify any widget files or Dart source beyond `AppAssets`
- Do **not** make any changes to branding-specific native files — those are AppBrander's responsibility
- Do **not** run `dart run flutter_launcher_icons` — that is AppBrander's responsibility

---

## Checklist
- [ ] Asset use confirmed — correct target folder identified
- [ ] Asset file placed in the correct `assets/images/<feature>/` subfolder
- [ ] If new subfolder: registered in `pubspec.yaml` under `flutter.assets` with trailing `/`
- [ ] Existing folders not re-registered in `pubspec.yaml`
- [ ] `static const String` constant added to `AppAssets` in the correct section
- [ ] Constant name uses `lowerCamelCase` with feature prefix
- [ ] No widget files or Dart source beyond `AppAssets` modified
- [ ] No native branding files touched
