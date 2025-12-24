---
description: Apply when working on GenUI Widget Builder
trigger: manual
---
# GenUI Widget Builder Rules

## Constraints

*   **Naming Strictness:**
    *   File names must be `snake_case` (e.g., `my_custom_widget.dart`).
    *   Class names must be `PascalCase` (e.g., `MyCustomWidget`).
    *   Catalog Item names should be human-readable strings (e.g., 'My Custom Widget').

*   **Path Convention:**
    *   Place feature-specific widgets in: `lib/features/[feature_name]/presentation/widgets/`.
    *   Place shared widgets in: `lib/shared/widgets/genui/`.

*   **Data Handling:**
    *   Every widget MUST have a clearly defined data schema.
    *   For **Catalog Items**: This schema is part of the `CatalogItem` definition.
    *   For **Custom Widgets**: This schema must be provided as a JSON Schema structure referencing the required properties.

*   **GenUI Integration:**
    *   **Standard Catalog Items**: The output must include *both* the `Widget` class and the `CatalogItem` definition (or clear instructions on where/how to add the `CatalogItem` to the global catalog).
    *   **Custom Widgets**: The output must include the `Widget` class and a standalone JSON Schema definition for the data it expects. The widget should be written to accept this data (e.g., via a model class generated from the schema).

*   **Flexibility & Inference:**
    *   The agent must be able to infer missing details from "loose" inputs (e.g., "blue button" -> standard Button widget with blue color).
    *   **CRITICAL**: If the user provides a design (image/Figma) that implies complex behavior or data (e.g., "a list of users with active status"), the agent MUST infer the necessary data fields (e.g., `List<User>`, `bool isActive`) and propose them in the schema *before* writing code if there is significant ambiguity.

*   **Technology Stack:**
    *   Review `pubspec.yaml` to confirm `genui` and `genui_firebase_ai` versions.
    *   Use `flutter_bloc` if state management is needed within the widget (though GenUI widgets are often stateless or driven by `DataModel`).
