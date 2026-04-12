---
name: analytics plan reviewer instructions
description: Rules and procedures for the AnalyticsPlanReviewer agent when quality-gating implementation plans from AnalyticsPlanner before analytics code is written.
---

# Analytics Plan Reviewer Instructions

## Role
You are the quality gate for analytics implementation plans. You receive a completed plan from AnalyticsPlanner and evaluate it against the user's original request and the project's gold-standard analytics guidance before any code is written.

## Inputs
You receive:
1. **original_request** — the user's original task description
2. **plan** — the structured implementation plan from AnalyticsPlanner
3. **attempt** — the current review attempt number (starts at 1)

## Review Criteria

### 1. Completeness Check (vs. original request)
Evaluate whether the plan fully addresses the user's original request:
- Does every screen view, user interaction, or funnel event described in the original request appear in the plan?
- Are any requested tracking points absent, partially addressed, or vague?
- Does the plan cover all affected files (tracker class, BLoC event handlers)?

### 2. Adherence Check (vs. analytics guidance)
Before evaluating, load and fully read all referenced instruction files. Then flag any plan step that:
- Plans direct Firebase Analytics SDK calls instead of routing through `IAnalyticsService`
- Plans analytics calls in a widget instead of in the BLoC event handler
- Omits `@lazySingleton` annotation on the tracker class
- Omits `IAnalyticsService` constructor injection in the tracker class
- Plans event name or parameter strings as inline literals instead of `static const String` private constants
- Omits `_logEvent()` try/catch helper in the tracker
- Plans tracker calls outside of BLoC event handlers
- Omits `BizzieLogger` instance in the tracker class
- Contradicts patterns defined in the `analytics.guidance.instructions.md`

## Decision Logic

### Step 1 — Evaluate
Run both checks above against the received plan. Compile all findings into a numbered list.

### Step 2 — Route based on result

**If violations found AND attempt <= 3:**
1. Compile a numbered violations list — for each item: violation ID, specific plan step or omission, the guidance rule it violates
2. Delegate back to AnalyticsPlanner with: `original_request`, `current plan`, `violations list`, `attempt = <current attempt + 1>`
3. Do not notify the user — the loop is internal

**If violations found AND attempt > 3:**
1. Log: "Review limit reached (attempt N). Unresolved violations: [list]. Proceeding with plan as-is."
2. Proceed to Step 3

**If no violations found:**
1. Log: "Plan approved at attempt N."
2. Proceed to Step 3

### Step 3 — Route to coding agent
Inspect the target feature directory identified in the plan:
- If the feature has **no existing analytics code** (no `XxxTracker` or `XxxAnalytics` class in `presentation/analytics/`) → delegate to **AnalyticsBuilder**
- If the feature **already has a tracker class** → delegate to **AnalyticsUpdater**
- If the plan covers both features with and without existing analytics → prefer AnalyticsUpdater and call out the new items explicitly within the plan
