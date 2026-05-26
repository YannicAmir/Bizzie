---
name: code hygiene enforcer instructions
description: Cross-cutting checks for CodeHygieneEnforcer. Violation categories to look for when measuring code against architecture.guidance, dart.best.practice, flutter.best.practice, flutter.bloc.best.practice, routing, software.dev.best.practice, tech.stack, and theme.styling.guidance instruction sets. References qa.enforcement.pattern.instructions.md for retry loop rules.
---

# Code Hygiene Enforcer Instructions

## Guidance Sources
Verify all changed files against every checklist item in each of the following:
- `architecture.guidance.instructions.md`
- `dart.best.practice.instructions.md`
- `flutter.best.practice.instructions.md`
- `flutter.bloc.best.practice.instructions.md`
- `refactor.guidance.instructions.md`
- `routing.instructions.md`
- `software.dev.best.practice.instructions.md`
- `tech.stack.instructions.md`
- `theme.styling.guidance.instructions.md`

---

## Key Violation Categories

### Architecture violations
- Domain layer importing from data layer (datasources, DTOs, repositories) or presentation layer
- Presentation layer calling a repository or datasource directly instead of through a use case
- BLoC calling a repository or datasource directly instead of through a use case
- Manual GetIt registration in `bootstrap.dart` or `GetIt.I<T>()` called from feature code
- Code placed in the wrong directory (e.g. UI logic in domain, domain model in data layer)
- Feature code importing from another feature's internal files
- `BizzieLogger` not used — raw `print()` or `debugPrint()` used instead
- Business logic or data transformation inside widget `build()` methods

### Dart best practice violations
- `!` null assertion operator used without proof of non-null at call site
- `late` used as a workaround for nullable design (not guaranteed before first access)
- Mutable `var` used where `final` is sufficient
- Non-`const` value where a compile-time `const` is possible
- Unawaited `Future` without explicit `unawaited()` from `dart:async`
- `async` on a function that contains no `await`
- Positional boolean parameters — use named parameters instead
- Magic numbers or magic strings not assigned to named `const` values
- Dead code: unused variables, unused imports, unused parameters, unreachable code
- Commented-out code left in the file
- `dynamic` used without justification
- `StringBuffer` not used for string concatenation in a loop (`+=` on `String` in a loop)
- Raw strings or integers used instead of an enum for a fixed set of values
- Non-descriptive or single-letter variable/function names (outside loop indices)
- `catch (e)` without a specific typed exception (unless rethrowing)
- Empty or silent catch blocks that swallow exceptions

### Flutter best practice violations
- Function returning a widget instead of an extracted widget class
- Widget constructor missing `const` when all parameters are compile-time constants
- Widget `build()` subtree more than ~4 levels deep without extraction into a named widget class
- `build()` performing I/O, async calls, or heavy computation
- `setState()` triggered inside `build()`
- Controllers, streams, or listeners instantiated inside `build()` (not in `initState`)
- `ListView(children: [...])` used for dynamic or large lists (must use `ListView.builder`)
- `AnimationController`, `TextEditingController`, `ScrollController`, `StreamSubscription`, or `FocusNode` not disposed in `dispose()`
- Business logic, API calls, or data transformation placed directly inside a widget class
- `StatefulWidget` used where no mutable local state is needed

### BLoC best practice violations
- BLoC annotated with `@lazySingleton` instead of `@injectable`
- BLoC constructor uses named or optional parameters instead of positional parameters
- `_logger = BizzieLogger('XxxBloc')` declared inside the class instead of at file level
- Event handlers not registered with `on<EventType>(handler)` in the constructor
- `Either<Failure, T>` result not folded in event handlers
- `await for` used for stream-backed handlers instead of `emit.forEach` / `emit.onEach`
- `StreamSubscription` not cancelled in `close()` override
- Missing `Reset` event that emits `const XxxState.initial()`
- BLoC importing `flutter/widgets.dart` or performing navigation directly
- BLoC provided via constructor passing through widget tree instead of `context.read<XxxBloc>()`
- Analytics logged directly in a widget instead of via the injected tracker in an event handler
- State class not using `@freezed abstract class` with `const factory` variants and `part` directive
- Event class not using `@freezed class` (non-abstract) with `const factory` variants and `part` directive
- `restartable()` transformer missing from data-loading event handlers
- Initial state not `super(const XxxState.initial())`

### Routing violations
- Route path string hardcoded inline instead of using an `AppRoutes` constant
- New route path constant not added to `lib/app/routes/app_routes.dart`
- Navigation (`context.go`, `context.push`) called inside a BLoC
- Redirect logic written inline in `createRouter()` instead of in `AppRouterRedirect`
- Modal bottom sheet above the tab bar missing `parentNavigatorKey: rootNavigatorKey`
- `extra` used for data that must survive deep-links (use query or path parameters instead)
- Wrong page type used (e.g. plain `builder:` for a modal that should use `ModalBottomSheetPage`)

### Software development best practice violations
- Duplicated logic — the same computation appears in two or more places (DRY violation)
- Class or function with more than one clear reason to change (Single Responsibility violation)
- Boolean flag parameter that alters control flow (split into two named functions)
- Function longer than ~30 lines that can meaningfully be decomposed
- Magic numbers or magic strings not replaced by named constants
- Commented-out code or dead code present
- Exception silently swallowed with an empty or log-only catch and no recovery
- Speculative abstraction added for a requirement that does not yet exist (YAGNI violation)
- Names that do not communicate intent (abbreviations, acronyms, misleading verbs)

### Tech stack violations
- Package imported that is not on the approved list in `tech.stack.instructions.md`
- `firebase_analytics` or `FirebaseAnalytics` accessed directly instead of through `IAnalyticsService`
- `GetIt.I<T>()` called from feature code (outside DI bootstrap)
- `SharedPreferences` or `FirebaseFirestore.instance` accessed directly instead of through the registered service
- `GoogleFonts` used inline instead of referencing `AppTextStyles`
- `print()` or `debugPrint()` used instead of `BizzieLogger`

### Theme and styling violations
- Raw hex color value (`Color(0xff...)`, `Color.fromRGBO(...)`) written inline in a widget
- `Colors.white`, `Colors.black`, or any `Colors.*` constant used inline (exception: `Colors.transparent`)
- `TextStyle(...)` constructed from scratch inline instead of using `AppTextStyles.xxx`
- Magic number font size or font weight value written inline
- Spacing value (padding, margin, `SizedBox` height/width) written as a raw number instead of an `AppConstants` named constant
- Component theme (e.g. `BottomNavigationBar`, `Dialog`) re-declared locally when `AppTheme.lightTheme` already covers it
- `darkTheme` introduced as a side-effect of feature work

---

## Enforcement Loop
Follow the retry loop rules in `qa.enforcement.pattern.instructions.md`.

---

## Checklist
- [ ] All changed files read before checking
- [ ] Every item in each of the nine guidance sources verified
- [ ] Violations reported with file, rule, location, and detail
- [ ] Retry loop applied per `qa.enforcement.pattern.instructions.md`
