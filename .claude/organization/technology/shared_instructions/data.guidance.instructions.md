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
- Call the `FirestoreService` methods listed in §7 — never build queries against the Firestore SDK directly
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
| `@lazySingleton` | Singletons with no interface (e.g. analytics trackers, use cases) |
| `@injectable` | BLoCs |

Never call `GetIt.I.registerSingleton()` or `registerFactory()` manually for app features.

---

## 7. Firestore Methods via FirestoreService

Available methods (never use `FirebaseFirestore.instance` directly):

Writes:
- `setDocument<T>(path, value, toJson, merge?)` — create or overwrite a document
- `updateDocument(path, data)` — partial update of an existing document
- `deleteDocument(path)` — delete a document
- `batch()` — returns a `BizzieBatch` for atomic multi-document writes

One-shot reads:
- `getDocument<T>(path, fromJson, toJson)` — single document read
- `getLatestDocument<T>(collectionPath, orderBy, fromJson, toJson, descending?)` — newest document in a collection
- `getCollection<T>(path, fromJson, toJson, queryBuilder?)` — collection read
- `getCollectionFuture<T>(path, fromJson, toJson, whereInField?, whereInValues?, queryBuilder?)` — collection read with optional single-chunk `whereIn` filter (≤ 30 values)
- `getCollectionFutureChunked<T>(path, whereInField, values, fromJson, toJson, chunkSize?, queryBuilder?)` — chunked `whereIn` read for arbitrary value counts

Real-time streams:
- `getDocumentStream<T>(path, fromJson, toJson)` — single doc stream
- `getCollectionStream<T>(path, fromJson, toJson, queryBuilder?)` — collection stream; pass `queryBuilder` for ordering or filtering
- `getCollectionStreamChunked<T>(path, whereInField, values, fromJson, toJson, chunkSize?, queryBuilder?)` — chunked `whereIn` stream
- `getCollectionGroupStreamChunked<T>(collectionId, whereInField, values, fromJson, chunkSize?)` — chunked `whereIn` stream over a collection group
- `getMergedSubcollectionStreams<T>(rootCollection, documentIds, subcollectionId, fromJson, injectDocumentIdAs?)` — merged stream of the same subcollection across multiple documents

Never chunk `whereIn` values manually in a datasource — use the `*Chunked` methods; chunk splitting lives only in `FirestoreService`.

Subcollection paths are plain strings, e.g. `'users/$uid/conversations/$sessionId/messages'`.

---

## 7a. Raw HTTP POST to Firebase Cloud Functions (non-callable)

Some Firebase Cloud Functions are deployed as raw HTTP endpoints (`onRequest`) rather than callable functions (`onCall`). Use this pattern when the function requires streaming (SSE) or when `httpsCallable` is insufficient.

**When to use:** The feature's backend function is an `onRequest` function, OR the response must be streamed token-by-token (SSE).

**Transport:** `@Named('BizzieDio')` Dio instance — already registered in `NetworkModule`. It injects a Firebase ID token Bearer header on every request via `BizzieAuthInterceptor` and has a 95 s receive timeout to cover the 90 s backend SSE timeout.

**Non-streaming POST:**
```dart
final response = await _dio.post<Map<String, dynamic>>(
  '/functionName',
  data: requestDto.toJson(),
);
return ResponseDto.fromJson(response.data!);
```

**Streaming POST (SSE):**
```dart
final response = await _dio.post<ResponseBody>(
  '/functionName',
  data: requestDto.toJson(),
  options: Options(responseType: ResponseType.stream),
);
final buffer = StringBuffer();
await for (final chunk in response.data!.stream.map((b) => utf8.decode(b))) {
  buffer.write(chunk);
  final text = buffer.toString();
  final lines = text.split('\n');
  buffer..clear()..write(lines.last);
  for (final line in lines.sublist(0, lines.length - 1)) {
    if (!line.startsWith('data: ')) continue;
    final raw = line.substring(6).trim();
    if (raw.isEmpty) continue;
    yield SseEventDto.fromRawLine(raw); // parse JSON, yield DTO
  }
}
```

**SSE DTO pattern:** Use a `sealed class` (not `@freezed`) with a `factory fromRawLine(String)` that `jsonDecode`s and switches on `json['type']`. Each subtype implements `toDomain()`.

**Error mapping in repository:** Catch `DioException` and map HTTP status codes to `Failure` variants:
- 401 → `Failure.permission(...)`
- 403 → `Failure.permission(...)`
- 404 → `Failure.userNotFound()`
- 429 → `Failure.rateLimit(retryAfterSeconds: data['retryAfterSeconds'])` — parse from response body
- 503 → `Failure.server(...)`

**Base URL:** The function base URL is sourced from **Firebase Remote Config via `IConfigService`** — not from `AppEnv`/envied. Add a `static const String xyzBaseUrl = 'xyz_base_url'` entry to `RemoteConfigKeys`, a default empty string in `ConfigService.initialize()` `setDefaults`, and a `String get xyzBaseUrl` getter to both `IConfigService` and `ConfigService`. Wire in `NetworkModule` as `configService.xyzBaseUrl`. Never add function base URLs to `.env.*` files or `AppEnv`.

**Reference implementation:** `bizzie_chat` feature —
- Interceptor: `lib/core/network/bizzie_auth_interceptor.dart`
- Dio registration: `lib/core/network/network_module.dart` (`@Named('BizzieDio')`)
- SSE DTO: `lib/features/bizzie_chat/data/dtos/bizzie_chat_sse_event_dto.dart`
- Datasource: `lib/features/bizzie_chat/data/datasources/bizzie_chat_remote_datasource.dart`
- Repository: `lib/features/bizzie_chat/data/repositories/bizzie_chat_repository_impl.dart`

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
- [ ] SSE event DTO: `sealed class` (not `@freezed`), `factory fromRawLine(String)`, `toDomain()` on each subtype
- [ ] Datasource interface in `data/interfaces/` with `I` prefix
- [ ] Remote datasource annotated `@Injectable(as: IXxxRemoteDataSource)`
- [ ] Remote datasource uses `FirestoreService` for Firestore — no `FirebaseFirestore.instance`
- [ ] Raw HTTP datasources use `@Named('BizzieDio')` — not `httpsCallable`
- [ ] Raw HTTP base URL sourced from `IConfigService` (Remote Config) — never from `AppEnv`/envied
- [ ] DioException in repository mapped via `FunctionAppErrorMapper.map(e, s, context)` — no per-feature status-code switch
- [ ] Repository annotated `@LazySingleton(as: IXxxRepository)`
- [ ] Repository wraps all exceptions in `Left(Failure.server(...))` or mapped failure
- [ ] Repository maps 429 DioException to `Failure.rateLimit(retryAfterSeconds: ...)`
- [ ] Repository maps DTOs to domain models before returning
- [ ] `BizzieLogger` declared in all datasources and repositories
- [ ] No `GetIt.I()` calls inside method bodies — constructor injection only
- [ ] `build_runner` run after any `@freezed` or `@injectable` addition or change
