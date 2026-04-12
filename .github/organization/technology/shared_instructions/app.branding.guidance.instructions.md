---
name: app branding guidance
description: Project-specific guidelines for updating the Flutter app icon and splash screens. Covers flutter_launcher_icons.yaml for both iOS and Android, flutter_native_splash.yaml for native splash, AppAssets branding constants, and the Flutter splash widget. Referenced by the AppBrander agent.
---

# App Branding Guidance

> When brand assets change, **both** the native splash and the Flutter splash must be updated. They are independent layers and neither substitutes for the other.

---

## 1. Overview

| Concept | What it is | Managed by |
|---|---|---|
| **App icon** | Home screen / launcher icon | `flutter_launcher_icons.yaml` + `dart run flutter_launcher_icons` |
| **Native splash** | OS-level screen before Flutter renders | `flutter_native_splash.yaml` + `dart run flutter_native_splash:create` |
| **Flutter splash** | Flutter-rendered brand screen after engine loads | `Image.asset(AppAssets.splashLogo)` in the splash route widget |

---

## 2. Source Asset Files

All branding assets live under `assets/images/branding/`:

```
assets/images/branding/
├── app_icon.png        ← source for app icon (iOS + Android + web)
├── splash_logo.png     ← centre image on native splash screen
└── splash_branding.png ← branding strip at bottom of native splash
```

Referenced in code via `AppAssets` constants:
- `AppAssets.appIcon` → `assets/images/branding/app_icon.png`
- `AppAssets.splashLogo` → `assets/images/branding/splash_logo.png`

---

## 3. App Icon — flutter_launcher_icons

Configuration lives in `flutter_launcher_icons.yaml` at the repo root (**not** in `pubspec.yaml`):

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/images/branding/app_icon.png"
  min_sdk_android: 21
```

Both iOS **and** Android icons are generated from the same source PNG. After replacing `app_icon.png`, regenerate with:
```
dart run flutter_launcher_icons
```

Do **not** edit generated icon files manually.

---

## 4. Native Splash — flutter_native_splash

Configuration lives in `flutter_native_splash.yaml` at the repo root:

```yaml
flutter_native_splash:
  color: "#ffffff"
  image: assets/images/branding/splash_logo.png
  branding: assets/images/branding/splash_branding.png
  branding_bottom_padding: 20
  android_12:
    color: "#ffffff"
    image: assets/images/branding/splash_logo.png
    branding: assets/images/branding/splash_branding.png
```

After updating assets or config, regenerate with:
```
dart run flutter_native_splash:create
```

---

## 5. Flutter Splash Screen

After the native splash, Flutter renders its own splash at the `/splash` route. The widget uses `AppAssets` constants directly:

```dart
Image.asset(AppAssets.splashLogo)
```

Never hardcode splash asset paths in the widget — always use `AppAssets` constants.

---

## 6. Rules

| Rule | Detail |
|---|---|
| Icon source | `assets/images/branding/app_icon.png` |
| Icon generation | `flutter_launcher_icons.yaml` — run `dart run flutter_launcher_icons` after changing source |
| Native splash config | `flutter_native_splash.yaml` — run `dart run flutter_native_splash:create` after changing |
| Flutter splash | Use `AppAssets` constants — NEVER hardcode asset paths |
| Brand change | Update BOTH native splash YAML and Flutter splash assets |

---

## Checklist
- [ ] Updated branding PNG(s) placed in `assets/images/branding/`
- [ ] `AppAssets` constants updated if file names changed
- [ ] If app icon changed: `dart run flutter_launcher_icons` run
- [ ] If native splash changed: `flutter_native_splash.yaml` updated and `dart run flutter_native_splash:create` run
- [ ] If Flutter splash changed: asset updated — no path strings hardcoded in widget
- [ ] Both native splash and Flutter splash updated when brand changes require it
