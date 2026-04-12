---
name: asset handling guidance
description: Project-specific asset coding guidelines for Flutter. Covers the assets/images/ folder structure, AppAssets constants class, Image.asset/SvgPicture.asset usage, pubspec.yaml registration, and naming conventions. Referenced by asset and branding agents.
---

# Asset Handling Guidance

> Asset paths are NEVER hardcoded in widgets. All paths come from `AppAssets` static constants. There is no `AppIcon` widget — use `Image.asset` or `SvgPicture.asset` directly with `AppAssets` constants.

---

## 1. Folder Structure

```
assets/
├── images/
│   ├── auth/           ← auth feature assets (icons + images)
│   ├── branding/       ← app icon, splash logo, splash branding
│   ├── company_profile/← company profile feature assets
│   ├── home/           ← bottom nav icons (selected/unselected SVGs)
│   ├── onboarding/     ← onboarding mascots and illustrations
│   ├── search/         ← search feature assets
│   └── shared/         ← app-wide shared icons and mascots
└── fonts/              ← custom font files (.otf / .ttf)
```

All asset folders are declared in `pubspec.yaml` under `flutter.assets`.

---

## 2. AppAssets — The Path Constants Class

Location: `lib/app/themes/app_assets.dart`

All asset paths are `static const String` properties, grouped by feature with section comments. The class has a private constructor — never instantiate it.

```dart
class AppAssets {
  AppAssets._();

  // Auth Feature
  static const String authAppleIcon = 'assets/images/auth/apple_icon.png';
  static const String authEmailIcon = 'assets/images/auth/email_icon.svg';

  // Branding
  static const String splashLogo = 'assets/images/branding/splash_logo.png';
  static const String appIcon    = 'assets/images/branding/app_icon.png';

  // Shared
  static const String backArrowIcon = 'assets/images/shared/back_arrow_icon.png';
}
```

**Naming conventions:**
- `lowerCamelCase` — always
- Prefix with the feature name: `authAppleIcon`, `homeSelectedIcon`, `companyProfileWebsiteIcon`
- Selected/unselected nav icon pairs: `homeSelectedIcon` / `homeUnselectedIcon`
- SVG and PNG paths are both `static const String` — no distinction in the constant type

---

## 3. Rendering Assets in Widgets

Detect file type by extension and choose the correct widget:

```dart
// PNG / bitmap
Image.asset(AppAssets.splashLogo)
Image.asset(AppAssets.authAppleIcon, width: 24, height: 24)

// SVG
SvgPicture.asset(AppAssets.authEmailIcon, width: 24, height: 24)
SvgPicture.asset(AppAssets.homeSelectedIcon, colorFilter: ColorFilter.mode(color, BlendMode.srcIn))
```

**Never** hardcode the path string directly in the widget:
```dart
// WRONG
Image.asset('assets/images/shared/back_arrow_icon.png')
SvgPicture.asset('assets/images/home/home_selected_icon.svg')
```

---

## 4. Registering New Assets

When adding a new asset file:

1. **Place the file** in the correct `assets/images/<feature>/` folder — create a new subfolder only if the feature is genuinely new
2. **Register in `pubspec.yaml`** if it is a new subfolder (existing declared folders pick up all files automatically):
   ```yaml
   flutter:
     assets:
       - assets/images/my_new_feature/
   ```
3. **Add a constant** to `AppAssets` in the correct feature section

---

## 5. Rules

| Rule | Detail |
|---|---|
| Asset paths | NEVER hardcoded in widgets — ALWAYS via `AppAssets` constants |
| PNG rendering | `Image.asset(AppAssets.xxx)` |
| SVG rendering | `SvgPicture.asset(AppAssets.xxx)` |
| No AppIcon widget | No such widget exists in this project |
| New assets | File → `assets/images/<feature>/`; new folder → register in `pubspec.yaml`; constant → `AppAssets` |
| Constant type | `static const String` — not `static String get` |

---

## Checklist
- [ ] New asset file placed in correct `assets/images/<feature>/` subfolder
- [ ] If new subfolder: registered in `pubspec.yaml` under `flutter.assets`
- [ ] `static const String` constant added to `AppAssets` in the correct section
- [ ] Constant name uses `lowerCamelCase` with feature prefix
- [ ] No asset path string hardcoded in any widget file
- [ ] PNG assets use `Image.asset(AppAssets.xxx)`, SVG assets use `SvgPicture.asset(AppAssets.xxx)`
