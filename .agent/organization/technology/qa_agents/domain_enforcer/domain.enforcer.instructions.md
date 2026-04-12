---
name: domain enforcer instructions
description: Domain-specific checks for DomainEnforcer. Violations to look for when measuring domain layer implementation against domain.guidance.instructions.md. References qa.enforcement.pattern.instructions.md for retry loop rules.
---

# Domain Enforcer Instructions

## Guidance Source
Verify all changed files against every checklist item in `domain.guidance.instructions.md`.

## Key Violation Categories

### UseCase violations
- UseCase class not implementing `UseCase<Result, Params>`, `StreamUseCase<Result, Params>`, or `SynchronousUseCase<Result, Params>`
- UseCase calling a datasource directly instead of going through `IXxxRepository`
- UseCase implementing business logic beyond delegating to a repository method
- `call()` method not returning `Either<Failure, T>` (or `Stream<Either<Failure, T>>` for stream use cases)
- Missing `@injectable` annotation on UseCase class
- UseCase constructor obtaining dependency via `GetIt` inside a method body instead of constructor injection
- `NoParams` not used when the use case requires no parameters
- Params class not using `@freezed` when it has fields

### Repository interface violations
- Repository interface not prefixed with `I` (e.g., `WatchlistRepository` instead of `IWatchlistRepository`)
- Repository interface placed outside `lib/features/<feature>/domain/interfaces/`
- Repository interface method not returning `Either<Failure, T>` or `Stream<Either<Failure, T>>`
- Concrete repository implementation placed in the domain layer (belongs in data layer)

### Domain model violations
- Domain model not using `@freezed abstract class` with factory constructors
- Domain model importing data layer types (DTOs, datasources)
- Domain model placed outside `lib/features/<feature>/domain/models/`
- `part` directive missing from a `@freezed` domain model file

### Layer boundary violations
- Domain layer importing from data layer (datasources, repositories, DTOs)
- Domain layer importing from presentation layer
- BLoC calling a repository or datasource directly instead of through a use case

## Enforcement Loop
Follow the retry loop rules in `qa.enforcement.pattern.instructions.md`.

## Checklist
- [ ] All changed files read
- [ ] Every item in `domain.guidance.instructions.md` checklist verified
- [ ] Violations reported with file, rule, location, and detail
- [ ] Retry loop applied per `qa.enforcement.pattern.instructions.md`
