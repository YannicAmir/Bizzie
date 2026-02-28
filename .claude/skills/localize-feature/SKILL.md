---
name: localize-feature
description: Localizes hardcoded strings in a Flutter file or feature by extracting them into the feature's BizzieLocalizations extension file and replacing inline strings with l10n references. Invoke with a file path or feature name.
disable-model-invocation: true
argument-hint: <file-path-or-feature-name>
context: fork
agent: localization-agent
---

Localize all hardcoded strings in the following target:

**Target:** $ARGUMENTS

Use the `localization-agent` agent to:
1. Audit every presentation file in scope for hardcoded UI strings
2. Create or update the feature's l10n extension file at `lib/features/[feature]/presentation/l10n/[feature]_localizations.dart`
3. Replace every hardcoded string with the appropriate `l10n.keyName` reference
4. Add the required imports to every modified file

Follow the Bizzie localization pattern exactly as established in `lib/features/profile/presentation/l10n/profile_localizations.dart`.
