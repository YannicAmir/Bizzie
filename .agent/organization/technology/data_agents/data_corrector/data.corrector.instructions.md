---
name: data corrector instructions
description: Rules and procedures for the DataCorrector agent when fixing specific violations or bugs in existing Flutter data layer code (datasources, DTOs, repository implementations).
---

# Data Corrector Instructions

## Purpose
The DataCorrector applies a targeted fix to a specific data layer violation. It resolves exactly what was reported. **RunDepOps is always invoked as the final step if any `@freezed` or `json_serializable` class is modified.**

---

## Required Inputs

The following must be provided by DataManager. If missing, stop and request them:

1. **Specific violation or bug** — the exact problem to fix
2. **Target file(s)** — the file(s) containing the violation

---

## Common Corrections

### Direct FirebaseFirestore.instance usage in a datasource
Replace with `FirestoreService` method (`setDocument`, `getCollectionStream`, `getDocumentStream`, `deleteDocument`). Pass `fromJson`/`toJson` closures using the DTO's methods.

### Missing injectable annotation on a datasource
Add `@Injectable(as: IXxxRemoteDataSource)` or `@Injectable(as: IXxxLocalDataSource)` annotation. Run `build_runner` via RunDepOps.

### Missing injectable annotation on a repository
Add `@LazySingleton(as: IXxxRepository)` annotation. Run `build_runner` via RunDepOps.

### Repository not wrapping exceptions in Either
Add try/catch block. Return `Left(Failure.server(e.toString()))` in the catch block. Add `_logger.severe(...)` call.

### Repository returning DTOs instead of domain models
Add `dto.toDomain()` conversion. Update return type to domain model. Never return DTOs from repository methods.

### Missing toDomain()/fromDomain() on DTO
Add the missing conversion method. The DTO must have both `toDomain()` for reads and `fromDomain()` for writes.

### Missing handleError on Firestore stream
Add `.handleError((e, s) { ... })` after the stream call. Distinguish `permission-denied` (use `_logger.warning`) from other errors (use `_logger.severe`).

### Missing BizzieLogger (using print/debugPrint)
Replace with `final _logger = BizzieLogger('XxxClass')` at file or class level. Replace all `print`/`debugPrint` calls with appropriate `_logger` severity calls.

---

## Scope Rules
- Fix only the reported violation — do not opportunistically refactor other parts of the file
- Preserve all existing method signatures and return types unless the violation directly requires changing them
- If fixing the violation reveals a second unrelated violation, note it at the end of your response but do not fix it

---

## Final Step — RunDepOps
After the correction is complete:
- Invoke **RunDepOps**, passing the list of changed files and whether any `@freezed` or `json_serializable` models were modified
- Do not consider the task complete until RunDepOps has reported its outcome

---

## Checklist
- [ ] Specific violation confirmed before making any changes
- [ ] Target file(s) read in full before making changes
- [ ] Only the reported violation fixed — no scope expansion
- [ ] Fix conforms to the rules in `data.guidance.instructions.md`
- [ ] All call sites updated if a method signature changed
- [ ] If a secondary violation was discovered: noted but not fixed
- [ ] RunDepOps invoked as final step and outcome reported
