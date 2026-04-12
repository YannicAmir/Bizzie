---
name: analytics guidance
description: Project-specific analytics coding guidelines for Flutter. Covers the feature-scoped XxxTracker/XxxAnalytics pattern, IAnalyticsService, event/parameter constants, BLoC injection, and user properties. Referenced by all analytics agents performing Flutter tasks.
---

# Analytics Guidance

> Every feature has its own analytics class in `presentation/analytics/`. Analytics always flows through `IAnalyticsService` — never call Firebase Analytics SDK directly from a BLoC or widget.

---

## 1. Architecture

Each feature owns a dedicated analytics tracker class in `presentation/analytics/`:

```
BLoC / Widget
     │
     ▼
XxxTracker (or XxxAnalytics)     ← @lazySingleton, injected into BLoC
     │
     ▼
IAnalyticsService                ← core interface (firebase_analytics wrapper)
```

The class is named after the feature it tracks:
- `ReportsTracker` — tracks the reports feed
- `WatchlistAnalytics` — tracks watchlist interactions
- `SettingsTracker` — tracks settings interactions

---

## 2. Tracker Class Structure

```dart
// lib/features/<feature>/presentation/analytics/<feature>_tracker.dart

import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class XxxTracker {
  final IAnalyticsService _analytics;

  XxxTracker(this._analytics);

  // Screen name constant
  static const String _screenName = 'xxx_screen';

  // Event name constants (private, snake_case)
  static const String _kEventXxxHappened = 'xxx_happened';
  static const String _kEventXxxFailed = 'xxx_failed';

  // Parameter name constants (private, snake_case)
  static const String _kParamTicker = 'ticker';
  static const String _kParamErrorMessage = 'error_message';

  // Private _logEvent helper — merges screen_name automatically
  Future<void> _logEvent(String name, [Map<String, Object>? parameters]) async {
    await _analytics.logEvent(
      name: name,
      parameters: {
        ...?parameters,
        'screen_name': _screenName,
      },
    );
  }

  // Public methods — one per tracked event
  Future<void> logXxxHappened({required String ticker}) async {
    await _logEvent(_kEventXxxHappened, {_kParamTicker: ticker});
  }

  Future<void> logXxxFailed({required String errorMessage}) async {
    await _logEvent(_kEventXxxFailed, {_kParamErrorMessage: errorMessage});
  }
}
```

---

## 3. Event Naming Conventions

- Event names: `snake_case`, descriptive, specific — e.g. `watchlist_item_added`, `filing_link_opened`, `reports_feed_viewed`
- Parameter names: `snake_case` — e.g. `ticker`, `filing_type`, `unread_count`, `entry_source`
- Screen name: `snake_case` — e.g. `reports_feed`, `company_profile`, `settings`
- All names are `static const String` private constants — never hardcode at the call site

---

## 4. Injecting the Tracker into BLoC

The tracker is an `@injectable` constructor dependency of the BLoC. Injectable resolves it automatically:

```dart
@injectable
class XxxBloc extends Bloc<XxxEvent, XxxState> {
  final XxxTracker _tracker;
  // ... other deps

  XxxBloc(this._tracker, /* other deps */) : super(const XxxState.initial()) {
    on<XxxEventHappened>(_onXxxHappened);
  }

  Future<void> _onXxxHappened(
    XxxEventHappened event,
    Emitter<XxxState> emit,
  ) async {
    _tracker.logXxxHappened(ticker: event.ticker);
    // ...
  }
}
```

The tracker is **never** injected directly into widgets — only into BLoCs. Widgets dispatch events to the BLoC, which delegates analytics calls to the tracker.

---

## 5. User Properties

User properties are set via `setUserProperty()` on the tracker class — not from global BLoCs or widgets:

```dart
Future<void> setWatchlistItemCount(int count) async {
  await _analytics.setUserProperty(
    name: 'watchlist_item_count',
    value: count.toString(),
  );
}
```

Call `setUserProperty` from within the relevant tracker method or from the BLoC event handler via the tracker.

---

## 6. Screen View Tracking

Screen views are tracked as regular events in the BLoC (typically on a `Started` or `Viewed` event):

```dart
Future<void> logFeedViewed({
  required int unreadCount,
  required String entrySource,
}) async {
  await _logEvent('reports_feed_viewed', {
    'unread_count': unreadCount,
    'entry_source': entrySource,
  });
}
```

There is no `ScreenViewMixin` — screen view tracking is always an explicit method on the tracker, called by the BLoC.

---

## 7. Timestamp and Metadata

Include `timestamp` as an ISO 8601 string in events that require time attribution:

```dart
Future<void> _logEvent(String name, [Map<String, dynamic>? parameters]) async {
  try {
    await _analytics.logEvent(
      name: name,
      parameters: {
        ...?parameters,
        _kParamScreenName: _kScreenName,
        _kParamTimestamp: DateTime.now().toIso8601String(),
      },
    );
  } catch (e, stack) {
    _logger.severe('Failed to log event: $name', e, stack);
  }
}
```

Wrap `_logEvent` in try/catch and log failures with `BizzieLogger` — analytics failures must never crash the app.

---

## 8. Rules

| Rule | Detail |
|---|---|
| IAnalyticsService | NEVER called directly from a BLoC, widget, or use case — always through a tracker class |
| Tracker class | One per feature, `@lazySingleton`, located in `presentation/analytics/` |
| Event names | `static const String` private constants — never hardcoded at the call site |
| Parameter names | `static const String` private constants — never hardcoded at the call site |
| Screen view tracking | An explicit method on the tracker, called by the BLoC — no mixin |
| User properties | Set via `_analytics.setUserProperty()` inside tracker methods |
| Error handling | Always wrap `_analytics.logEvent()` in try/catch; log with `BizzieLogger` |
| Widget analytics | Widgets dispatch events to the BLoC — they never call the tracker directly |

---

## 9. File Placement

```
lib/features/<feature>/
└── presentation/
    └── analytics/
        └── <feature>_tracker.dart   # or <feature>_analytics.dart
```

---

## Checklist
- [ ] Tracker class created in `presentation/analytics/<feature>_tracker.dart`
- [ ] Class annotated `@lazySingleton`
- [ ] Receives `IAnalyticsService` via constructor injection
- [ ] All event names defined as `static const String` private constants
- [ ] All parameter names defined as `static const String` private constants
- [ ] Private `_logEvent()` helper merges `screen_name` automatically
- [ ] `_logEvent()` wrapped in try/catch, failures logged with BizzieLogger
- [ ] One public method per tracked event with named parameters
- [ ] Tracker injected into BLoC via constructor (injectable resolves it)
- [ ] Widgets never call tracker directly — always via BLoC events
- [ ] `setUserProperty()` called inside tracker methods (not from widgets or global state)
