---
name: domain guidance
description: Guidelines for implementing domain layer logic in this Flutter app. Covers the clean architecture domain layer: UseCases, repository interfaces, domain models, Either<Failure,T> return types, and the rules for what each layer owns. Referenced by DomainPlanner, DomainBuilder, DomainUpdater, DomainCorrector, and DomainEnforcer.
---

# Domain Layer Guidance

> The domain layer contains pure Dart business logic with no framework or SDK dependencies. Every BLoC communicates with the outside world exclusively through UseCases.

---

## 1. Layer Responsibilities

### `lib/features/<feature>/domain/`
Owns: domain models (`@freezed`), repository interfaces (`IXxxRepository`), UseCases, domain services, extensions, enums.
Does **not** own: Firebase calls, HTTP calls, JSON parsing, UI state, analytics, navigation.

### `lib/features/<feature>/presentation/bloc/`
BLoCs orchestrate UseCases and emit state. They call UseCases and fold `Either<Failure,T>` results into state.
Does **not** own: raw HTTP calls, JSON parsing, repository implementation details.

### `lib/features/<feature>/data/`
Implements repository interfaces. Owns: DTO ↔ domain model conversion, Firebase/HTTP calls, local caching.

---

## 2. UseCase Base Classes

All use cases implement one of these from `lib/core/usecase/usecase.dart`:

| Base class | When to use |
|---|---|
| `UseCase<Result, Params>` | Standard async (most common) — returns `Future<Result>` |
| `StreamUseCase<Result, Params>` | Real-time streams — returns `Stream<Result>` |
| `SynchronousUseCase<Result, Params>` | Synchronous — returns `Result` |
| `NoParams` | Sentinel when no parameters required |

UseCase rules:
- Annotate with `@injectable`
- Positional constructor parameter for the repository interface
- `call()` returns `Either<Failure, T>` or `Stream<Either<Failure, T>>`
- Named `XxxUseCase` (capital C)
- Delegates to the repository — no business logic beyond coordination

---

## 3. UseCase Parameters

When a use case requires multiple parameters, wrap in a `@freezed` params class in `domain/models/`:
```
@freezed class AddToWatchlistParams with _$AddToWatchlistParams {
  const factory AddToWatchlistParams({ required Company company, required String uid }) = _AddToWatchlistParams;
}
```
For a single primitive or when no params needed, pass the value directly or use `NoParams`.

---

## 4. Return Type Patterns

| Return type | When to use |
|---|---|
| `Future<Either<Failure, T>>` | Async operations that can fail |
| `Future<Either<Failure, void>>` | Write operations with no return value |
| `Stream<Either<Failure, T>>` | Real-time Firestore streams |

Never return a raw domain type from a repository method that can fail — always wrap in `Either`.

---

## 5. Repository Interfaces

- Named `IXxxRepository` (capital I prefix)
- Located in `domain/interfaces/`
- All fallible methods return `Either<Failure, T>` or `Stream<Either<Failure, T>>`
- No imports from `data/` layer — pure Dart, dartz, and domain types only

---

## 6. Domain Models

- `@freezed abstract class XxxModel with _$XxxModel` with `const factory` constructors
- Located in `domain/models/`
- No imports from data or presentation layer
- `part 'xxx_model.freezed.dart'` directive required

---

## 7. BLoC — Consuming UseCases

BLoCs inject UseCases via positional constructor parameters. They never inject repository interfaces directly.

Either results are always folded in event handlers:
```
result.fold(
  (failure) => emit(XxxState.failure(failure)),
  (data)    => emit(XxxState.loaded(data)),
);
```

For stream results use `emit.forEach` or `emit.onEach` (see flutter.bloc.best.practice.instructions.md).

---

## 8. Failure Type

All errors wrap to `Failure` from `lib/core/error/failures.dart`:
- In repositories: `return Left(Failure.server(e.toString()));`
- In BLoCs: access the message via `failure.errorMessage`

---

## 9. Decision Guide

```
Pure logic / calculation with no I/O?         → domain/services/ or domain/extensions/
Fetch or persist data (Firestore, storage)?   → data/ behind domain/interfaces/
Coordinate one UseCase + one repository?      → domain/usecases/
Orchestrate UseCases / manage UI state?       → presentation/bloc/
```

---

## Checklist
- [ ] UseCase implements `UseCase`, `StreamUseCase`, or `SynchronousUseCase`
- [ ] UseCase annotated `@injectable`
- [ ] UseCase takes a repository interface (not implementation) as constructor parameter
- [ ] Multi-param use cases use a `@freezed` params class in `domain/models/`
- [ ] Repository interface in `domain/interfaces/` with `I` prefix
- [ ] Repository interface methods return `Either<Failure, T>`
- [ ] Domain models are `@freezed` abstract classes in `domain/models/`
- [ ] BLoC injects UseCases (not repository interfaces)
- [ ] BLoC uses `fold` to handle Either results
- [ ] No Firebase, HTTP, or storage imports in domain layer
- [ ] `build_runner` run after any `@freezed` addition or change
