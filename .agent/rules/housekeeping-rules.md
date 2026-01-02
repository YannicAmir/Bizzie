---
trigger: manual
description: Apply when running the housekeeping agent or refactoring UI execution
---
# Housekeeping Rules

These rules ensure strict adherence to the Bizzie Design System (`AppTheme`, `AppColors`, `AppTextStyles`).

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

## 4. Flutter Best Practices
*   **NO Helper Functions for Widgets**: Do not use helper methods (e.g. `_buildButton()`) to return Widgets.
    *   **Refactor**: Extract them into separate stateless or stateful widgets (e.g. `MyButton`).
    *   **Reason**: Helper functions do not have their own BuildContext, leading to unnecessary rebuilds and less performant code.
*   **Preserve Logic**: You are **STRICTLY FORBIDDEN** from changing any business logic or behavior. Your goal is structural refactoring and style enforcement only.

## 5. Formatting
*   Maintain `snake_case` for filenames.
*   Ensure imports are correct (relative or package absolute).
