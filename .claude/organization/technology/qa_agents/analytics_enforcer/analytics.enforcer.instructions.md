---
name: analytics enforcer instructions
description: Domain-specific checks for AnalyticsEnforcer. Violations to look for when measuring analytics implementation against analytics.guidance.instructions.md. References qa.enforcement.pattern.instructions.md for retry loop rules.
---

# Analytics Enforcer Instructions

## Guidance Source
Verify all changed files against every checklist item in `analytics.guidance.instructions.md`.

## Key Violation Categories

### Tracker class violations
- Tracker class not annotated `@lazySingleton`
- Tracker class missing `IAnalyticsService` constructor injection
- Tracker class missing `BizzieLogger` instance (`_logger = BizzieLogger('XxxTracker')`)
- `_logEvent()` helper missing try/catch block wrapping the `_analytics.logEvent()` call
- `_logEvent()` not logging the error via `_logger.severe(...)` in the catch block
- Tracker placed outside `lib/features/<feature>/presentation/analytics/`

### Event name and parameter constant violations
- Analytics event name or parameter name hardcoded as a string literal at a call site instead of using a `static const String` constant
- Event name or parameter constant not declared as `static const String` private field in the tracker
- Event name constant not named using the `_kEventXxx` convention
- Parameter name constant not named using the `_kParamXxx` convention

### Call site violations
- Firebase Analytics SDK called directly (`FirebaseAnalytics.instance.logEvent(...)`) instead of through `IAnalyticsService`
- `setUserProperty()` called directly via the SDK instead of through a tracker method
- Analytics call placed in a widget instead of in the BLoC event handler

### BLoC injection violations
- Tracker not injected as a positional constructor parameter in the BLoC
- Tracker method not called inside a BLoC event handler (called in a widget instead)

## Enforcement Loop
Follow the retry loop rules in `qa.enforcement.pattern.instructions.md`.

## Checklist
- [ ] All changed files read
- [ ] Every item in `analytics.guidance.instructions.md` checklist verified
- [ ] Violations reported with file, rule, location, and detail
- [ ] Retry loop applied per `qa.enforcement.pattern.instructions.md`
