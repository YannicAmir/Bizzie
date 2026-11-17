---
name: flutter bloc best practice
description: Project-specific BLoC coding guidelines. Covers BLoC with freezed events/states, injectable constructor pattern, no BLoC-to-BLoC dependencies, event handlers, concurrency transformers, stream subscriptions, providing blocs, and consuming state in widgets. Referenced by all state management agents.
---

# Flutter BLoC Best Practice

> This app uses **BLoC with Events** (not Cubit). All state and event classes use `@freezed`. All BLoCs are registered via `@injectable`.

---

## 1. State — @freezed Union

File: `<feature>_state.dart`

Rules:
- `@freezed abstract class XxxState with _$XxxState`
- `part '<feature>_state.freezed.dart'` directive required
- `const factory XxxState.initial() = _Initial` — always present
- `const factory XxxState.loading() = _Loading` — for async flows
- `const factory XxxState.loaded(List<XxxItem> items) = XxxLoaded` — descriptive name for the data-bearing state
- `const factory XxxState.failure(Failure failure) = _Failure` — for all error states
- Use `@Default(value)` for optional fields with defaults

**Exemption — `OnboardingBloc`:** its state accumulates user input across the whole multi-screen onboarding flow, so it is a single `initial` factory with status enums (`OnboardingStatus`, `OnboardingSkipStatus`) and `isLoading*` flags. Separate `loading` / `failure` variants would drop or duplicate the collected flow data on every transition.

---

## 2. Event — @freezed Union

File: `<feature>_event.dart`

Rules:
- `@freezed sealed class XxxEvent with _$XxxEvent` (freezed 3.x requires `sealed` for event unions; not `abstract class`)
- `part '<feature>_event.freezed.dart'` directive required
- Concrete event class names in action noun or past tense: `Started`, `AddRequested`, `Reset`
- Required fields use `required`; optional fields are nullable

---

## 3. BLoC Constructor Pattern

Rules:
- `@injectable class XxxBloc extends Bloc<XxxEvent, XxxState>` — never `@lazySingleton`
- All dependencies are **positional** constructor parameters — no named/optional params
- `final _logger = BizzieLogger('XxxBloc')` at **file level** (not in the class)
- Register all event handlers in the constructor with `on<EventType>(handler)`
- Initial state is always `super(const XxxState.initial())`
- **BLoCs never depend on other BLoCs.** A BLoC must not inject, hold, listen to (`otherBloc.stream`), read the state of, or dispatch events into another BLoC. Coupling BLoCs forces shared singleton lifecycles and hides cross-feature data flow. Instead:
  - Share cross-feature data through the domain layer — inject a use case that exposes the data or stream (e.g. `GetAuthStreamUseCase`, `GetCurrentUserUseCase`), never the BLoC that also consumes it
  - Forward cross-BLoC events in the presentation layer — at the widget dispatch site, in a `BlocListener<OtherBloc, OtherState>` that adds an event to this BLoC, or in a static presentation util (`XxxHelper` / `XxxReporter`) that calls `context.read<...>()` for each BLoC
  - Seed a BLoC with another BLoC's state by passing it in the triggering event (`getIt<XxxBloc>()..add(XxxEvent.started(value: context.read<OtherBloc>().state...))`), not through the constructor
  - Non-BLoC coordinators (orchestrators, services) read BLoCs from the `BuildContext` they are called with — never inject a BLoC via DI

Concurrency transformers (from `bloc_concurrency`):
- `transformer: restartable()` — data-loading events (cancels in-flight work)
- `transformer: droppable()` — single-fire events (ignores while processing)
- `transformer: sequential()` — ordered queue
- Default (no transformer) — concurrent

---

## 4. Event Handlers

Handler signature: `Future<void> _onXxx(XxxEvent event, Emitter<XxxState> emit) async`

Rules:
- Fold `Either<Failure, T>` results: `result.fold((failure) => emit(XxxState.failure(failure)), (data) => emit(XxxState.loaded(data)))`
- Emit `XxxState.loading()` before async calls where a loading indicator is needed
- For Firestore streams use `emit.forEach<Either<Failure, T>>(stream, onData: ...)` — never `await for`
- Log analytics via the injected tracker inside the handler — never in the widget
- **Single responsibility — keep handlers thin (~30 lines max).** A handler orchestrates exactly: guard/short-circuit → emit loading → invoke use case → fold and emit. Every other concern (analytics metrics construction, data-to-view-model mapping, staleness/guard evaluation) must be extracted into named private helpers or a shared mixin — never inlined in the handler body
- **No duplicated blocks between fold branches.** If the failure and success branches build the same structure (e.g. analytics metrics differing only in a flag), extract one helper parameterised by the difference
- **No no-op event handlers (YAGNI).** If an event's handler body would be empty, the event must not exist — remove the entire pipeline together: the `const factory` event variant, the `on<>` registration, the handler method, and **every dispatch site** (`add(...)` calls in widgets, orchestrators, and presentation utils). Never keep an empty handler as documentation (explain at the dispatch site instead) or register an event "for future use". Never delete only the handler/registration while dispatch sites remain — `Bloc.add` throws a `StateError` at runtime for events with no registered handler

