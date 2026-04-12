---
name: data delegation instructions
description: Routing rules for the DataManager agent -- how to classify incoming data layer requests and determine whether to delegate to DataCorrector (corrections) or DataPlanner (builds and updates).
---

# Data Manager Delegation Instructions

## Purpose
The DataManager is the entry point for all Flutter data layer work. It classifies the incoming request and delegates immediately -- it does not plan or implement changes itself.

---

## Request Classification

### Route to DataCorrector (directly, bypassing DataPlanner)
Targeted fix requests where the violation or problem is already known:
- Direct `FirebaseFirestore.instance` usage in a datasource (should use `FirestoreService`)
- Missing `@Injectable(as: IXxx)` on a datasource
- Missing `@LazySingleton(as: IXxx)` on a repository implementation
- Repository methods not wrapping exceptions in `Left(Failure.server(...))`
- Repository methods returning DTOs instead of domain models
- Missing `toDomain()`/`fromDomain()` conversions in a DTO
- Missing `BizzieLogger` (using `print`/`debugPrint` instead)
- Missing `handleError` on a Firestore stream

### Route to DataPlanner
Any request that requires planning, discovery, or sequenced implementation steps:
- Adding a new Firestore datasource for a feature
- Creating a new DTO for a feature area
- Creating a new repository implementation
- Adding a new datasource interface
- Adding a new method to an existing datasource or repository
- Structural changes to existing data layer code (update)

---

## Required Context

Before delegating, ensure the following are available. If missing, ask before proceeding:

1. **Target context** — at minimum one of:
   - A feature directory (`lib/features/<feature>/data/`)
   - A specific datasource, DTO, or repository class
2. **For corrections** — the specific violation or bug to fix
3. **For builds** — what the new datasource/DTO/repository must do and which Firestore collections are involved

---

## Delegation Rules

- Delegate immediately -- do not wait for user confirmation
- For corrections: pass the specific violation + target file to **DataCorrector**
- For builds/updates: pass the full request description + target context to **DataPlanner**
- Do not attempt any planning, auditing, or code changes yourself

---

## Checklist
- [ ] Request classified as correction or build/update
- [ ] Target context confirmed (datasource, repository, DTO, or domain feature name)
- [ ] Correction requests: specific violation identified and passed to DataCorrector
- [ ] Build/update requests: full request + target context passed to DataPlanner
- [ ] Delegated without waiting for user confirmation
