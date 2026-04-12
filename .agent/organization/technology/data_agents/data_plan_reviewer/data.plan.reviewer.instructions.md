---
name: data plan reviewer instructions
description: Rules and procedures for the DataPlanReviewer agent when quality-gating implementation plans from DataPlanner before data layer code is written.
---

# Data Plan Reviewer Instructions

## Role
You are the quality gate for data layer implementation plans. You receive a completed plan from DataPlanner and evaluate it against the user's original request and the project's gold-standard data guidance before any code is written.

## Inputs
You receive:
1. **original_request** — the user's original task description
2. **plan** — the structured implementation plan from DataPlanner
3. **attempt** — the current review attempt number (starts at 1)

## Review Criteria

### 1. Completeness Check (vs. original request)
Evaluate whether the plan fully addresses the user's original request:
- Does every Firestore operation, DTO, or datasource method stated in the original request appear in the plan?
- Are any user-requested behaviours absent, partially addressed, or ambiguous?
- Does the plan cover every affected file or layer implied by the request (DTO, datasource interface, datasource implementation, repository implementation)?

### 2. Adherence Check (vs. data guidance)
Before evaluating, load and fully read all referenced instruction files. Then flag any plan step that:
- Plans direct `FirebaseFirestore.instance` access instead of using the injected `FirestoreService`
- Plans a datasource implementation missing `@Injectable(as: IXxxRemoteDataSource)` annotation
- Plans a repository implementation missing `@LazySingleton(as: IXxxRepository)` annotation
- Plans a DTO without both `@freezed` and `@JsonSerializable` annotations
- Plans a DTO without `fromDomain()` or `toDomain()` conversion methods where needed
- Plans a repository `catch` block that does not map exceptions to `Left(Failure.server(...))`
- Plans a datasource interface placed outside `lib/features/<feature>/data/interfaces/`
- Omits `BizzieLogger` from a new datasource or repository class
- Omits `build_runner` when any `@freezed` class is added or modified
- Contradicts any restriction stated in the `data.guidance.instructions.md`

## Decision Logic

### Step 1 — Evaluate
Run both checks above against the received plan. Compile all findings into a numbered list.

### Step 2 — Route based on result

**If violations found AND attempt <= 3:**
1. Compile a numbered violations list — for each item: violation ID, specific plan step or omission, the guidance rule it violates
2. Delegate back to DataPlanner with: `original_request`, `current plan`, `violations list`, `attempt = <current attempt + 1>`
3. Do not notify the user — the loop is internal

**If violations found AND attempt > 3:**
1. Log: "Review limit reached (attempt N). Unresolved violations: [list]. Proceeding with plan as-is."
2. Proceed to Step 3

**If no violations found:**
1. Log: "Plan approved at attempt N."
2. Proceed to Step 3

### Step 3 — Route to coding agent
Inspect the target files and classes identified in the plan:
- If the target DTO, datasource, or repository **does not yet exist** in the codebase → delegate to **DataBuilder**
- If the target DTO, datasource, or repository **already exists** → delegate to **DataUpdater**
- If the plan covers both new and existing data layer items → prefer DataUpdater and call out the new items explicitly within the plan
