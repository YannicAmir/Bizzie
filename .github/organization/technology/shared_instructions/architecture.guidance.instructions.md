---
name: architecture guidance
description: Flutter app architecture reference for all technology agents. File/folder placement and layer boundaries are strictly enforced. No deviations without explicit user approval.
---

# Architecture Guidance

---

## Project Structure

```
<app>/
├── lib/
│   ├── main_dev.dart                  # Entry points — one per environment
│   ├── main_qa.dart
│   ├── main_prod.dart
│   ├── bootstrap.dart                 # App bootstrap: DI registration, Firebase init
│   ├── constants.dart                 # App-wide constants
│   ├── app_info.dart                  # Build/version metadata
│   ├── <app>_app.dart                 # MaterialApp root, ThemeData, router wiring
│   ├── <app>_app_delegate.dart        # Native app delegate callbacks
│   │
│   ├── theme/                         # Styling primitives
│   │   ├── theme.dart                 # Font family, spacing constants — barrel export
│   │   ├── <app>_colors.dart          # Centralized color constants (AppColors)
│   │   └── <app>_icon_paths.dart      # Centralized icon asset path constants
│   │
│   ├── router/                        # Navigation
│   │   ├── router.dart                # GoRouter definition, route tree
│   │   ├── routes.dart                # Route path string constants
│   │   ├── modal_bottom_sheet_page.dart
│   │   ├── fade_transition_page.dart
│   │   └── helpers.dart
│   │
│   ├── cubit/                         # App-level (global) state only
│   │   ├── app_cubit.dart
│   │   ├── app_state.dart
│   │   ├── user_cubit.dart
│   │   ├── user_state.dart
│   │   ├── app_status_cubit.dart
│   │   └── app_status_state.dart
│   │
│   ├── repositories/                  # Data access — one folder per domain
│   │   ├── repositories.dart          # Barrel export
│   │   ├── user/
│   │   ├── analytics/
│   │   ├── config/
│   │   ├── products/
│   │   ├── search/
│   │   ├── stores/
│   │   ├── categories/
│   │   ├── treasure/
│   │   ├── gift_cards/
│   │   ├── lovelist/
│   │   ├── feedback/
│   │   ├── messaging/
│   │   ├── permissions/
│   │   ├── region/
│   │   ├── deeplink/
│   │   ├── environment/
│   │   └── app_status/
│   │
│   ├── features/                      # One folder per product feature
│   │   ├── <feature>/
│   │   │   ├── pages/                 # Routable full-screen pages
│   │   │   ├── widgets/               # Non-routable, feature-scoped widgets
│   │   │   ├── cubit/
│   │   │   │   ├── <feature>_cubit.dart
│   │   │   │   └── <feature>_state.dart
│   │   │   ├── models/                # Feature-scoped models (if needed)
│   │   │   ├── helpers/               # Feature-scoped utilities (if needed)
│   │   │   ├── l10n.dart              # Feature-scoped localization extension
│   │   │   └── <feature>.dart         # Barrel export
│   │   │
│   │   ├── auth/
│   │   ├── home/
│   │   ├── shop/
│   │   ├── shopping_bag/
│   │   ├── search/
│   │   ├── stores/
│   │   ├── treasure/
│   │   ├── more/
│   │   ├── checkout/
│   │   ├── giftcards/
│   │   ├── feedback/
│   │   ├── delete_account/
│   │   ├── country_switcher/
│   │   └── debug/
│   │
│   ├── widgets/                       # Shared, app-wide reusable widgets only
│   │   ├── widgets.dart               # Barrel export
│   │   └── ...
│   │
│   ├── models/                        # Shared, cross-feature data models
│   ├── l10n/
│   ├── accessibility_l10n/
│   ├── enums/
│   ├── extensions/
│   ├── helpers/
│   ├── mixins/
│   └── firebase/
│
├── packages/                          # Internal packages (self-contained)
│   ├── <app>_mobile_eu_api/
│   ├── local_db/
│   ├── tjx_logging/
│   ├── tjx_onetrust/
│   ├── google_api_service/
│   ├── accessify/
│   ├── bmp_flutter_sdk/
│   └── appdynamics/
│
├── assets/
│   ├── fonts/
│   ├── icons/
│   └── images/
│
├── test/                              # Mirrors lib/ structure exactly
│   ├── features/
│   ├── cubit/
│   ├── repositories/
│   ├── widgets/
│   ├── models/
│   ├── router/
│   └── helpers/
│
└── pubspec.yaml
```

