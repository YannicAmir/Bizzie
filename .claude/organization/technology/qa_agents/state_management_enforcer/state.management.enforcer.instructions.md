---
name: state management enforcer instructions
description: Domain-specific checks for StateManagementEnforcer. Violations to look for when measuring BLoC implementation against flutter.bloc.best.practice.instructions.md. References qa.enforcement.pattern.instructions.md for retry loop rules.
---

# State Management Enforcer Instructions

## Guidance Source
Verify all changed files against every checklist item in `flutter.bloc.best.practice.instructions.md`.

## Key Violation Categories

### State class violations
- State class not declared as `@freezed abstract class XxxState with _$XxxState`
- State class not using `const factory XxxState.xxx(...)` factory constructors
- Missing `initial`, `loading`, `loaded`, or `failure` factory variant for any async flow
- `part '<feature>_state.freezed.dart'` directive missing from state file
- State class using Equatable or `props` instead of `@freezed`

### Event class violations
- Event class not declared as `@freezed sealed class XxxEvent with _$XxxEvent`
- Event class not using `const factory XxxEvent.xxx(...)` factory constructors
- `part '<feature>_event.freezed.dart'` directive missing from event file
- Event class using Equatable or `props` instead of `@freezed`

### BLoC class violations
- BLoC class missing `@injectable` annotation
- BLoC class not extending `Bloc<XxxEvent, XxxState>`
- Constructor parameters not positional (must not use named parameters)
- Dependency obtained via `GetIt.I()` inside the BLoC instead of via constructor injection
- Business logic or domain logic placed directly in the BLoC instead of delegating to a use case
- `Either<Failure, T>` result not folded in event handler — raw result accessed without `fold`
- Event handler exceeding ~30 lines or mixing responsibilities — analytics metrics construction, data mapping, or guard evaluation inlined in the handler body instead of extracted to private helpers
- Identical logic duplicated between the failure and success branches of a `fold` instead of extracted into a single parameterised helper
- No-op event handler (empty body, comment-only body, or body with no behaviour) registered in the BLoC — the event pipeline is dead code (YAGNI) and must be removed end-to-end: event variant, `on<>` registration, handler, and all dispatch sites together (partial removal causes a runtime `StateError` on `add`)
- Data-loading event handler missing `restartable()` transformer
- Stream-backed event handler using `await for` instead of `emit.forEach` / `emit.onEach`
- `StreamSubscription` created in BLoC but not cancelled in `close()` override
- BizzieLogger not defined at file level (`_logger = BizzieLogger('XxxBloc')`)
- `package:flutter/widgets.dart` or any Flutter UI package imported in a BLoC file

### BlocProvider / widget wiring violations
- `BlocProvider` created with `getIt<XxxBloc>()` but without the initial `..add(XxxEvent.started())` call where required
- Feature-level BLoC provided too high in the widget tree (outside the feature's page)

## Enforcement Loop
Follow the retry loop rules in `qa.enforcement.pattern.instructions.md`.

## Checklist
- [ ] All changed files read
- [ ] Every item in `flutter.bloc.best.practice.instructions.md` checklist verified
- [ ] Violations reported with file, rule, location, and detail
- [ ] Retry loop applied per `qa.enforcement.pattern.instructions.md`
