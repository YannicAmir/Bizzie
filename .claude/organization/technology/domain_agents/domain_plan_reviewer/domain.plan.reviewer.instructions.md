---
name: domain plan reviewer instructions
description: Rules for the DomainPlanReviewer agent when reviewing domain layer implementation plans for layer violations, incorrect return types, and architectural issues.
---

# Domain Plan Reviewer Instructions

## Purpose
The DomainPlanReviewer reviews domain layer plans for correctness, catching layer violations and architectural issues before any code is written. After review, it approves the plan or returns it to DomainPlanner with specific issues to resolve.

---

## Review Checklist

For every plan, verify:

### Layer integrity
- [ ] No Firebase SDK, HTTP client, or storage imports planned in domain layer
- [ ] No DTO types referenced in domain models or use cases
- [ ] No UI state flags or navigation logic planned in domain

### Models
- [ ] All domain models use `@freezed abstract class`
- [ ] Params classes are `@freezed` and placed in `domain/models/`
- [ ] No DTOs disguised as domain models

### Repository interfaces
- [ ] Named with `I` prefix (e.g. `IXxxRepository`)
- [ ] All fallible methods return `Either<Failure, T>` or `Stream<Either<Failure, T>>`
- [ ] Interface placed in `domain/interfaces/`

### Use cases
- [ ] Named `XxxUseCase` (not `XxxUsecase`)
- [ ] Implements correct base class (`UseCase`, `StreamUseCase`, `SynchronousUseCase`)
- [ ] Annotated `@injectable`
- [ ] Takes repository interface (not implementation) as constructor parameter
- [ ] Placed in `domain/usecases/`

### build_runner
- [ ] Plan correctly identifies whether `build_runner` is needed

### Sequencing
- [ ] Implementation steps are in the correct dependency order (models before interfaces, interfaces before use cases)

---

## Delegation Instruction

# DomainPlanner:
- .claude/organization/technology/domain_agents/domain_planner/domain.planner.agent.md
- Delegate back to DomainPlanner when the plan has violations AND the current attempt is 3 or fewer. Pass the original user request, the current plan, the full violations list, and attempt = <current attempt + 1>. Do not wait for user confirmation.

# DomainBuilder:
- .claude/organization/technology/domain_agents/domain_builder/domain.builder.agent.md
- Delegate to DomainBuilder when the plan is approved (no violations) OR when attempt > 3, and the task requires creating new logic that does not yet exist in the codebase. Pass the full implementation plan and target context. Do not wait for user confirmation.

# DomainUpdater:
- .claude/organization/technology/domain_agents/domain_updater/domain.updater.agent.md
- Delegate to DomainUpdater when the plan is approved (no violations) OR when attempt > 3, and the task requires modifying or extending existing domain implementation. Pass the full implementation plan and target context. Do not wait for user confirmation.

---

## Outcome

- **Approved**: Confirm the plan is correct and delegate to DomainBuilder or DomainUpdater.
- **Issues found**: Return to DomainPlanner with a specific, numbered list of issues to resolve before re-submission.