---

## Layered Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                          ENTRY POINTS                                │
│              main_dev  /  main_qa  /  main_prod                      │
│                         bootstrap.dart                               │
└───────────────────────────────┬──────────────────────────────────────┘
                                │
┌───────────────────────────────▼──────────────────────────────────────┐
│                          APP SHELL                                   │
│          <app>_app.dart — MaterialApp, ThemeData, GoRouter           │
│          cubit/  — global state (user session, region, flags)        │
└──────────┬─────────────────────────────────────────┬─────────────────┘
           │                                         │
┌──────────▼───────────────┐         ┌───────────────▼────────────────┐
│      PRESENTATION        │         │           ROUTING              │
│                          │         │                                │
│  features/               │         │  router/router.dart            │
│  ├── pages/   ◄──────────┼─────────┤  router/routes.dart            │
│  └── widgets/            │         │                                │
│                          │         └────────────────────────────────┘
│  widgets/  (shared)      │
└──────────┬───────────────┘
           │  reads state / calls methods
┌──────────▼───────────────┐
│    STATE MANAGEMENT      │
│                          │
│  features/*/cubit/       │  ← feature-scoped Cubits
│  cubit/                  │  ← app-scoped Cubits
└──────────┬───────────────┘
           │  calls methods on
┌──────────▼──────────────────────────────────────────────────────────┐
│                      REPOSITORY LAYER                               │
│                                                                     │
│  lib/repositories/                                                  │
│  ├── Owns domain business logic                                     │
│  ├── Maps ApiResult<T>  →  domain types / error tuples              │
│  ├── Owns logging and error handling                                │
│  └── Injects API classes and local DB via constructor / GetIt       │
└──────────┬────────────────────────────────┬─────────────────────────┘
           │  calls methods on              │  calls methods on
┌──────────▼───────────────┐  ┌─────────────▼──────────────────────────┐
│   API PACKAGE            │  │   LOCAL DB / PLATFORM SDKs             │
│                          │  │                                        │
│  packages/               │  │  packages/local_db/  (Realm)           │
│  <app>_mobile_eu_api/    │  │  Firebase, Airship, OneTrust, etc.     │
│  ├── */apis/             │  │                                        │
│  │   └── <domain>_api    │  │  ← No business logic here              │
│  │       Raw HTTP calls  │  │  ← Treat as infrastructure adapters    │
│  │       Returns         │  │                                        │
│  │       ApiResult<T>    │  └────────────────────────────────────────┘
│  ├── models/             │
│  │   JSON ↔ Dart types   │
│  └── TKMaxxApiClient     │
│      HTTP transport      │
└──────────────────────────┘

         packages/   ← isolated, independently testable, no app imports
         ┌──────────────────────────────────────────────┐
         │  <app>_mobile_eu_api  │  local_db            │
         │  tjx_logging          │  tjx_onetrust        │
         │  google_api_service   │  bmp_flutter_sdk     │
         │  appdynamics          │  accessify           │
         └──────────────────────────────────────────────┘
```

---

## Layer Constraints — Never Violate

```
pages / widgets    ────►  NO repository or API access
cubit              ────►  NO API package access (only repositories)
repositories       ────►  NO UI imports, NO cubit imports
API package        ────►  NO business logic, only transport + JSON
local_db / SDKs    ────►  NO business logic, only storage / platform calls
packages           ────►  NO cross-package dependencies
```

