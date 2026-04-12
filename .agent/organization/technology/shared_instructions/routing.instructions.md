---
name: routing instructions
description: Flutter routing rules for all technology agents. Governs route registration, navigation patterns, data passing, and page types using go_router with AppRoutes constants and AppRouterRedirect.
---

# Routing Instructions

---

## 1. Setup

- Routing is handled entirely by `go_router` via `createRouter()` in `lib/app/router.dart`.
- Route path strings live exclusively in `lib/app/routes/app_routes.dart` — never inline in the router, widgets, or BLoCs.
- A single `rootNavigatorKey` (`GlobalKey<NavigatorState>`) is exported from `lib/app/router.dart` and used for overlays above the tab bar.
- Top-level redirect logic is encapsulated in `AppRouterRedirect` (`lib/app/routes/app_router_redirect.dart`).

---

## 2. Route Tree Structure

```
GoRouter
├── StatefulShellRoute.indexedStack  (tab bar shell)
│   ├── Branch: /home
│   │   └── nested routes...
│   ├── Branch: /reports
│   │   └── nested routes...
│   └── Branch: /profile
│       └── nested routes...
│
└── Top-level routes (outside shell)
    ├── /splash
    ├── /login
    ├── /create-account
    ├── /landing
    ├── /onboarding/...
    └── /security-lockout
```

Routes outside the tab shell (auth flows, onboarding, overlays) are declared at the top level.

---

## 3. Route Path Constants

Never hardcode path strings. Always use `AppRoutes` constants:

```dart
// Correct
context.go(AppRoutes.home);
context.push(AppRoutes.companyProfile);

// Wrong
context.go('/home');
context.push('/company/:ticker');
```

`AppRoutes` contains only `static const String` constants — no methods or dynamic builders.

---

## 4. Page Types

| Scenario | Use |
|---|---|
| Standard full-screen page | `builder:` |
| Must remount on each visit | `pageBuilder: MaterialPage(key: ValueKey(state.uri))` |
| Modal bottom sheet | `pageBuilder: ModalBottomSheetPage(...)` |
| Full-screen modal (iOS style) | `MaterialPage(fullscreenDialog: true)` |
| No transition | `_buildNoTransitionRoute(path, widget)` helper |

**Modal bottom sheets above the tab bar** require `parentNavigatorKey: rootNavigatorKey`. Sheets scoped inside a tab omit it.

---

## 5. Router-Level Redirects

Redirect logic is computed by `AppRouterRedirect.computeRedirect()`. Pass `authState`, `userState`, and `state` to its constructor. Never write redirect logic inline in `createRouter()`.

---

## 6. Navigation in Widgets

```dart
context.go(AppRoutes.home);               // replace entire stack
context.push(AppRoutes.companyProfile);   // push onto current stack
context.pushReplacement(AppRoutes.next);  // replace current page
context.pop();                            // go back
context.canPop();                         // check before popping
```

**BLoCs never navigate.** State-triggered navigation is handled in the widget layer via `BlocListener`:

```dart
// Correct
BlocListener<MyFeatureBloc, MyFeatureState>(
  listener: (context, state) {
    state.mapOrNull(success: (_) => context.go(AppRoutes.home));
  },
  child: ...,
)
// Wrong — never call context.go / context.push inside a BLoC
```

---

## 7. Passing Data Between Routes

| Method | Survives deep-links? | Use when |
|---|---|---|
| Query parameters | Yes | Default — any routable data |
| Path parameters | Yes | Resource identifiers (tickers, IDs) |
| `extra` | No | In-memory only, non-serialisable objects |

Prefer query or path parameters over `extra` for any deep-linkable route.

---

## 8. Checklist — Adding a New Route

- [ ] Path constant added to `AppRoutes` in `lib/app/routes/app_routes.dart`
- [ ] `GoRoute` registered in `lib/app/router.dart` at correct nesting level
- [ ] `parentNavigatorKey: rootNavigatorKey` added if sheet/overlay must appear above the tab bar
- [ ] `pageBuilder: ModalBottomSheetPage(...)` used for bottom sheets
- [ ] Query/path parameters used (not `extra`) for data that must survive deep-links
- [ ] Navigation via `context.go()` / `context.push()` in widget layer only — never inside a BLoC
