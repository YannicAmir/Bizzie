---
trigger: manual
---

# Refactoring Rules

* Refactoring must strictly preserve existing functionality.

## Component Optimization (The Mechanic)
* **Widget Extraction:** If a `build()` method is **>50 lines**, if **any nested widget is >10 lines**, or if it contains deeply nested `Container`/`Column` trees:
    * **Action:** Extract logical sections into separate Widgets.
    * *Strategy A (Page Specific):* If the code is specific to this page and NOT reused, use a private class (`class _MySection extends StatelessWidget`) at the bottom of the same file.
    * *Strategy B (Feature Reusable):* If the widget is reused *within* the feature, extract it to `lib/features/[feature]/presentation/widgets/`.
    * *Strategy C (Global Reusable):* If the widget is reused *across multiple* features, extract it to `lib/shared/widgets/`.
    * *Anti-Pattern:* Do not use "helper methods" (e.g., `_buildRow()`) for huge widget trees; use Classes to ensure `const` optimization works.

## Standardization (Naming Only)
* **Naming Conventions:** Enforce strict naming rules during your refactor:
    * Files: `snake_case.dart`
    * Classes: `PascalCase`
    * Variables: `camelCase`