# Localization Setup Guide

This document explains the localization system used in the Bizzie app and how the `localize-feature` skill works.

## How Bizzie Localization Works

Bizzie uses a **custom, extension-based localization system** — not Flutter's standard `gen_l10n` / `.arb` file approach.

### Core Infrastructure

The central class is `BizzieLocalizations` at `lib/app/l10n/bizzie_localizations.dart`. It is already wired into the app's `MaterialApp` via `BizzieLocalizationsDelegate`. Currently it supports English only; the `getString({required String en})` method simply returns the English string. This design makes it trivial to add new locales later without changing call sites.

### Feature Extension Files

Each feature defines its own Dart extension on `BizzieLocalizations`. This keeps feature strings scoped and avoids a monolithic l10n file.

**Location:** `lib/features/[feature_name]/presentation/l10n/[feature_name]_localizations.dart`

**Example** (from `lib/features/profile/presentation/l10n/profile_localizations.dart`):
```dart
import 'package:bizzie/app/l10n/bizzie_localizations.dart';

extension ProfileLocalizations on BizzieLocalizations {
  String get bizziePlus => getString(en: 'Bizzie Plus');

  String get profileSettings => getString(en: 'Settings');

  String profileJoined(String date) {
    return getString(en: 'Joined $date');
  }
}
```

### Using Localizations in a Widget

```dart
import 'package:bizzie/app/l10n/bizzie_localizations.dart';
import 'package:bizzie/features/profile/presentation/l10n/profile_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = BizzieLocalizations.of(context);

    return Text(l10n.profileSettings);
  }
}
```

## Using the Localize-Feature Skill

The `/localize-feature` slash command invokes the `localization-agent` to do this work automatically.

### Invocation Examples

Localize a single file:
```
/localize-feature lib/features/auth/presentation/views/login_view.dart
```

Localize all presentation files in a feature:
```
/localize-feature auth
```

Localize multiple specific files:
```
/localize-feature lib/features/settings/presentation/views/settings_view.dart lib/features/settings/presentation/widgets/settings_tile.dart
```

### What the Agent Does

1. Reads every target file and identifies hardcoded UI strings
2. Derives the feature name from the file path
3. Creates (or updates) `lib/features/[feature]/presentation/l10n/[feature]_localizations.dart`
4. Replaces each hardcoded string in the source files with `l10n.keyName`
5. Adds the necessary imports to every modified file

### Manual Steps Required

No setup is required — the `BizzieLocalizations` infrastructure is already in place and wired into the app. Simply run the skill and the agent will handle everything.

### What to Check After Running the Agent

1. Run `flutter analyze` to confirm no new errors were introduced:
   ```
   flutter analyze
   ```
2. Hot-reload the app and visually verify the affected screens look identical
3. Review the new/updated l10n extension file to ensure key names are meaningful

### Adding a New Locale in the Future

If you want to add a second language (e.g., Spanish):

1. Add `Locale('es', 'ES')` to `BizzieLocalizations.supportedLocales`
2. Update `getString` to accept an `es` parameter:
   ```dart
   String getString({required String en, String? es}) {
     if (locale.languageCode == 'es' && es != null) return es;
     return en;
   }
   ```
3. All existing call sites will continue to compile — just add `es:` named arguments where translations exist

## Conventions

- Key names are camelCase and describe the **meaning**, not just the text
- Parameterized strings (containing `$variable`) become methods, not getters
- Simple static strings become `String get` getters
- Feature extension files use a matching name: `ProfileLocalizations`, `AuthLocalizations`, etc.
- Never hardcode strings directly in widget files — always go through l10n
