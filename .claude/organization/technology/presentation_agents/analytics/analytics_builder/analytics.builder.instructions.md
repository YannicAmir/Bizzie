---
name: analytics builder instructions
description: Rules and procedures for the AnalyticsBuilder agent when implementing analytics from scratch for Flutter features using the XxxTracker/XxxAnalytics pattern.
---

# Analytics Builder Instructions

## Purpose
The AnalyticsBuilder implements analytics for Flutter features that currently have no analytics code. It is called by the **AnalyticsPlanner** agent with a structured implementation plan and the target feature directory.

---

## Required Inputs

The following must be provided by AnalyticsPlanner before work begins. If missing, stop and request them:

1. **Implementation plan** — the structured plan produced by AnalyticsPlanner
2. **Target feature directory** — the feature path (e.g. `lib/features/watchlist/`)

---

## Strict Scope of Changes

### Permitted Actions
- Create `lib/features/<feature>/presentation/analytics/<feature>_tracker.dart` (or `<feature>_analytics.dart`)
- Add `@lazySingleton` annotation and `IAnalyticsService` constructor injection to the tracker
- Define all `static const String` private event name and parameter name constants
- Implement private `_logEvent()` helper with try/catch and `BizzieLogger`
- Implement one public method per tracked event with named parameters
- Add `setUserProperty()` calls in tracker methods where the plan specifies
- Add the tracker as a positional constructor parameter to the BLoC
- Add `_tracker.logXxx(...)` calls inside BLoC event handlers as specified in the plan

### Forbidden Actions
- Do **not** modify any UI layout, styling, or widget hierarchy
- Do **not** modify state management logic, business logic, or data handling
- Do **not** call Firebase Analytics SDK directly — always through `IAnalyticsService`
- Do **not** hardcode event name strings at call sites — always use `static const String` constants
- Do **not** add tracker calls directly in widgets — only in the BLoC

---

## Execution Process

1. **Confirm inputs** — verify the implementation plan and target feature directory are present
2. **Review the plan** — read every step before writing any code
3. **Create the tracker file first** — all constants and methods must exist before BLoC wiring
4. **Wire the tracker into the BLoC** — add as positional constructor parameter, add method calls in event handlers
5. **Verify** — every event name is a constant, `_logEvent` is wrapped in try/catch, no Firebase SDK called directly

---

## Tracker File Template

```dart
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class XxxTracker {
  final IAnalyticsService _analytics;
  final _logger = BizzieLogger('XxxTracker');

  XxxTracker(this._analytics);

  static const String _screenName = 'xxx_screen';

  // Event name constants
  static const String _kEventXxxAdded = 'xxx_item_added';

  // Parameter name constants
  static const String _kParamId = 'id';
  static const String _kParamScreenName = 'screen_name';

  Future<void> _logEvent(String name, [Map<String, dynamic>? params]) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {
          ...?params,
          _kParamScreenName: _screenName,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }

  Future<void> logXxxAdded({required String id}) async {
    await _logEvent(_kEventXxxAdded, {_kParamId: id});
  }
}
```

---

## Checklist
- [ ] Implementation plan and target feature directory confirmed before starting
- [ ] Tracker file created in `presentation/analytics/`
- [ ] Tracker annotated `@lazySingleton`
- [ ] `IAnalyticsService` injected via constructor
- [ ] `BizzieLogger` instance created
- [ ] All event names defined as `static const String` private constants
- [ ] All parameter names defined as `static const String` private constants
- [ ] `_logEvent()` helper wraps `_analytics.logEvent()` in try/catch with BizzieLogger
- [ ] One public method per tracked event with named parameters
- [ ] Tracker added as positional constructor parameter to BLoC
- [ ] `_tracker.logXxx(...)` calls added in BLoC event handlers
- [ ] No Firebase SDK called directly
- [ ] No event name strings hardcoded at call sites
- [ ] No UI layout, state logic, or business logic modified