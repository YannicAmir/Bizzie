---
name: theme and styling guidance
description: Flutter theme and styling rules for all technology agents. Governs colors (AppColors), typography (AppTextStyles with GoogleFonts.inter), spacing (AppConstants), component theming, and theme access patterns for this Flutter mobile app.
---

# Theme & Styling Guidance

---

## 1. Colors — AppColors

Location: `lib/app/themes/app_colors.dart`

- All colors must be declared as `static const` properties in `AppColors`. Never write raw hex values (`Color(0xff...)`) or `Color.fromRGBO(...)` inline in a widget.
- Never use `Colors.white`, `Colors.black`, or any `Colors.*` inline — reference `AppColors` instead. `Colors.transparent` is the only exception.
- Before adding a new color, check `AppColors` first — do not add near-duplicate constants.

```dart
// Wrong
color: const Color(0xff404040)
color: Colors.white

// Correct
color: AppColors.textPrimary
color: AppColors.backgroundPrimary
```

---

## 2. Typography — AppTextStyles

Location: `lib/app/themes/app_text_styles.dart`

All text styles are `static final TextStyle` properties built with `GoogleFonts.inter(...)`. Access them directly — do not construct `TextStyle(...)` from scratch inline.

Available style names (non-exhaustive):
- **Headings**: `AppTextStyles.h1`, `.h2`, `.h3`, `.sectionHeader`
- **Body**: `AppTextStyles.bodyLarge`, `.bodyLargeBold`, `.bodyMedium`, `.bodyMediumBold`, `.bodySmall`, `.bodySmallBold`
- **Secondary variants**: `AppTextStyles.bodyLargeSecondary`, `.bodyMediumSecondary`, `.bodySmallSecondary`
- **Interactive**: `AppTextStyles.button`, `.smallLink`, `.smallLinkBold`, `.forgotPassword`
- **Utility**: `AppTextStyles.caption`, `.subtitle`, `.inputHint`, `.loaderMessage`

```dart
// Wrong
style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)

// Correct
style: AppTextStyles.bodyLargeBold

// Correct — override only what differs
style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)
```

Font sizes and weights are defined in `AppTextStyles` — never magic numbers in widgets.

---

## 3. Spacing & Layout — AppConstants

Location: `lib/shared/constants/app_constants.dart`

Common spacing values are named constants in `AppConstants`. Never repeat magic numbers inline.

Key constants:
- `AppConstants.pagePadding` — `EdgeInsets.fromLTRB(16, 16, 16, 24)` — standard page padding
- `AppConstants.mainButtonHeight` — `54.0`
- `AppConstants.smallButtonHeight` — `40.0`
- `AppConstants.mainSectionSpacing` — `SizedBox(height: 24)`
- `AppConstants.secondarySectionSpacing` — `SizedBox(height: 16)`
- `AppConstants.subSectionSpacing` — `SizedBox(height: 8)`
- `AppConstants.mainSectionBorderRadius` — `16.0`

Any spacing value used in more than two places must be extracted as a named constant in `AppConstants`.

---

## 4. Component Theming

Component-level styles (`BottomNavigationBarThemeData`, `DialogThemeData`, `BottomSheetThemeData`, etc.) are set once in `AppTheme.lightTheme` and consumed via `Theme.of(context)`. Do not re-declare them locally.

When overriding for a subtree, wrap in a `Theme` widget using `.copyWith()`:

```dart
// Wrong — re-declaring locally
BottomNavigationBar(selectedItemColor: const Color(0xffXXXXXX))

// Correct — subtree override
Theme(data: Theme.of(context).copyWith(...), child: ...)
```

---

## 5. ThemeExtensions

The app uses custom `ThemeExtension` classes (`MascotThemeExtension`, `BadgeThemeExtension`) registered in `AppTheme.lightTheme`. Access via:
```dart
Theme.of(context).extension<MascotThemeExtension>()
```

---

## 6. Constraints

- Only a light theme is supported. Do not introduce `darkTheme` as a side-effect of feature work.
- Changes to `AppColors`, `AppTextStyles`, or `AppConstants` must be intentional and isolated — never a side-effect of feature work.

---

## 7. Checklist

- [ ] No raw hex values or `Color.fromRGBO` inline in widgets
- [ ] No `Colors.white`, `Colors.black`, or other `Colors.*` inline (except `Colors.transparent`)
- [ ] All text styles via `AppTextStyles.xxx` — no `TextStyle(...)` constructed from scratch inline
- [ ] No magic number font sizes or spacing values
- [ ] Spacing uses `AppConstants` named constants
- [ ] No component themes re-declared locally when `AppTheme.lightTheme` already covers them
- [ ] No `darkTheme` introduced as a side-effect
- [ ] No near-duplicate color constants added without checking `AppColors` first
