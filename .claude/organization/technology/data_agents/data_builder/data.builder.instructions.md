---
name: data builder instructions
description: Rules and procedures for the DataBuilder agent when implementing new Flutter data layer code (DTOs, datasources, repository implementations) from a plan produced by DataPlanner.
---

# Data Builder Instructions

## Purpose
The DataBuilder creates new Flutter data layer code from scratch based on a structured plan from **DataPlanner**. It follows the plan step by step, ensuring every piece of data layer code conforms to project conventions. **RunDepOps is always invoked as the final step.**

---

## Required Inputs

The following must be provided by DataPlanner. If missing, stop and request them:

1. **Implementation plan** — the structured plan (Overview, New Files, Implementation Steps, injectable annotations, build_runner decision)
2. **Target context** — the feature directory or domain area

---

## Implementation Checklist

Execute the plan in step order. For each new piece of data layer code, verify:

### DTOs (`data/dtos/`)
- [ ] `@freezed abstract class XxxDto with _$XxxDto`
- [ ] `part 'xxx_dto.freezed.dart'` and `part 'xxx_dto.g.dart'` directives present
- [ ] `const XxxDto._()` private constructor included (for custom methods)
- [ ] `factory XxxDto.fromJson(Map<String, dynamic> json)` present
- [ ] `factory XxxDto.fromDomain(XxxDomainModel model)` present for write operations
- [ ] `XxxDomainModel toDomain()` method present for read operations
- [ ] `@TimestampConverter()` used for any `DateTime` Firestore fields
- [ ] No domain model fields exposed directly — always mapped

### Datasource interfaces (`data/interfaces/`)
- [ ] Named `IXxxRemoteDataSource` or `IXxxLocalDataSource`
- [ ] Abstract class — no implementation
- [ ] Method signatures match what the repository implementation will call

### Datasource implementations (`data/datasources/`)
- [ ] Annotated `@Injectable(as: IXxxRemoteDataSource)` or `@Injectable(as: IXxxLocalDataSource)`
- [ ] Remote: uses `FirestoreService` — not `FirebaseFirestore.instance` directly
- [ ] Remote: `final _logger = BizzieLogger('XxxRemoteDataSource')` at file level
- [ ] Remote: `handleError` on all streams — distinguishes `permission-denied` (warning) from others (severe)
- [ ] Remote: all write operations wrapped in try/catch with `_logger.severe` + rethrow
- [ ] Local: uses `ILocalStorageService` or `SharedPreferences` — private key constants

### Repository implementations (`data/repositories/`)
- [ ] Annotated `@LazySingleton(as: IXxxRepository)`
- [ ] `final _logger = BizzieLogger('XxxRepositoryImpl')` instance field
- [ ] Implements all methods from `IXxxRepository` domain interface
- [ ] All methods catch exceptions and return `Left(Failure.server(e.toString()))`
- [ ] Maps DTOs to domain models before returning — never returns DTOs
- [ ] Stream methods use `StreamTransformer` to wrap in `Either`

---

## Raw HTTP / SSE Datasources

When the feature calls a Firebase Cloud Function via raw HTTP (not `httpsCallable`):

- Inject `@Named('BizzieDio') Dio` — already configured with `BizzieAuthInterceptor` and 95 s timeout
- **Non-streaming POST:** `_dio.post<Map<String, dynamic>>(endpoint, data: dto.toJson())`
- **Streaming POST (SSE):** `_dio.post<ResponseBody>(endpoint, data: dto.toJson(), options: Options(responseType: ResponseType.stream))` — then iterate `response.data!.stream.map((b) => utf8.decode(b))`, buffer lines, parse `data: ` prefixed lines
- **SSE DTO:** `sealed class` with `factory fromRawLine(String)` — not `@freezed`. Each concrete subtype implements `toDomain()`.
- **Repository error mapping:** Catch `DioException`, map status codes — 401/403 → `Failure.permission`, 404 → `Failure.userNotFound`, 429 → `Failure.rateLimit(retryAfterSeconds: ...)`, 503 → `Failure.server`
- **Stream wrapping:** Use `rxdart`'s `.onErrorReturnWith(...)` to convert stream errors to `Left(Failure)` without terminating the stream type
- **AppEnv:** Add `String get xyzBaseUrl` to `AppEnv`, add `@EnviedField` to all three env files, wire in `env_impl.dart`

Reference: `lib/features/bizzie_chat/data/` for the complete implementation pattern.

---

## Forbidden Patterns
- No `FirebaseFirestore.instance` calls outside `FirestoreService`
- No domain model fields referencing DTOs or Firestore types
- No `ApiResult` or `AppApiClient` — this project uses Firebase/Firestore or `@Named('BizzieDio')` for raw HTTP
- No manual `GetIt` registration — use `injectable` annotations only
- No business logic inside datasource methods — pure I/O only
- No `print()` or `debugPrint()` — always use `BizzieLogger`

---

## Final Step — build_runner
After all implementation steps are complete, if any `@freezed` DTO or `@injectable` class was added or modified:

**In Claude Code (inline execution context):** run build_runner directly via Bash:
```bash
dart run build_runner build --delete-conflicting-outputs
```
Run from the Flutter project root (the directory containing `pubspec.yaml`). Report whether it succeeded or failed with relevant output lines.

**In a subagent context:** invoke **RunDepOps**, passing the list of changed files and whether any `@freezed` or `json_serializable` DTOs/models were added or modified.

Do not consider the task complete until build_runner has been run and its outcome reported.

---

## Checklist
- [ ] Plan steps executed in order
- [ ] DTOs use `@freezed` + `json_serializable` with `fromDomain()`/`toDomain()`
- [ ] SSE event DTOs use `sealed class` with `fromRawLine(String)` — not `@freezed`
- [ ] Datasource implementations annotated `@Injectable(as: IXxx)`
- [ ] Repository implementations annotated `@LazySingleton(as: IXxx)`
- [ ] All Firestore access via `FirestoreService`
- [ ] Raw HTTP/SSE datasources use `@Named('BizzieDio')` — not `httpsCallable`
- [ ] Repository catches all exceptions and returns `Left(Failure...)` with correct mapping
- [ ] 429 DioException mapped to `Failure.rateLimit(retryAfterSeconds: ...)` — not `Failure.server`
- [ ] `BizzieLogger` used throughout — no `print()`
- [ ] No forbidden patterns introduced
- [ ] build_runner run as final step (directly via Bash in Claude Code, or via RunDepOps subagent) and outcome reported
