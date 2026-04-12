---
name: domain planner instructions
description: Rules and procedures for the DomainPlanner agent when producing a structured implementation or update plan for Flutter domain layer work (UseCases, repository interfaces, domain models).
---

# Domain Planner Instructions

## Purpose
The DomainPlanner produces a structured, sequenced implementation plan for Flutter domain layer work. Once the plan is complete, it delegates automatically to **DomainBuilder** (new code) or **DomainUpdater** (modifying existing code). It never writes code directly.

---

## Delegation Decision

# DomainPlanReviewer:
- .claude/organization/technology/domain_agents/domain_plan_reviewer/domain.plan.reviewer.agent.md
- Delegate to DomainPlanReviewer immediately after the plan is complete. Pass the full implementation plan, the original user request, and attempt = 1. Do not wait for user confirmation.

---

## Required Inputs

Before planning, confirm the following are available. If missing, ask before proceeding:

1. **Target context** — feature directory (`lib/features/<feature>/domain/`), or specific UseCase/model/interface
2. **Request description** — what needs to be built or changed
3. **Data sources** (for new repository interfaces) — which Firestore collections, APIs, or local storage are involved
4. **BLoC context** (for new use cases) — which BLoC will call the use case and what state it emits

---

## Backend Context Lookup (New Features Only)

When the request involves implementing domain layer code for a **new feature** — where the feature's domain directory or key artefacts (models, interfaces, use cases) do not yet exist in the codebase — look up the corresponding backend feature in `YannicAmir/bizzie_function_app` via the GitHub MCP server before producing the plan. The backend is the authoritative source for data shapes, field names, and business logic constraints.

### Steps

1. **Determine if this is a new feature** — check whether `lib/features/<feature>/domain/` exists and contains the relevant code. If it does, skip this section and proceed to the Discovery Process below.

2. **Identify the backend feature name** — derive the feature name from the request context (e.g. "notifications", "connections", "profile"). If the name in `bizzie_function_app` is unclear or cannot be confidently inferred, ask the user before proceeding:
   > *"To reference the backend implementation, what is the name of this feature in bizzie_function_app?"*

3. **Search the repo** — use the GitHub MCP `search_code` tool with query `repo:YannicAmir/bizzie_function_app <feature_name>` to identify relevant files (functions, handlers, type definitions, models).

4. **Read key files** — use `get_file_contents` to read the handler and type/model files for the feature. Focus on:
   - Data shapes and field names (these inform domain model fields)
   - Business rules and validations the backend enforces (these inform use case logic)
   - Collection paths or resource identifiers (these inform repository interface method signatures)

5. **Apply findings** — reference the backend data shapes and field names directly when defining domain models, params classes, and repository interface method signatures. Note backend-derived decisions in the plan's Overview.

---

## Discovery Process

### For new use cases
Read the target feature's `domain/interfaces/` to understand:
- Existing repository interfaces and their method signatures
- Whether the required repository method already exists or needs to be added

Read the target feature's `presentation/bloc/` to understand:
- Which event triggers the use case
- What state should be emitted on success and failure

### For new repository interfaces
Read `data/repositories/` to understand:
- What datasource methods are needed to fulfill the interface
- Whether the data infrastructure already exists

### For new domain models
Read existing models in `domain/models/` to understand:
- Existing model patterns and conventions
- Whether a params class is needed for a use case

### For updates to existing domain logic
Read all files in scope to understand the current implementation before proposing changes.

---

## Plan Format

Every implementation plan must contain:

### Overview
A one-paragraph summary: what is being built or changed, in which domain sub-layer, and why.

### Layer Decision
Explicitly state which domain sub-layer(s) are involved:
- `domain/models/` — new `@freezed` domain model or params class
- `domain/interfaces/` — new or extended repository interface
- `domain/usecases/` — new use case class
- `domain/services/` — pure stateless domain logic helper
- `domain/extensions/` — extension methods on domain models

### New Files (builds only)
List any new files to be created with their paths.

### Modified Files
List all existing files to be modified with the specific changes required in each.

### Implementation Steps
Numbered, sequenced steps. Each step specifies:
- The target file path
- The exact change (e.g. "add `addToWatchlist(Company company, String uid)` to `IWatchlistRepository` returning `Future<Either<Failure, void>>`", "create `AddToWatchlistUseCase` implementing `UseCase<Either<Failure, void>, AddToWatchlistParams>`")
- Any dependency on preceding steps

### Return Type Decision (for repository interface methods)
State which return type is used and why:
- `Future<Either<Failure, T>>` — standard async operation that can fail
- `Future<Either<Failure, void>>` — write operation with no return value
- `Stream<Either<Failure, T>>` — real-time Firestore stream
- `Future<T>` — infallible operation (rare)

### build_runner Required
State explicitly: yes (if any `@freezed` model is added/modified) or no.

---

## Checklist
- [ ] If new feature: backend feature looked up in `YannicAmir/bizzie_function_app` via GitHub MCP before planning; if feature name was unclear, user was asked first
- [ ] Target context confirmed and relevant files read before planning
- [ ] Layer decision explicit — each artefact placed in the correct domain sub-layer
- [ ] Plan contains: Overview, Layer Decision, New/Modified Files, sequenced Implementation Steps
- [ ] Return type pattern stated for any new repository interface methods
- [ ] No layer violations planned (no Firebase imports in domain, no UI state in domain)
- [ ] `build_runner` decision stated
- [ ] Delegated to DomainBuilder or DomainUpdater immediately after plan completion
