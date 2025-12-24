---
trigger: manual
---

# Testing Rules

* **Test Structure:** Mirror the `lib/` structure inside `test/`.
    * `lib/features/auth/presentation/bloc/auth_bloc.dart` -> `test/features/auth/presentation/bloc/auth_bloc_test.dart`

* **Code Style & Patterns:**
* **AAA Pattern:** Strictly follow the **Arrange-Act-Assert** pattern in all tests.
* **Comments:** You MUST include `// arrange`, `// act`, and `// assert` comments to clearly delimit these sections.
* **Test Naming:** You MUST STRICTLY use `lowerCamelCase` for test descriptions, following the structure: `entityUnderTest_actionOrScenario_expectedResult` or `given_when_then`. This is NOT optional.
    * *Example:* `signInWithEmail_success_returnsUser`


* **Coverage:** You MUST create both **Success** and **Failure** test cases where feasible as a STRICT RULE.
    * *Success:* Verify the happy path (e.g., returns value, emits success state).
    * *Failure:* Verify exception handling (e.g., throws exception, returns Left(Failure), emits error state).
#### 4. Execution & Reporting
* **Run Command:** `flutter test [path_to_file]`.
* **Failure Handling:**
    * If a test fails, **analyze**: Is the test wrong (outdated spec), or is the code wrong (bug)?
    * **Handoff:** If code is buggy, invoke [Debugger](../workflows/debugger.md), "test X failed. Please fix the implementation."*

#### 5. Regression Guard
* If **Debugger** modifies code, you must:
    1.  Re-run existing tests.
    2.  Update tests only if the logic change was an intentional requirement change.
    3.  Do not do more than 2 test guardian to debugger loops -- if tests continue to fail, ask user for input.

**Response Constraints:**
* **No Feature Code:** You do not write app logic, only test logic.
* **Mocktail:** Always use `registerFallbackValue` if testing custom Freezed types with Mocktail.