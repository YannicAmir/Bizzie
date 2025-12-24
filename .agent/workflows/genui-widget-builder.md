---
description: Create GenUI widgets from design and loose inputs
---
# GenUI Widget Builder Agent

**Role:** GenUI Widget Specialist
**Objective:** Create production-ready GenUI widgets (Catalog Items or Custom) from user descriptions, images, or Figma links.

**Context:**
* **Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-guide.md) for details and strictly follow the technologies listed there.
* **Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-guide.md) for detailed breakdown of the architecture and strictly follow the architecture detailed there.
* **Adherence:** Strictly adhere to the rules outlined in [GenUI Widget Builder Rules](../rules/genui-widget-builder-rules.md).

## Prerequisites
* [Project Setup](general-project-setup.md) (Implicit, assumed project exists)

## Workflow Steps
1.  **Validation:** Verify that `genui` is added to `pubspec.yaml`.
2.  **Analysis:**
    *   Read the user's input (Text Description, Image Screenshot, or Figma Link).
    *   **Analyze the design:** Identify UI elements, layout, and likely data requirements.
    *   **Analyze behavior:** Identify interactions (clicks, inputs, animations).
    *   **Decision Point:** Is this a **Standard Catalog Item** (reusable) or a **Custom Widget** (one-off/complex)?
3.  **Schema Definition:**
    *   Based on analysis, propose a JSON Schema for the data this widget will consume.
    *   *Self-Correction:* If the design implies data not explicitly mentioned (e.g., a "User Profile" card implies `name`, `avatarUrl`, `bio`), INFER it and add it to the schema.
    *   *Confirm:* If highly ambiguous, ask user to confirm the schema.
4.  **Code Generation:**
    *   **Step A: Widget Code:** Generate the Flutter Widget.
        *   Use `genui` patterns if binding to `DataModel` is required.
        *   Follow `Bizzie` styling (AppTheme, AppTextStyles).
    *   **Step B: Data Integration:**
        *   **If Catalog Item:** Generate the `CatalogItem` definition code.
        *   **If Custom Widget:** Generate the JSON Schema as a constant or file, and comments on how to inject data.
5.  **Manual Handoff:**
    *   Tell the user where the file was saved.
    *   If a Catalog Item, remind them to register it in their Catalog registry.
    *   If a Custom Widget, explain how to instantiate it with the schema.

## Final Handoff
*   Inform the user: "I have created the GenUI widget `[Widget Name]`. You can find it at `[Path]`. [Add specific instructions for registration/usage]."
