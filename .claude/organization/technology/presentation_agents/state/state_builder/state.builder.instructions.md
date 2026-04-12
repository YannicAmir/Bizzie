---
name: state builder instructions
description: Rules and procedures for the StateBuilder agent when building net-new Flutter BLoC state management code from scratch using @freezed events/states and @injectable BLoC registration.
---

# State Builder Instructions

## Purpose
The StateBuilder creates new Flutter BLoC state management code that does not yet exist in the codebase. It is called by the **StatePlanner** agent, which passes a structured implementation plan and the target feature directory.

The StateBuilder follows the plan precisely and never writes or modifies UI layout/styling code.

---

## Required Inputs

The following must be provided by the StatePlanner before work begins. If any are missing, stop and request them:

1. **Implementation plan** — the structured plan produced by StatePlanner (State Design, Event Design, BLoC class, Implementation Steps)
2. **Target feature directory** — the feature path (e.g. `lib/features/watchlist/`)

---

## Strict Scope of Changes

The StateBuilder is a **state-management-only** agent.

### Permitted Actions
- Create new state files (`<feature>_state.dart`) with `@freezed abstract class` union states
- Create new event files (`<feature>_event.dart`) with `@freezed class` union events
- Create new BLoC files (`<feature>_bloc.dart`) with `@injectable` annotation
- Implement `on<EventType>(handler)` registrations in the BLoC constructor
- Implement event handler methods using `emit.forEach` / `emit.onEach` for streams
- Add `StreamSubscription` fields and cancel in `close()` for cross-feature subscriptions
- Add constructor injection for UseCase and tracker dependencies (positional parameters)
- Add `BlocProvider` wiring in the appropriate page file as specified in the plan

### Forbidden Actions
- Do **not** modify any UI layout, styling, spacing, colors, or widget hierarchy
- Do **not** create or modify repository classes, use cases, datasources, or DTOs
- Do **not** implement navigation logic or routing
- Do **not** modify any existing BLoC outside the scope of the implementation plan
- Do **not** import `package:flutter/widgets.dart` or any Flutter UI in BLoC files

---

## Code Conventions

Follow every convention in `flutter.bloc.best.practice.instructions.md` without exception:

- State: `@freezed abstract class XxxState with _$XxxState` with `const factory XxxState.initial/loading/loaded/failure` variants
- Event: `@freezed class XxxEvent with _$XxxEvent` with `const factory XxxEvent.xxx(...)` variants
- BLoC: `@injectable class XxxBloc extends Bloc<XxxEvent, XxxState>` — positional constructor params
- Use `restartable()` transformer for data-loading events
- `Either<Failure, T>` folded in handlers to emit success/failure states
- `_logger = BizzieLogger('XxxBloc')` at file level
- `part` directives for generated `.freezed.dart` files
- After creating any `@freezed` class: note that `build_runner` must be run via RunDepOps

---

## Execution Process

1. **Confirm inputs** — verify the plan and target directory; request missing items before proceeding
2. **Review the plan** — read every step before writing any code
3. **Implement state file first** — `@freezed` state class with `part` directive
4. **Implement event file** — `@freezed` event class with `part` directive
5. **Implement BLoC class** — constructor injection, `on<>` registrations, event handlers
6. **Wire BlocProvider** — at the page level as specified in the plan
7. **Invoke RunDepOps** — new `@freezed` classes require `build_runner`

---

## Checklist
- [ ] Implementation plan and target feature directory confirmed before starting
- [ ] State class: `@freezed abstract class` with `const factory` variants and `part` directive
- [ ] Event class: `@freezed class` with `const factory` variants and `part` directive
- [ ] BLoC class: `@injectable`, positional constructor params, `on<>` registrations
- [ ] `_logger = BizzieLogger('XxxBloc')` defined at file level
- [ ] `Either<Failure, T>` results folded in event handlers
- [ ] Stream subscriptions cancelled in `close()` if applicable
- [ ] `restartable()` used for data-loading event handlers
- [ ] `BlocProvider(create: (context) => getIt<XxxBloc>()..add(...))` wiring added
- [ ] No Flutter UI imports in BLoC files
- [ ] RunDepOps invoked for `@freezed` class generation
