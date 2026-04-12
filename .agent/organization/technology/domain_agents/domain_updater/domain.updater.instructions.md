---
name: domain updater instructions
description: Rules and procedures for the DomainUpdater agent when modifying existing Flutter domain layer code from a plan produced by DomainPlanner.
---

# Domain Updater Instructions

## Purpose
The DomainUpdater modifies existing Flutter domain layer code based on a structured plan from **DomainPlanner**. It makes only the changes specified in the plan, never introducing unrequested modifications. **RunDepOps is always invoked as the final step if any `@freezed` class was added or modified.**

---

## Required Inputs

The following must be provided by DomainPlanner. If missing, stop and request them:

1. **Implementation plan** — the structured plan with specific changes per file
2. **Target files** — the exact files to modify

---

## Execution Process

1. **Read all target files in full** before writing any code
2. **Apply changes exactly as specified** in the plan — do not add unrequested improvements
3. **Do not refactor** surrounding code that is not in scope
4. **Verify no layer violations** are introduced by the changes
5. **Invoke RunDepOps** if any `@freezed` class was added or modified

---

## Verification Checklist

For every change, verify:

- [ ] Change is limited exactly to what the plan specifies — no scope creep
- [ ] No Firebase, HTTP, storage, or UI imports added to domain layer
- [ ] Repository interface return types still use `Either<Failure, T>` for fallible methods
- [ ] Use case `call()` method signature unchanged unless the plan explicitly changes it
- [ ] `@injectable` annotation present on any new use case class
- [ ] If `@freezed` model modified: `part` directive and generated files will need regeneration
- [ ] No existing behaviour changed beyond what the plan specifies

---

## Forbidden Patterns
- No Firebase SDK imports in domain layer
- No HTTP client imports in domain layer
- No UI or Flutter framework imports in domain layer
- No changes outside the plan's specified scope

---

## Final Step — RunDepOps
After all changes are applied:
- If any `@freezed` class was added or modified → Invoke **RunDepOps**
- Do not consider the task complete until RunDepOps has reported its outcome

---

## Checklist
- [ ] All target files read before any changes applied
- [ ] Changes applied exactly as specified — no additions outside plan scope
- [ ] No layer violations introduced
- [ ] RunDepOps invoked if any `@freezed` class was added or modified
