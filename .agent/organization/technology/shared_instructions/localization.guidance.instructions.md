---
name: localization guidance
description: Project-specific localisation coding guidelines for Flutter. Covers BizzieLocalizations usage, English-only getString() pattern, feature l10n extensions, and string conventions. This app is English-only — no .arb files, no multi-language support. Referenced by localisation agents.
---

# Localization Guidance

> All user-facing strings are resolved through `BizzieLocalizations` — never hardcode strings in widget files. This project is **English-only**. It does NOT use Flutter's `.arb` / code-gen approach.

---

## 1. Architecture

`BizzieLocalizations` is a simple runtime-resolved string class with a single `getString()` method.

Location: `lib/app/l10n/bizzie_localizations.dart`

```
BizzieLocalizations.of(context)   ← access point in widgets
        │
        └── getString(en: '...')   ← always English-only
```

Supported locales: `[Locale('en', 'US')]` — no other locales.

Feature strings live in extensions on `BizzieLocalizations`:

| File | Purpose |
|---|---|
| `lib/features/<feature>/l10n.dart` | Feature-specific UI strings |

---

## 2. Accessing Localisation in Widgets

Always use `BizzieLocalizations.of(context)`. Assign to a local variable `l10n` at the top of `build()`. Never store as an instance variable.

```dart
@override
Widget build(BuildContext context) {
  final l10n = BizzieLocalizations.of(context);
  return Text(l10n.myFeatureTitle);
}
```

---

## 3. Adding Strings — Feature l10n.dart

Every feature owns its strings in an extension on `BizzieLocalizations` at `lib/features/<feature>/l10n.dart`.

**Simple string — use a getter:**
```dart
import 'package:bizzie/app/l10n/bizzie_localizations.dart';

extension MyFeatureLocalizations on BizzieLocalizations {
  String get myFeatureTitle => getString(en: 'My Feature');
  String get emptyStateMessage => getString(en: 'Nothing to show yet');
}
```

**String with parameters — use a method, not a getter:**
```dart
String itemsFound(int count) => getString(
  en: '$count item${count == 1 ? '' : 's'} found',
);

String welcomeMessage(String name) => getString(en: 'Welcome, $name');
```

**Pluralisation — use Dart `switch` inside the string argument:**
```dart
String companiesFound(int count) => getString(
  en: switch (count) {
    0 => 'No companies found',
    1 => '1 company found',
    _ => '$count companies found',
  },
);
```

---

## 4. Rules

| Rule | Detail |
|---|---|
| User-facing strings | NEVER hardcoded in widget files — ALWAYS in an `l10n` extension |
| Feature strings | `lib/features/<feature>/l10n.dart` as extension on `BizzieLocalizations` |
| Language | English-only — `getString` takes only `en:` parameter |
| No `.arb` files | This project does not use Flutter's code-gen localisation |
| Parameterised strings | Use a method (not a getter) |
| Pluralisation | Dart `switch` inside the string argument |
| Access | `BizzieLocalizations.of(context)` assigned to local `l10n` in `build()` — never stored as instance variable |

---

## Checklist
- [ ] No user-facing strings hardcoded in widget files
- [ ] All new feature strings in `lib/features/<feature>/l10n.dart` as extension on `BizzieLocalizations`
- [ ] `getString` uses only `en:` named parameter — no `de:`, `deDE:`, or other language params
- [ ] Parameterised strings use a method (not a getter)
- [ ] Pluralisation uses Dart `switch` inside the string argument
- [ ] `BizzieLocalizations.of(context)` assigned to local `l10n` in `build()` — not stored as instance variable
- [ ] No `.arb` files created — this project does not use Flutter code-gen localisation
