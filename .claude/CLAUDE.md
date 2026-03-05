# Bizzie — Flutter Finance App

A mobile finance application built with Flutter and Dart, following Feature-Driven Clean Architecture.

## Common Commands

- **Run app:** `flutter run --flavor dev`
- **Build APK:** `flutter build apk --flavor dev`
- **Run tests:** `flutter test`
- **Run single test:** `flutter test <path_to_test_file>`
- **Code generation:** `dart run build_runner build --delete-conflicting-outputs`
- **Analyze:** `flutter analyze`
- **Get dependencies:** `flutter pub get`

## Architecture

This project uses **Feature-Driven Clean Architecture** with three layers:
- **Data** — DTOs, datasources, repository implementations
- **Domain** — Models, interfaces (contracts), usecases
- **Presentation** — BLoC/Cubit, views, widgets

Features live in `lib/features/[feature_name]/` and are self-contained.

## State Management

- `flutter_bloc` + `freezed` for state unions and pattern matching
- Use `map`/`maybeMap` for exhaustive state handling — never use `if/else` on states

## Key Paths

- **Theme:** `lib/app/themes/` (AppTheme, AppColors, AppTextStyles, AppAssets)
- **DI:** `lib/di/injection.dart` (GetIt + Injectable)
- **Routes:** `lib/app/routes/app_routes.dart` (all routes as static constants)
- **Validators:** `lib/shared/utils/validators.dart` (all form validation)

## Rules

See `.claude/rules/` for detailed standards:
- `architecture-rules.md` — Clean Architecture boundaries and folder structure
- `best-practice-rules.md` — Widget patterns, styling tokens, performance
- `technology-stack-rules.md` — Full tech stack and dependency guidelines

## Agents

- **Agent Builder** (`agent-builder`) — Creates new skills, subagents, and hooks from a capability description. Invoke via `/build-agent <description>`.
- **Localization Agent** (`localization-agent`) — Audits files for hardcoded strings, creates/updates feature l10n extension files, and replaces strings with l10n references. Invoked automatically by `/localize-feature`.

## Skills

- `/build-agent <description>` — Describe a capability you need and the Agent Builder will create the necessary skills, subagents, and/or hooks for you.
- `/localize-feature <file-path-or-feature-name>` — Localizes hardcoded strings in a file or feature using the Bizzie localization pattern (BizzieLocalizations extensions).
