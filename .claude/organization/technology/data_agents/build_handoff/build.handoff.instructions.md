---
name: build handoff instructions
description: Rules and procedures for the DataHandoffAgent when producing the post-build human-task checklist after a data layer build or update completes.
---

# Build Handoff Instructions

## Purpose
DataHandoffAgent produces a structured human-task checklist after a data layer build or update workflow completes. It surfaces every manual action that agents cannot perform — Firebase Remote Config values, CI/CD secrets, build verification, and test scenarios — so the engineer knows exactly what remains before a feature is production-ready.

---

## Required Inputs

Before producing the checklist, confirm the following are available. If missing, ask before proceeding:

1. **Changed files list** — the set of files created or modified in the build
2. **build_runner outcome** — whether it was run and whether it succeeded
3. **New Remote Config keys** (if any) — keys added to `RemoteConfigKeys` that must be set in Firebase console
4. **New feature name / area** — to tailor test scenario items

---

## Checklist Sections

Always produce the checklist with the following sections. Omit a section only if it has no items for this build.

### 1. Firebase Remote Config
For every new key added to `RemoteConfigKeys`:
- [ ] Set `<key_name>` in Firebase Remote Config — **dev** project
- [ ] Set `<key_name>` in Firebase Remote Config — **qa** project
- [ ] Set `<key_name>` in Firebase Remote Config — **prod** project

> Note: Remote Config values are NOT set automatically by agents. This is a required manual step before the feature will function in any environment.

### 2. Build Verification
- [ ] `dart run build_runner build --delete-conflicting-outputs` ran successfully (confirm no errors in output)
- [ ] `flutter analyze` — zero errors, zero warnings in changed files

### 3. Dependency Check
For any new packages referenced in changed files:
- [ ] Package added to `pubspec.yaml` and `flutter pub get` run

### 4. Injectable Registration
For every new `@injectable`, `@Injectable(as:)`, `@LazySingleton(as:)`, or `@Singleton` class:
- [ ] Confirm the class appears in `injection.config.dart` after build_runner (generated file)

### 5. Integration Testing
For each new datasource method or repository method:
- [ ] Manual smoke-test: [describe the happy path scenario, e.g. "open chat, send message, confirm response received"]
- [ ] Error path: [describe how to trigger the error, e.g. "revoke network access, confirm Failure.server is surfaced"]
- [ ] Rate limit path (if `Failure.rateLimit` is mapped): confirm retry countdown is surfaced in UI

### 6. Human-Only Tasks
List any steps identified during the build that are outside agent scope:
- Items typically include: `.env.*` file updates for new secrets (if any), App Store/Play Store configuration changes, backend feature flags

---

## Format Rules

- Output the checklist as GitHub-flavored Markdown
- Use `- [ ]` for unchecked items — never pre-check any item
- Group items under `###` section headers
- At the top, include a one-line summary: **Feature:** `<feature name>` | **Build type:** new / update | **build_runner:** ran / skipped
- Keep items concrete and actionable — reference specific key names, file names, or method names from the build

---

## Checklist
- [ ] Inputs confirmed (changed files, build_runner outcome, new RC keys, feature name)
- [ ] Firebase Remote Config section populated for every new `RemoteConfigKeys` entry
- [ ] Build Verification section included
- [ ] Injectable Registration section included if new annotated classes were added
- [ ] Integration Testing section populated with specific happy-path and error scenarios
- [ ] Human-Only Tasks section populated with any out-of-scope steps identified during the build
- [ ] Checklist output as GitHub-flavored Markdown with `- [ ]` items
