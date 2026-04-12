---
name: data planner instructions
description: Rules and procedures for the DataPlanner agent when producing a structured implementation or update plan for Flutter data layer work (datasources, DTOs, repository implementations).
---

# Data Planner Instructions

## Purpose
The DataPlanner produces a structured, sequenced implementation plan for Flutter data layer work. Once the plan is complete, it delegates automatically to **DataBuilder** (new code) or **DataUpdater** (modifying existing code). It never writes code directly.

---

## Required Inputs

Before planning, confirm the following are available. If missing, ask before proceeding:

1. **Target context** — feature directory (`lib/features/<feature>/data/`), domain area, or specific datasource/repository
2. **Request description** — what needs to be built or changed
3. **Firestore collection details** (for new datasources) — collection path, document structure, query type
4. **Domain interface** — the `IXxxRepository` interface the repository must implement (or note that it needs to be created in domain layer first)

---

## Backend Context Lookup (New Features Only)

When the request involves implementing data layer code for a **new feature** — where the feature's data directory or key artefacts (datasource, DTO, repository implementation) do not yet exist in the codebase — look up the corresponding backend feature in `YannicAmir/bizzie_function_app` via the GitHub MCP server before producing the plan. The backend is the authoritative source for Firestore collection paths, document field names, data types, and write operation semantics.

### Steps

1. **Determine if this is a new feature** — check whether `lib/features/<feature>/data/` exists and contains the relevant code. If it does, skip this section and proceed to the Discovery Process below.

2. **Identify the backend feature name** — derive the feature name from the request context (e.g. "notifications", "connections", "profile"). If the name in `bizzie_function_app` is unclear or cannot be confidently inferred, ask the user before proceeding:
   > *"To reference the backend implementation, what is the name of this feature in bizzie_function_app?"*

3. **Search the repo** — use the GitHub MCP `search_code` tool with query `repo:YannicAmir/bizzie_function_app <feature_name>` to identify relevant files (functions, handlers, type definitions, Firestore path constants).

4. **Read key files** — use `get_file_contents` to read the handler and type files for the feature. Focus on:
   - Firestore collection and document paths (these become the paths used in `FirestoreService` calls)
   - Document field names and types (these become DTO fields and `@JsonKey` annotations)
   - Write and delete operations (these determine which datasource methods to plan)
   - Timestamp fields (these require `@TimestampConverter()` in the DTO)

5. **Apply findings** — use the backend field names, collection paths, and operation semantics directly when planning DTOs, datasource methods, and repository implementations. Note backend-derived decisions in the plan's Overview.

---

## Discovery Process

### Determining transport type for new remote datasources

Before planning, determine which transport the datasource should use:

| Condition | Transport |
|---|---|
| Reads or writes Firestore documents | `FirestoreService` |
| Calls an existing `onCall` Firebase Cloud Function | `IFirebaseFunctionsService` / `httpsCallable` |
| Calls an `onRequest` Firebase Cloud Function (raw HTTP) OR needs streaming (SSE) | `@Named('BizzieDio')` Dio instance |

To determine if the backend function is `onRequest` or `onCall`, check `src/features/<feature>/trigger.ts` in `YannicAmir/bizzie_function_app` — `onRequest` = raw HTTP, `onCall` = callable.

When planning a `@Named('BizzieDio')` datasource:
- Note whether the endpoint supports streaming (`stream: true` request field / `text/event-stream` response)
- Plan an SSE event DTO as a `sealed class` (not `@freezed`) if streaming is required
- Plan `Failure.rateLimit` mapping if the endpoint can return HTTP 429
- Plan `AppEnv` base URL field addition (e.g. `bizzieChatBaseUrl`) if no Bizzie Dio URL for this feature exists yet
- Reference implementation: `lib/features/bizzie_chat/data/`

### For new Firestore remote datasources
Read the existing feature's `data/datasources/` to understand:
- Existing `FirestoreService` method usage patterns
- Whether an interface already exists in `data/interfaces/`

Read `lib/services/firestore_service.dart` to understand:
- Available `FirestoreService` methods (setDocument, deleteDocument, getCollectionStream, getDocumentStream, getCollectionStreamChunked)

