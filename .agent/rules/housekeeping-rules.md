---
trigger: manual
description: Apply when running the housekeeping agent or refactoring UI execution
---

# Housekeeping Rules

These rules ensure strict adherence to the Bizzie Design System (`AppTheme`, `AppColors`, `AppTextStyles`) and Flutter Best Practices.

## 1. Hierarchy of Usage
When styling any UI element, you **MUST** attempt to use sources in this order:

1.  **Theme Data (`Theme.of(context)`)**:
    *   Prioritize semantic properties from the global theme.
    *   Example: Use `Theme.of(context).textTheme.bodyLarge` instead of `AppTextStyles.bodyLarge`.
    *   Example: Use `Theme.of(context).colorScheme.primary` instead of `AppColors.primary`.
2.  **App Constants (`AppColors`, `AppTextStyles`)**:
    *   If the specific style is not correctly mapped to `ThemeData` or semantic usage is unclear, fall back to the direct constant.
    *   Example: `AppColors.mascotSubtitle` (likely not in standard color scheme).

## 2. Missing Theme Data
If you encounter a hardcoded style that *should* be part of the global theme but isn't:
1.  **Modification**: You are authorized to modify `lib/app/themes/app_theme.dart`.
2.  **Implementation**: Add the missing color or text style to the `ThemeData` definition (e.g., adding a custom extension or mapping it to an existing unused slot if appropriate, or just adding it to the relevant `ColorScheme` or `TextTheme` copyWith).
3.  **Usage**: Immediately reference this new theme property in the target file.

## 3. Strict Prohibitions
*   **NO Hardcoded Colors**: usages of `Color(0xFF...)`, `Colors.red`, or `Colors.white` (unless strictly temporary debugging) are forbidden in production code. Use `AppColors` or `ColorScheme`.
*   **NO Inline TextStyles**: usages of `TextStyle(fontSize: 20, fontWeight: ...)` are forbidden. Define a new style in `AppTextStyles` if it is a potentially reusable variant, or usage `copyWith` on an existing `AppTextStyle` for one-off overrides (e.g. changing color of a standard style).

## 4. Flutter Best Practices (UI Structure)
*   **NO Helper Functions for Widgets**: Do not use helper methods (e.g. `_buildButton()`) to return Widgets.
    *   **Refactor**: Extract them into separate stateless or stateful widgets (e.g. `MyButton`).
    *   **Reason**: Helper functions do not have their own BuildContext, leading to unnecessary rebuilds and less performant code.

## 5. Flutter Best Practices (Logic Placement)
*   **NO Non-Lifecycle Logic in Widgets**: Widgets should only contain code related to:
    *   Variables (final fields).
    *   Constructor.
    *   Lifecycle methods: `initState`, `dispose`, `didUpdateWidget`, `didChangeDependencies`.
    *   `build()`.
*   **Prohibited**: Arbitrary helper functions like `_calculateTotal()`, `_validateInput()`, or `_fetchData()` defined directly in the Widget class.
*   **Refactor Location**:
    *   **Complex Business Logic**: Move to the BLoC/Cubit/ViewModel.
    *   **UI Helpers/Formatters**: Move to a static utility class or extension method in `lib/features/[feature]/presentation/utils/` (create if missing).
    *   **Simple Logic**: If absolutely necessary, keep it short, private, and well-named, but prefer extraction.
*   **Preserve Logic**: You are **STRICTLY FORBIDDEN** from changing any business logic or behavior. Your goal is structural refactoring only.

## 6. Formatting
*   Maintain `snake_case` for filenames.
*   Ensure imports are correct (relative or package absolute).

# Logic Placement Rules
## 1. No Business or Presentation Logic in Widgets
*   **STRICTLY FORBIDDEN:** Do not define private helper methods in the Widget class that calculate derived state, format complex strings based on state, or determine UI logic (e.g., `_getTitle(step)`, `_calculateProgress()`).
*   **BEST PRACTICE:** Move this logic to the **BLoC State** as a getter.
    *   **Example (Bad):** `String _getTitle(int step) { ... }` in Widget.
    *   **Example (Good):** `String get title { ... }` in `MyState` class.
    *   **Usage:** `Text(state.title)` in Widget.
*   **EXCEPTION:** Very simple, pure UI helpers that depend *only* on `BuildContext` (like theme lookups) or formatting that is strictly view-specific and not state-dependent can remain in compliance with separation of concerns.
## 2. Widget Separation
*   **AVOID** `_buildHelper()` methods that return `Widget` if they are large.
*   **PREFER** extracting them into purely stateless `PrivateWidget` classes at the bottom of the file or in `widgets/` folder.
*   This improves performance (const constructors) and readability.
## 3. Strict State Enums
*   **STRICTLY FORBIDDEN:** Do not define private enums in Widgets to represent UI state if that state is derived from BLoC data (e.g., `enum _StepState`).
*   **STRICTLY FORBIDDEN:** Do not use logic in your Widget to map BLoC state to these private enums (e.g., `state.step == 1 ? _StepState.active : ...`).
*   **BEST PRACTICE:** Define the Enum in the State file (publicly) and add getters in the State class to return the correct enum value.
    *   **Example (Good):** `MyStepState get step1State => ...` inside `MyState` class.
    *   **Usage:** `MyWidget(state: state.step1State)` in Widget.

## 7. Optimization & Readability
*   **Theme Caching:** If `Theme.of(context)` is accessed **2 or more times** within a single build method, you MUST assign it to a local variable `final theme = Theme.of(context);` at the top of the method. This improves readability and prevents excessive lookups.