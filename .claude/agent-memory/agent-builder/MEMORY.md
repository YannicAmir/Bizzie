# Agent Builder Memory

## Created Agents & Skills

### localization-agent (created 2026-02-28)
- File: `.claude/agents/localization-agent.md`
- Paired skill: `.claude/skills/localize-feature/SKILL.md`
- Invoked via: `/localize-feature <file-or-feature>`
- Reference example: `lib/features/profile/presentation/l10n/profile_localizations.dart`

## Bizzie Localization Pattern (confirmed from source)
- Core class: `lib/app/l10n/bizzie_localizations.dart` — `BizzieLocalizations` with `getString({required String en})`
- Feature extensions at: `lib/features/[feature]/presentation/l10n/[feature]_localizations.dart`
- Extension pattern: `extension [Feature]Localizations on BizzieLocalizations { ... }`
- Widget usage: `final l10n = BizzieLocalizations.of(context);`
- Both imports needed: base class + feature extension
- NOT using `.arb` files or Flutter gen_l10n — custom extension-based system

## Project Notes
- Features live in `lib/features/[feature_name]/` with data/domain/presentation layers
- State management: flutter_bloc + freezed, use `map`/`maybeMap` (never if/else on states)
- No widget-returning functions — always extract to StatelessWidget/StatefulWidget
- Colors: AppColors, Typography: AppTextStyles — never inline
