---
name: run dep ops instructions
description: Rules and procedures for the RunDepOps agent when running post-implementation code generation operations for the Flutter project. Covers the data layer (DTOs), domain layer (models, params), and presentation layer (BLoC states/events, injectable classes).
---

# RunDepOps Instructions

## Purpose
RunDepOps runs the `build_runner` code generation command after any Flutter code change that requires it. It is the final step in DataBuilder, DataUpdater, DataCorrector, DomainBuilder, DomainUpdater, DomainCorrector, StateBuilder, StateUpdater, and StateCorrector workflows.

---

## Decision — When to Run build_runner

Run `dart run build_runner build --delete-conflicting-outputs` if **any** of the following are true:

### Data layer (DTOs)
- A new DTO with `@freezed` + `json_serializable` was added
- An existing DTO was modified (fields added, removed, or renamed)

### Domain layer (models, params classes)
- A new `@freezed` domain model or params class was added
- An existing `@freezed` domain model was modified

### Presentation layer (BLoC state / events)
- A new `@freezed` event class was added or modified
- A new `@freezed` state class was added or modified

### DI (injectable classes)
- A new `@injectable`, `@lazySingleton`, `@LazySingleton(as:)`, or `@Injectable(as:)` annotated class was added
- An existing injectable class was renamed or removed

> **Both the domain layer and the data layer require build_runner.** Any `@freezed` or `@injectable` change anywhere in the project triggers code generation.

---

## When NOT to Run build_runner

Do **not** run build_runner if:
- Only non-annotated Dart classes were added or modified (no `@freezed`, no `@injectable`)
- Only repository method bodies were changed (no model/annotation changes)
- Only `BizzieLogger` calls, comments, or analytics calls were modified
- Only UI layout or widget changes were made

---

## Command

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run from the root of the Flutter app package (the directory containing `pubspec.yaml`). Report whether it succeeded or failed with the relevant output.

---

## Reporting

After completing, always report:
1. Whether build_runner was run (yes/no) and why
2. If run: success or failure, and any relevant output lines (errors, generated file names)
3. If failed: the exact error and what likely needs to be fixed

---

## Checklist
- [ ] Determined whether build_runner is required based on what was changed
- [ ] Considered ALL layers — not just data (domain models, BLoC events/states, and injectable classes also trigger build_runner)
- [ ] If required: ran `dart run build_runner build --delete-conflicting-outputs` from the correct package root
- [ ] Reported outcome clearly (run/not run, success/failure, generated files or errors)
