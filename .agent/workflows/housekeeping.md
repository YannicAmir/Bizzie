---
description: Scans and refactors code to enforce strict theme usage (AppTheme, AppColors, AppTextStyles)
---
# Housekeeping Agent

**Role:** You are the **Design System Enforcer**.
**Objective:** Ensure that all UI code strictly follows the `lib/app/themes` definitions. You replace hardcoded values with their semantic equivalents from `ThemeData`, `AppColors`, or `AppTextStyles`.

**Context:**
*   **Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-guide.md) for details and strictly follow the technologies listed there.
*   **Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-guide.md) for detailed breakdown of the architecture and strictly follow the architecture detailed there.
*   **Adherence:** Strictly adhere to the rules outlined in [Housekeeping Rules](../rules/housekeeping-rules.md).

## Prerequisites
*   None. Can be run on any file or feature.

## Workflow Steps

1.  **Analyze Input:**
    *   Read the target file(s) provided by the user.
    *   Identify any instances of:
        *   Hardcoded colors (e.g., `Colors.blue`, `Color(0xFF...)`).
        *   Inline `TextStyle` (e.g., `TextStyle(fontSize: ...)`).
        *   Direct use of `AppColors` or `AppTextStyles` where `Theme.of(context)` would be more appropriate.
        *   Style implementations that *should* be in `ThemeData` in `lib/app/themes/app_theme.dart` but are missing.
        *   **NEW:** Functions returning Widgets (e.g., `Widget _buildRow() { ... }`).

2.  **Theme Expansion (If Needed):**
    *   If a missing theme property is identified (e.g., a specific button style or text variation that is hardcoded):
    *   **Modify** `lib/app/themes/app_theme.dart` to include this new property (e.g., in `ColorScheme`, `TextTheme`, or specific component themes).
    *   Ensure strict naming conventions (camelCase, semantic naming).

3.  **Refactor:**
    *   **Colors:** Replace hardcoded colors with `AppColors.constants` or `Theme.of(context).colorScheme.constant`.
    *   **TextStyles:** Replace inline styles with `AppTextStyles.constant` or `Theme.of(context).textTheme.constant`.
    *   **New Theme Props:** Immediately use the newly added theme properties from Step 2.
    *   **Best Practices:** Convert helper methods returning Widgets into standalone Widget classes.
        *   **CRITICAL:** Do NOT change any logic. Simply extract the widget structure.
    *   **Cleanup:** Remove unused imports.

4.  **Verify:**
    *   Run `flutter analyze [file]` if possible or visually check that no new errors are introduced.
    *   Ensure the code looks clean and consistent.

5.  **Final Report:**
    *   Summarize changes made (e.g., "Replaced 3 hardcoded colors. Extracted 2 helper methods to widgets").
