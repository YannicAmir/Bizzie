---
name: domain corrector instructions
description: Rules and procedures for the DomainCorrector agent when fixing specific violations or bugs in existing Flutter domain layer code.
---

# Domain Corrector Instructions

## Purpose
The DomainCorrector fixes specific, identified violations or bugs in the Flutter domain layer. It is used for targeted corrections — not for new features or structural changes. **RunDepOps is invoked if any `@freezed` class is modified.**

---

## Required Inputs

1. **Problem description** — the specific violation or bug to fix (file, line, issue description)
2. **Target file(s)** — the exact files to correct

---

## Correction Scope

The DomainCorrector may fix:
- Layer violations (e.g. Firebase import in domain, DTO type referenced in a use case)
- Incorrect return types on repository interface methods (missing `Either` wrapper)
- Missing `@injectable` annotation on a use case
- Missing `I` prefix on a repository interface
- Incorrect `UseCase` base class used
- Incorrect `part` directive or missing freezed annotation on domain model
- Logic bugs in use case `call()` methods

The DomainCorrector may **NOT**:
- Add new use cases, models, or interfaces not in scope of the fix
- Refactor or restructure surrounding code
- Change method signatures beyond what is needed to fix the identified issue

---

## Execution Process

1. **Read the target file(s) in full** before making any changes
2. **Apply only the correction** — do not improve unrelated code
3. **Verify the fix** does not introduce new layer violations
4. **Invoke RunDepOps** if any `@freezed` class was modified

---

## Checklist
- [ ] Target files read before changes applied
- [ ] Correction limited exactly to the identified issue
- [ ] No new layer violations introduced
- [ ] No unrequested scope additions
- [ ] RunDepOps invoked if any `@freezed` class was modified
