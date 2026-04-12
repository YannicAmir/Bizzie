---
name: domain builder instructions
description: Rules and procedures for the DomainBuilder agent when implementing new Flutter domain layer code (UseCases, interfaces, models) from a plan produced by DomainPlanner.
---

# Domain Builder Instructions

## Purpose
The DomainBuilder creates new Flutter domain layer code from scratch based on a structured plan from **DomainPlanner**. It follows the plan step by step, ensuring every artefact is placed in the correct domain sub-layer and conforms to project conventions. **RunDepOps is always invoked as the final step if any `@freezed` class was added or modified.**

---

## Required Inputs

The following must be provided by DomainPlanner. If missing, stop and request them:

1. **Implementation plan** — the structured plan (Overview, Layer Decision, New Files, Implementation Steps, build_runner decision)
2. **Target context** — the feature directory

---

## Implementation Checklist

Execute the plan in step order. For every new domain artefact, verify:

### Domain models (`domain/models/`)
- [ ] Class is `@freezed abstract class XxxModel with _$XxxModel`
- [ ] `part 'xxx_model.freezed.dart'` directive present
- [ ] All fields are `required` unless there is a genuine reason for optional
- [ ] No Firebase, HTTP, or storage imports — pure Dart only
- [ ] If a params class: named `XxxParams`, placed in `domain/models/`

### Repository interfaces (`domain/interfaces/`)
- [ ] Named `IXxxRepository` (capital I prefix)
- [ ] Abstract class — no implementation details
- [ ] All fallible methods return `Either<Failure, T>` or `Stream<Either<Failure, T>>`
- [ ] Imports only: `dartz`, `failures.dart`, and other domain models
- [ ] No Firebase, HTTP, or data layer imports

### Use cases (`domain/usecases/`)
- [ ] Named `XxxUseCase` (not `XxxUsecase`)
- [ ] Implements `UseCase<Result, Params>`, `StreamUseCase<Result, Params>`, or `SynchronousUseCase<Result, Params>`
- [ ] Annotated `@injectable`
- [ ] Takes repository interface (not implementation) as constructor parameter
- [ ] `call()` method delegates to repository — no business logic unless orchestrating multiple repositories
- [ ] No Firebase, HTTP, or UI imports

### Domain services (`domain/services/`)
- [ ] Stateless pure logic — no I/O dependencies
- [ ] Annotated `@injectable` if injected, otherwise plain class
- [ ] No Firebase, HTTP, storage, or UI imports

### Domain extensions (`domain/extensions/`)
- [ ] Extension on a domain model or standard Dart type
- [ ] Pure — no side effects or I/O

---

## Forbidden Patterns
- No Firebase SDK imports in domain layer
- No HTTP client imports in domain layer
- No UI or Flutter framework imports in domain layer
- No raw `GetIt.I()` calls in domain classes
- No `ApiResult` or `ApiClient` references in domain layer
- No datasource or DTO types referenced in domain layer

---

## Final Step — RunDepOps
After all implementation steps are complete:
- If any `@freezed` class was added or modified → Invoke **RunDepOps**
- Pass the list of changed files and confirm that `@freezed` models were changed
- Do not consider the task complete until RunDepOps has reported its outcome

---

## Checklist
- [ ] Plan steps executed in order
- [ ] All domain models use `@freezed` with `part` directive
- [ ] Repository interfaces use `I` prefix and return `Either<Failure, T>`
- [ ] Use cases implement the correct base class and are annotated `@injectable`
- [ ] No layer violations (no Firebase/HTTP/UI in domain)
- [ ] RunDepOps invoked if any `@freezed` class was added or modified
