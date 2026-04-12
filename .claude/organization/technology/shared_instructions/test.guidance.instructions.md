---
name: test guidance
description: Rules and conventions for writing Flutter tests in this project. Covers approved packages, file structure mirroring lib/, AAA comments, BLoC tests with blocTest, repository tests, analytics tracker tests, mock naming, fake data conventions, test naming, and forbidden patterns. Referenced by TestPlanner, TestBuilder, TestUpdater, TestCorrector, and TestRunner.
---

# Test Guidance

---

## 1. Approved Test Packages

```yaml
dev_dependencies:
  flutter_test: { sdk: flutter }
  mocktail: ^1.0.4
  bloc_test: ^10.0.0
  fake_cloud_firestore: ^3.0.0
  fake_async: ^1.3.1
```

Do **not** use: `mockito`, `http_mock_adapter`, golden test libraries.

---

## 2. File Structure

Mirror the `lib/` path under `test/` exactly:
- `lib/features/<f>/data/repositories/x_impl.dart` → `test/features/<f>/data/repositories/x_impl_test.dart`
- `lib/features/<f>/domain/usecases/x_usecase.dart` → `test/features/<f>/domain/usecases/x_usecase_test.dart`
- `lib/features/<f>/presentation/bloc/x_bloc.dart` → `test/features/<f>/presentation/bloc/x_bloc_test.dart`
- `lib/features/<f>/presentation/analytics/x_tracker.dart` → `test/features/<f>/presentation/analytics/x_tracker_test.dart`

---

## 3. Conventions

- **AAA comments**: Every `test()` body requires `// arrange`, `// act`, `// assert`.
- **Both paths required**: Every feature must have at least one success and one failure test.
- **SUT variable**: Assign the subject under test to `sut`.
- **`group()` structure**: Top-level = class name; nested = method or scenario.
- **Test naming**: `[methodOrEvent]_[scenario]_[expectedBehavior]` in camelCase — e.g. `addXxx_datasourceThrows_returnsLeftServerFailure`.
- **Mock naming**: Public class at top of file — `class MockXxxUseCase extends Mock implements XxxUseCase {}`.
- **Fake data**: Top-level constants prefixed with `t` (e.g. `tItem`, `tFailure`), local to the test file, `const` where possible.
- **`setUpAll`**: Register all `registerFallbackValue` entries here before BLoC tests.
- **`tearDown`**: `tearDown(() => bloc.close())` required in every BLoC test group.

---

## 4. Repository / Datasource Tests

Use plain `test()` calls. Construct via constructor injection with mock dependencies.

Key pattern:
```dart
class MockXxxRemoteDataSource extends Mock implements IXxxRemoteDataSource {}
const tItem = XxxDomainModel(id: '1', name: 'Test');

setUp(() { sut = XxxRepositoryImpl(mockRemoteDataSource); });

test('addXxx_success_returnsRightVoid', () async {
  // arrange
  when(() => mockRemoteDataSource.addXxx(any(), any())).thenAnswer((_) async {});
  // act
  final result = await sut.addXxx(tItem, 'uid123');
  // assert
  expect(result, const Right(null));
});
```

Test both: (a) success → `Right`, (b) datasource throws → `Left(Failure.server(...))`.

---

## 5. UseCase Tests

Same pattern as repository tests. Mock the repository interface; test that `call()` delegates correctly.

Test both: (a) repository returns `Right` → use case returns `Right`, (b) repository returns `Left` → use case returns `Left`.

---

## 6. BLoC Tests

Use `blocTest<XxxBloc, XxxState>` from `bloc_test`.

```dart
setUpAll(() { registerFallbackValue(const AddXxxParams(id: '', uid: '')); });

setUp(() { bloc = XxxBloc(mockUseCase, mockTracker); });

tearDown(() => bloc.close());

blocTest<XxxBloc, XxxState>(
  'addRequested_useCaseSucceeds_emitsNoStateAndLogsAnalytics',
  build: () { when(() => mockUseCase(any())).thenAnswer((_) async => const Right(null)); return bloc; },
  act: (bloc) => bloc.add(const XxxEvent.addRequested(id: '1')),
  expect: () => [],
  verify: (_) { verify(() => mockTracker.logItemAdded(id: '1')).called(1); },
);
```

| Parameter | Purpose |
|-----------|---------|
| `build` | Constructs BLoC with mocks; set per-test stubs here |
| `seed` | Optional initial state for non-initial starting conditions |
| `act` | Adds events via `bloc.add(XxxEvent.xxx(...))` |
| `expect` | Full emitted state sequence including loading/intermediate states |
| `verify` | Checks mock interactions after all emissions |

Always test: (a) success path with full state sequence, (b) failure path emitting `XxxState.failure(...)`.

---

## 7. Analytics Tracker Tests

Mock `IAnalyticsService`. Construct the tracker via constructor injection. Verify that the correct event name string is passed to `mockAnalytics.logEvent(name: ...)`.

---

## 8. Forbidden Patterns

- Do **not** use `mockito` — use `mocktail` only
- Do **not** skip the failure case — it is mandatory
- Do **not** use `GetIt.I<X>()` to obtain the SUT — constructor injection only
- Do **not** assert `isA<SomeState>()` when the exact state value can be asserted
- Do **not** share fake data via imports from other test files

---

## Checklist
- [ ] Only approved packages used
- [ ] Test file mirrors `lib/` path under `test/`
- [ ] Top-level `group()` by class; nested by method/scenario
- [ ] Test names follow `[method]_[scenario]_[expectedBehavior]`
- [ ] Every `test()` body has `// arrange`, `// act`, `// assert` comments
- [ ] Both success and failure paths covered for every feature
- [ ] SUT assigned to `sut`
- [ ] `setUpAll` registers all `registerFallbackValue` entries before BLoC tests
- [ ] Mock classes declared publicly as `class MockXxx extends Mock implements Xxx {}`
- [ ] Fake data prefixed `t`, locally scoped, `const` where possible
- [ ] BLoC tests use `blocTest<XxxBloc, XxxState>` with `act: (bloc) => bloc.add(...)`
- [ ] `expect:` lists the full emitted state sequence including loading/intermediate states
- [ ] `tearDown(() => bloc.close())` present in BLoC test groups
- [ ] No `GetIt.I()` to obtain SUT — constructor injection only
