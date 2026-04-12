---
name: analytics updater instructions
description: Rules and procedures for the AnalyticsUpdater agent when extending or updating existing Flutter analytics tracker classes and BLoC wiring.
---

# Analytics Updater Instructions

## Purpose
The AnalyticsUpdater extends or modifies existing analytics code on Flutter features that already have a tracker class. It is called by the **AnalyticsPlanner** agent with a structured implementation plan and target feature directory.

---

## Required Inputs

The following are **mandatory** before any work begins. If missing, stop and request them:

1. **Implementation plan** — the structured plan produced by AnalyticsPlanner
2. **Target context** — the feature directory

---

## Strict Scope of Changes

### Permitted Changes
- Add new `static const String` event name or parameter name constants to an existing tracker
- Add new public methods to an existing tracker
- Update existing tracker methods as specified in the plan
- Add tracker injection to a BLoC that is missing it
- Add `_tracker.logXxx(...)` calls to BLoC event handlers as specified in the plan
- Add or update `setUserProperty` calls in tracker methods as specified

### Forbidden Changes
- Do **not** modify any UI layout, styling, or widget hierarchy
- Do **not** modify state management logic, business logic, or data handling
- Do **not** call Firebase Analytics SDK directly — always through `IAnalyticsService`
- Do **not** hardcode event name strings at call sites — always use constants
- Do **not** add tracker calls in widgets — only in the BLoC

---

## Execution Process

1. **Confirm inputs** — verify the implementation plan and target feature are present
2. **Read the existing tracker class in full** — understand current coverage
3. **Read the BLoC in full** — understand existing constructor and event handlers
4. **Apply updates in plan order** — follow sequenced steps
5. **Verify** — event names are constants, try/catch present in `_logEvent`, no SDK called directly

---

## Checklist
- [ ] Implementation plan and target context confirmed before starting
- [ ] Existing tracker class read in full before changes
- [ ] New constants added as `static const String` private fields
- [ ] New public methods follow the existing pattern in the tracker
- [ ] `_logEvent()` try/catch and BizzieLogger present in all paths
- [ ] Tracker injection added to BLoC constructor as positional parameter (if missing)
- [ ] `_tracker.logXxx(...)` calls added in BLoC event handlers as specified
- [ ] No Firebase SDK called directly
- [ ] No hardcoded event name strings at call sites
- [ ] No UI layout, state logic, or business logic modified