### For new local datasources
Read the existing feature's `data/interfaces/` to understand:
- Pattern for local datasource interfaces
- Whether `ILocalStorageService` or direct `SharedPreferences` is used

### For new DTOs
Read existing DTOs in `data/dtos/` to understand:
- `@freezed` + `json_serializable` conventions
- `fromDomain()` / `toDomain()` conversion patterns
- `@TimestampConverter()` usage for Firestore timestamps

### For new repository implementations
Read the domain interface (`domain/interfaces/IXxxRepository`) to understand:
- All methods that must be implemented
- Expected return types (`Either<Failure, T>` or `Stream<Either<Failure, T>>`)

### For updates to existing code
Read all files in scope before proposing changes.

---

## Plan Format

Every implementation plan must contain:

### Overview
A one-paragraph summary: what is being built or changed and in which file(s).

### New Files (builds only)
List any new files to be created with their paths.

### Modified Files
List all existing files to be modified with the specific changes required in each.

### Implementation Steps
Numbered, sequenced steps. Each step specifies:
- The target file path
- The exact change (e.g. "create `XxxDto` with `@freezed`, fields: `id`, `name`, `createdAt` with `@TimestampConverter()`", "create `XxxRemoteDataSource` annotated `@Injectable(as: IXxxRemoteDataSource)` with method `getXxxStream(String uid)` using `_firestoreService.getCollectionStream`")
- Any dependency on preceding steps (DTOs must exist before datasources, interfaces before implementations)

### Injectable Annotations
For every new class, specify the correct annotation:
- `@Injectable(as: IXxx)` — datasource implementations
- `@LazySingleton(as: IXxx)` — repository implementations
- `@lazySingleton` — other singletons with no interface

### build_runner Required
Explicitly state: yes (if any `@freezed` DTO or domain model is added/modified) or no.

---

## Sequencing Rules

Always plan in this order:
1. DTO (if new)
2. Datasource interface in `data/interfaces/` (if new)
3. Datasource implementation(s) in `data/datasources/`
4. Repository implementation in `data/repositories/`

The domain interface (`IXxxRepository`) must already exist or be planned as a domain layer task separately.

---

## Delegation Decision

After producing the plan:
- **New data layer code** (file, class, or method does not yet exist) → **DataBuilder**
- **Modifying existing data layer code** → **DataUpdater**

Delegate immediately after the plan is complete. Do not wait for user confirmation.

---

## Checklist
- [ ] If new feature: backend feature looked up in `YannicAmir/bizzie_function_app` via GitHub MCP before planning; if feature name was unclear, user was asked first
- [ ] Transport type determined: FirestoreService / httpsCallable / BizzieDio — based on `trigger.ts` in backend repo
- [ ] Target context confirmed and relevant files read before planning
- [ ] Plan contains: Overview, New/Modified Files, sequenced Implementation Steps, injectable annotations, build_runner decision
- [ ] Firestore access planned via `FirestoreService` — not `FirebaseFirestore.instance` directly
- [ ] Raw HTTP/SSE datasources planned to use `@Named('BizzieDio')` — not `httpsCallable`
- [ ] Raw HTTP base URL planned as new `RemoteConfigKeys` entry + `IConfigService` getter — never as `AppEnv`/envied field
- [ ] DioException mapping planned via `FunctionAppErrorMapper.map(e, s, context)` — not an inline per-feature switch
- [ ] If SSE streaming: SSE event DTO planned as `sealed class`, stream method in datasource returns `Stream<SseEventDto>`, repository yields `Stream<Either<Failure, DomainEvent>>`
- [ ] DTO planned with `@freezed`, `fromJson`, `fromDomain()`, `toDomain()`
- [ ] If 429 response possible: `Failure.rateLimit` mapping planned in repository
- [ ] Repository implementation planned to return `Either<Failure, T>` for all fallible operations
- [ ] Correct injectable annotations planned for each class
- [ ] Steps in correct sequence (DTO → interface → datasource → repository)
- [ ] Delegated to DataBuilder or DataUpdater immediately after plan completion
