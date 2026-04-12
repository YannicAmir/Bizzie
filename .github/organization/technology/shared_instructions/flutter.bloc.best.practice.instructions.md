---
name: flutter bloc best practice
description: Project-specific BLoC coding guidelines. Covers BLoC with freezed events/states, injectable constructor pattern, event handlers, concurrency transformers, stream subscriptions, providing blocs, and consuming state in widgets. Referenced by all state management agents.
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

---

## 2. Event — @freezed Union

File: `<feature>_event.dart`

Rules:
- `@freezed class XxxEvent with _$XxxEvent` (not `abstract class`)
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

---

## 7. Providing BLoCs

Feature BLoCs are provided at the page level:
```
BlocProvider(create: (context) => getIt<XxxBloc>()..add(const XxxEvent.started()), child: ...)
```
Global BLoCs (auth, app config) are in `MultiBlocProvider` at app root. Never pass a BLoC through widget constructors — use `context.read<XxxBloc>()`.

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
Concurrency -- restartable() for data-loading; droppable() for single-fire
Streams     -- emit.forEach / emit.onEach; cancel StreamSubscriptions in close()
Analytics   -- via injected XxxTracker inside event handlers only
build_runner -- run after any @freezed addition or change
```

---

## Checklist
- [ ] State: `@freezed abstract class` with `const factory` variants and `part` directive
- [ ] Event: `@freezed class` with `const factory` variants and `part` directive
- [ ] BLoC: `@injectable`, positional constructor params, `on<>` registrations
- [ ] `_logger = BizzieLogger('XxxBloc')` defined at **file level**
- [ ] `Either<Failure, T>` results folded in event handlers
- [ ] `restartable()` used for data-loading event handlers
- [ ] `emit.forEach` / `emit.onEach` used for stream-backed handlers (not `await for`)
- [ ] `StreamSubscription` cancelled in `close()` where applicable
- [ ] `Reset` event emits `const XxxState.initial()`
- [ ] `BlocProvider` wired at page level with `getIt<XxxBloc>()..add(...)`
- [ ] No Flutter UI imports in BLoC files
- [ ] `build_runner` run after any `@freezed` addition or change
