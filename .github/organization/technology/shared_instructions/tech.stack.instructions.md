---
name: tech stack
description: Approved technology stack and package list for all technology agents. No package outside this list may be introduced without explicit approval.
---

# Tech Stack

> **Hard rule:** Do not add, suggest, or use any package not listed here. If a task appears to require an unlisted package, stop and flag it to the user for approval before proceeding.

---

## System Overview

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| Backend | .NET microservices — ECP |
| API Proxy | Apigee |
| IDE | Visual Studio Code |

---

## State Management

| Package | Purpose |
|---|---|
| `flutter_bloc` | BLoC/Cubit state management |
| `equatable` | Value equality for BLoC states/events |
| `nested` | Nested provider utility |

---

## Navigation

| Package | Purpose |
|---|---|
| `go_router` | Declarative routing |

---

## Dependency Injection

| Package | Purpose |
|---|---|
| `get_it` | Service locator / DI |

---

## Networking & Serialization

| Package | Purpose |
|---|---|
| `http` | HTTP client |
| `json_annotation` | JSON serialization annotations |
| `json_serializable` *(dev)* | JSON code generation |
| `build_runner` *(dev)* | Code generation runner |
| `async` | Async utilities |
| `uuid` | UUID generation |

---

## Local Storage

| Package | Purpose |
|---|---|
| `realm` | Local database (Realm) |

---

## Firebase

| Package | Purpose |
|---|---|
| `firebase_core` | Firebase initialization |
| `firebase_remote_config` | Remote configuration |
| `firebase_analytics` | Analytics |

---

## Maps & Location

| Package | Purpose |
|---|---|
| `google_maps_flutter` | Google Maps |
| `geolocator` | Device location |

---

## Device & Platform

| Package | Purpose |
|---|---|
| `device_info_plus` | Device metadata |
| `package_info_plus` | App version/build info |
| `permission_handler` | Runtime permissions |
| `app_settings` | Open device settings |
| `connectivity_plus` | Network connectivity |
| `app_tracking_transparency` | ATT prompt (iOS) |
| `flutter_system_proxy` | System proxy detection |

---

## UI & Media

| Package | Purpose |
|---|---|
| `flutter_svg` | SVG rendering |
| `flutter_markdown` | Markdown rendering |
| `carousel_slider` | Carousel/slider widget |
| `barcode_widget` | Barcode display |
| `mobile_scanner` | Camera barcode/QR scanning |
| `webview_flutter` | WebView |
| `webview_flutter_wkwebview` | WebView — iOS |
| `webview_flutter_android` | WebView — Android |
| `url_launcher` | Open URLs / deep links |
| `share_plus` | Native share sheet |
| `in_app_review` | In-app review prompt |

---

## Localisation & Internationalisation

| Package | Purpose |
|---|---|
| `flutter_localizations` | Localisation delegates |
| `intl` | Date/number formatting, i18n |

---

## Analytics & Monitoring

| Package | Purpose |
|---|---|
| `airship_flutter` | Push notifications / Airship |
| `appdynamics` | Performance monitoring |

---

## Testing *(dev only)*

| Package | Purpose |
|---|---|
| `flutter_test` | Unit & widget testing |
| `mocktail` | Mocking |
| `bloc_test` | BLoC unit testing |
| `mocktail_image_network` | Network image mocking |
| `flutter_driver` | Integration / driver tests |
| `webview_flutter_platform_interface` | WebView test interface |
| `plugin_platform_interface` | Platform interface testing |

---

## Internal Packages (path-based)

| Package | Purpose |
|---|---|
| `tjx_logging` | Centralised logging |
| `local_db` | Local database abstraction |
| `tjx_mobile_eu_api` | EU API client |
| `tjx_onetrust` | OneTrust consent SDK |
| `google_api_service` | Google API wrapper |
| `accessify` | Accessibility utilities |
| `bmp_flutter_sdk` | BMP SDK |
| `tjx_analysis` | *(dev)* Lint / analysis options |

---

## Utility

| Package | Purpose |
|---|---|
| `collection` | Extended collection utilities |
| `clock` | Testable clock abstraction |
