---
name: data guidance
description: Guidelines for implementing data layer code in this Flutter app. Covers datasource interfaces, implementations (Firestore/local), DTOs with freezed + json_serializable, repository implementations, injectable annotations, Either<Failure,T> wrapping, and build_runner requirements. Referenced by DataPlanner, DataBuilder, DataUpdater, and DataCorrector.
---

# Data Guidance

> All data layer code communicates with the outside world (Firestore, APIs, local storage) and converts between DTOs and domain models. The domain layer never sees DTOs — it only receives domain models wrapped in `Either<Failure, T>`.

---

## 1. Architecture Flow

```
Presentation (BLoC) → Domain (UseCase) → Data (RepositoryImpl)
                                                 ├─ IXxxRemoteDataSource → FirestoreService
                                                 └─ IXxxLocalDataSource  → SharedPreferences / Hive
```

All data classes are registered via `injectable` annotations — never manually.

---

## 2. DTOs

Location: `data/dtos/<feature>_dto.dart`

Rules:
- Annotate with both `@freezed` and `@JsonSerializable(fieldRename: FieldRename.snake)` (or matching)
- Include `part 'xxx_dto.freezed.dart'` and `part 'xxx_dto.g.dart'` directives
- Add `const XxxDto._()` private constructor to support custom methods
- Implement `factory XxxDto.fromJson(Map<String, dynamic> json) => _$XxxDtoFromJson(json)`
- Implement `factory XxxDto.fromDomain(XxxModel model)` for write operations
- Implement `XxxModel toDomain()` for read operations
- Use `@TimestampConverter()` for Firestore `Timestamp` ↔ `DateTime` fields

---

## 3. Datasource Interfaces

Location: `data/interfaces/i_xxx_remote_datasource.dart`

Rules:
- Named `IXxxRemoteDataSource` (capital I prefix)
- Abstract only — no implementation details
- Return raw DTOs or primitives — never domain models

---

## 4. Datasource Implementations

Remote datasource rules:
- Annotate `@Injectable(as: IXxxRemoteDataSource)`
- Inject `FirestoreService` via positional constructor parameter
- Never call `FirebaseFirestore.instance` directly
- Call `_firestoreService.setDocument / getDocumentStream / getCollectionStream / getCollectionStreamChunked / deleteDocument`
- Attach `.handleError(...)` to all streams — log with `_logger.severe` on unexpected errors
- Declare `final _logger = BizzieLogger('XxxRemoteDataSource')` at file level
- `rethrow` on exceptions — the repository handles `Either` wrapping

Local datasource rules:
- Annotate `@Injectable(as: IXxxLocalDataSource)`
- Inject `ILocalStorageService` via positional constructor parameter
- Storage keys as `static const String _kXxxKey`

---

## 5. Repository Implementations

Location: `data/repositories/xxx_repository_impl.dart`

Rules:
- Annotate `@LazySingleton(as: IXxxRepository)`
- Inject `IXxxRemoteDataSource` (and `IXxxLocalDataSource` if needed) via positional constructor params
- Declare `final _logger = BizzieLogger('XxxRepositoryImpl')` as a field
- All methods return `Either<Failure, T>` — wrap every `catch` in `Left(Failure.server(e.toString()))`
- Convert DTOs to domain models with `.toDomain()` before returning; use `XxxDto.fromDomain(model)` before writes
- Stream methods map `List<XxxDto>` to `Either<Failure, List<XxxModel>>` using a `StreamTransformer` or `rxdart`

---

## 6. Injectable Annotation Reference

| Annotation | When to use |
|---|---|
| `@Injectable(as: IXxx)` | Datasource implementations |
| `@LazySingleton(as: IXxx)` | Repository implementations |
| `@lazySingleton` | Singletons with no interface (e.g. analytics trackers) |
| `@injectable` | BLoCs and use cases |

Never call `GetIt.I.registerSingleton()` or `registerFactory()` manually for app features.

---

## 7. Firestore Methods via FirestoreService

Available methods (never use `FirebaseFirestore.instance` directly):
- `setDocument<T>(path, value, toJson)` — create or overwrite a document
- `getDocumentStream<T>(path, fromJson, toJson)` — single doc real-time stream
- `getCollectionStream<T>(path, fromJson, toJson)` — collection real-time stream
- `getCollectionStreamChunked<T>(path, whereInField, values, fromJson, toJson, chunkSize)` — chunked `whereIn`
- `deleteDocument(path)` — delete a document

---

## 8. build_runner Requirements

Run `dart run build_runner build --delete-conflicting-outputs` after:
- Adding or modifying any DTO (`@freezed` + `json_serializable`)
- Adding or modifying any other `@freezed` class (domain models, BLoC states/events, params classes)
- Adding or modifying any `@injectable` class

**Both the domain layer and the data layer require build_runner.**

---

## Checklist
- [ ] DTO: `@freezed` + `@JsonSerializable`, `fromJson`, `fromDomain()`, `toDomain()`
- [ ] DTO `part` directives present (`.freezed.dart` and `.g.dart`)
- [ ] Datasource interface in `data/interfaces/` with `I` prefix
- [ ] Remote datasource annotated `@Injectable(as: IXxxRemoteDataSource)`
- [ ] Remote datasource uses `FirestoreService` — no `FirebaseFirestore.instance`
- [ ] Repository annotated `@LazySingleton(as: IXxxRepository)`
- [ ] Repository wraps all exceptions in `Left(Failure.server(...))`
- [ ] Repository maps DTOs to domain models before returning
- [ ] `BizzieLogger` declared in all datasources and repositories
- [ ] No `GetIt.I()` calls inside method bodies — constructor injection only
- [ ] `build_runner` run after any `@freezed` or `@injectable` addition or change