---

## 5. Stream Subscriptions

For `emit.forEach` / `emit.onEach` (preferred — used for streams driven by a BLoC event):
```
await emit.forEach(_useCase(uid), onData: (result) => result.fold(...), onError: ...)
```

For cross-feature subscriptions started in the constructor (e.g. auth state changes):
- Declare `StreamSubscription? _subscription` as a field
- Start the subscription in the constructor body
- Override `close()` to cancel: `_subscription?.cancel(); return super.close();`

For multiple simultaneous streams, use `await Future.wait([emit.onEach(...), emit.onEach(...)])`.

---

## 6. Reset Pattern

Every BLoC must handle a `Reset` event that emits `const XxxState.initial()`. Called on logout.

**Exemption — `AuthBloc`:** its lifecycle is driven by the auth stream, which emits `unauthenticated` on logout. Emitting `initial()` would leave `AppRouterRedirect` treating the session as loading with no further stream emission, so `AuthBloc` has no `Reset` event.

---

## 7. Providing BLoCs

Feature BLoCs are provided at the page level:
```
BlocProvider(create: (context) => getIt<XxxBloc>()..add(const XxxEvent.started()), child: ...)
```
Global BLoCs (auth, app config) are in `MultiBlocProvider` at app root. Never pass a BLoC through widget constructors — use `context.read<XxxBloc>()`.

**Exemption — `OnboardingBloc`:** provided in the app-root `MultiBlocProvider` without an initial `started` event. The flow spans root-navigator routes outside the onboarding shell (paywalls, gift modal), is reset on logout from `BizzieAppView`, and starts its session lazily on the first `stepViewed`. Scoping it to the onboarding routes would make it unreachable from the paywalls and would fire its abandoned-session summary in `close()` on every exit from the flow.

---

## 8. Consuming State in Widgets

| API | Use when |
|---|---|
| `context.read<XxxBloc>()` | Dispatching events in callbacks — no rebuild |
| `BlocBuilder<XxxBloc, XxxState>` | Rebuild on state change; use `buildWhen` to filter |
| `BlocListener<XxxBloc, XxxState>` | Side effects only (navigation, snackbars) |
| `BlocConsumer<XxxBloc, XxxState>` | Rebuild + side effect in same widget |
| `context.select<XxxBloc, T>()` | Rebuild only when a derived value changes |

Use freezed's `state.map(...)` / `state.maybeMap(...)` / `state.mapOrNull(...)` for pattern matching in `builder` callbacks.

---

## 9. Rules Summary

```
BLoC        -- NO BuildContext, NO navigation, NO flutter/widgets imports
Events      -- @freezed class, part directive, factory constructors
States      -- @freezed abstract class, part directive, factory constructors
Deps        -- positional constructor params; DI resolves via @injectable
Coupling    -- NO BLoC-to-BLoC deps; share via use cases, forward events in presentation
Concurrency -- restartable() for data-loading; droppable() for single-fire
Streams     -- emit.forEach / emit.onEach; cancel StreamSubscriptions in close()
Analytics   -- via injected XxxTracker inside event handlers only
build_runner -- run after any @freezed addition or change
```

---

## Checklist
- [ ] State: `@freezed abstract class` with `const factory` variants and `part` directive (`OnboardingBloc` single-variant state exempt — see §1)
- [ ] Event: `@freezed sealed class` with `const factory` variants and `part` directive
- [ ] BLoC: `@injectable`, positional constructor params, `on<>` registrations
- [ ] No BLoC injects, listens to, reads, or dispatches into another BLoC — cross-feature data via use cases, cross-BLoC events forwarded in the presentation layer (see §3)
- [ ] `_logger = BizzieLogger('XxxBloc')` defined at **file level**
- [ ] `Either<Failure, T>` results folded in event handlers
- [ ] Event handlers ≤ ~30 lines, single responsibility — cross-cutting work (analytics metrics, mapping, guards) extracted to private helpers, no duplicated blocks between fold branches
- [ ] No no-op event handlers — an event with an empty handler is removed end-to-end (variant + registration + handler + all dispatch sites), never partially
- [ ] `restartable()` used for data-loading event handlers
- [ ] `emit.forEach` / `emit.onEach` used for stream-backed handlers (not `await for`)
- [ ] `StreamSubscription` cancelled in `close()` where applicable
- [ ] `Reset` event emits `const XxxState.initial()` (`AuthBloc` exempt — see §6)
- [ ] `BlocProvider` wired at page level with `getIt<XxxBloc>()..add(...)` (`OnboardingBloc` exempt — see §7)
- [ ] No Flutter UI imports in BLoC files
- [ ] `build_runner` run after any `@freezed` addition or change
