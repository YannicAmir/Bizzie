---
name: test builder instructions
description: Rules and procedures for the TestBuilder agent when writing new Flutter BLoC and repository test files from a plan produced by TestPlanner.
---

# Test Builder Instructions

## Purpose
The TestBuilder writes new Flutter test files from scratch based on a structured plan from **TestPlanner**. It follows the plan step by step, ensuring every test conforms to project conventions. **TestRunner is always invoked as the final step.**

---

## Required Inputs

The following must be provided by TestPlanner. If missing, stop and request them:

1. **Test plan** — the structured plan (Overview, Test File Path, Mocks Required, Fallback Values, Fake Data, Test Scenarios)
2. **Implementation files** — the files being tested

---

## Implementation Checklist

For every new test file written, verify:

### File placement
- [ ] Test file placed at the exact mirror path: `lib/features/<feature>/...` → `test/features/<feature>/...`
- [ ] File named `<subject>_test.dart`

### Imports and structure
- [ ] `package:flutter_test/flutter_test.dart` and `package:bloc_test/bloc_test.dart` imported
- [ ] `package:mocktail/mocktail.dart` imported — **never `mockito`**
- [ ] Top-level `group()` by class name
- [ ] Nested `group()` by method, event, or scenario where applicable
- [ ] Mock classes declared at the **top of the file**, **public**, and named `MockXxx`:
  ```dart
  class MockXxxUseCase extends Mock implements XxxUseCase {}
  ```
- [ ] Fake data constants declared at the top, `const` where possible, with **`t` prefix**:
  ```dart
  const tCompany = Company(id: 'test-id', name: 'Test Co');
  const tFailure = Failure.server(message: 'error');
  ```

### BLoC test setup
- [ ] `setUpAll(() { registerFallbackValue(...); })` present for any type used with `any()` matchers
- [ ] BLoC instance created in `setUp` using constructor injection with mocks
- [ ] `tearDown(() => bloc.close())` present

### Every `test()` body
- [ ] `// arrange`, `// act`, `// assert` comments present
- [ ] Both success and failure paths present for every method under test

### Every `blocTest<XxxBloc, XxxState>` body
- [ ] `build:` constructs the BLoC with injected mocks
- [ ] `act: (bloc) => bloc.add(XxxEvent.xxx(...))` used — not direct method calls
- [ ] `expect:` lists the **full emitted state sequence** including intermediate states (e.g., loading before loaded)
- [ ] `verify:` used when mock interaction count matters
- [ ] `setUp:` stub is inside `blocTest` body when stubs differ per test

### Repository / use case tests
- [ ] Plain `test()` calls
- [ ] Subject variable named after the class (e.g., `repository`, `useCase`) — **not `sut`**
- [ ] `when(...)` stubs set in `// arrange` section
- [ ] `Either` result folded or matched with `isRight()`/`isLeft()` matchers where applicable

---

## Approved Packages Only
Use only the packages listed in `test.guidance.instructions.md`. Do not introduce any additional test dependencies.

---

## Final Step — TestRunner
After all test files are written:
- Invoke **TestRunner** with the list of newly written test files and attempt number 1
- Do not consider the task complete until TestRunner has reported its outcome

---

## Checklist
- [ ] Plan steps executed in order
- [ ] All test files placed at correct mirror paths under `test/`
- [ ] Mock classes are public `MockXxx extends Mock implements IXxx`
- [ ] Fake data uses `t` prefix constants
- [ ] `setUpAll` + `registerFallbackValue` present in BLoC test files
- [ ] `tearDown(() => bloc.close())` present in BLoC test files
- [ ] `blocTest` uses `act: (bloc) => bloc.add(...)` not direct method calls
- [ ] `expect:` lists full state sequence including loading/intermediate states
- [ ] AAA comments present in every test body
- [ ] Both success and failure cases written for every feature
- [ ] Only approved packages used — never `mockito`, never `GetIt.I()` for SUT injection
- [ ] TestRunner invoked as final step
