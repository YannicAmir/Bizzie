---
trigger: manual
---

# UI Coding Rules

> [!CRITICAL]
> **Logic-First Dependency**
> You CANNOT build the UI for a feature until its "Brain" (Business Logic & State) has been created.

## Init

## Asset Coordination (Handshake)
Before generating code involving images or custom icons, you must:
1.  **Check for Assets:** Ask the user if the assets (images/icons) are already added to the project.
2.  **Redirect to AssetOps:** If they are not added, strictly instruct the user to provide them to [AssetOps](add-feature-assets.md) first.
    * **Exception:** If the user explicitly asks for placeholders, you may use `Placeholder()` widgets or standard `Icons`.

## Analyze & Scaffold
* **Architecture Compliance:** You must STRICTLY follow the folder structure rules defined in [Architecture Guide](../rules/architecture-guide.md).
* Plan the file structure within `lib/features/[feature]/presentation/`:
    * `views/`: The full screen scaffold (e.g., `login_page.dart`).
    * `widgets/`: Smaller, extracted components (e.g., `login_form.dart`).

## View Implementation (Direct Write)
* **Write Files:** You are running in an Agentic IDE. **Create and write the files directly** to the `lib/` directory.
* **State Integration:** Wrap the body in `BlocBuilder` or `BlocConsumer` connecting to the existing BLoC.
* **Routing & Interactions:** Implement the user's specific routing instructions using `go_router` (e.g. `context.push`, `context.go`). Ensure buttons trigger the correct BLoC events.
* **Strict Styling:** Ensure all implementations match the design tokens and asset usages exactly.
* **Component Extraction:** Break down complex UIs into smaller widgets.
    * **Shared:** If reusable, place in `widgets/` or `shared/`.
    * **Private:** If a widget section is **10 lines or more** and specific to the current page (not reused), extract it into a private class (`_MyWidget`) at the bottom of the same file. This keeps the build method clean and readability high without polluting the file system.

## Design Rules:
* **Framework:** Use Flutter (Platform Agnostic / Standard Material Widgets). Avoid platform-specific branching (Cupertino) for simplicity unless explicitly requested.
* **Styling:**
    * **Strictly Enforced:** Use `Theme.of(context)` for all styles.
    * **Strictly Enforced:** Use `AppColors` from `app/themes/app_colors.dart`.
    * **Strictly Enforced:** Use `AppTextStyles` from `app/themes/app_text_styles.dart` for all typography. Do NOT use `GoogleFonts` or `TextStyle` directly in widgets.
    * **Strictly Enforced:** Access colors via `Theme.of(context).colorScheme` in widgets where possible.
    * **Strictly Enforced:** For any widget supported by `ThemeData` (e.g., `AppBar`, `ElevatedButton`, `InputDecoration`), you MUST rely on the global theme defined in `AppTheme`. Do NOT explicitly set properties (like `backgroundColor`, `elevation`) locally unless they DEVIATE from the global theme for a specific design reason.
    * **Forbidden:** Do NOT use hardcoded colors (e.g., `Colors.blue`) or inline text styles.
* **Asset Path Standard:** Use `AppAssets` from `app/themes/app_assets.dart`. NEVER hardcode asset strings.
* **Validation Standard:** Use `Validators` from `shared/utils/validators.dart` for any form input validation.

## Asset Compliance Rules:
* **Strict Design Adherence**
* When a design file (Figma) or screenshot is provided:
  1.  **Exact Matching:** You must strictly follow the provided design. Deviating from alignment, placement, spacing, or typography is **Forbidden**.
  2.  **Typography:** Retrieve and implement exact properties (Family, Size, Weight, Line Height, Letter Spacing) from the design. "Almost bold" or "default size" is unacceptable.
  3.  **Colors:** Use the **exact hex codes** from the design. If they differ from `AppColors`, update `AppColors` first. Do not approximate (e.g., using `Colors.blue` vs `#155DFC`).
  4.  **Dimensions & Layout:** Use **exact pixel values** for Padding, Gaps, Heights, and Border Radii. Do not round loosely (e.g., 58px height, 16px radius).
  5.  **Asset Priority:** If the user provides specific assets (icons, images) or if they appear in the Figma design (e.g., a specific SVG icon), you MUST use the asset. **NEVER** substitute with native Flutter icons (e.g., `Icons.email`) if a custom asset is available or implied by the design.
  6.  **Pixel Perfection:** Pay close attention to padding, margins, and exact positioning. "Close enough" is not acceptable.

> [!CAUTION]
> **Pre-Submission Checklist**
> Before confirming your work, verify:
> * [ ] Did I extract the exact Font Family, Size, Weight, and Letter Spacing?
> * [ ] Did I use the exact Hex Code for all text and backgrounds?
> * [ ] Did I match the specific Element Heights and Border Radii?
> * [ ] Did I calculate the exact spacing gaps (no guessing)?
> * [ ] If any Answer is "No", **STOP** and correct it.

## Response Constraints:
* **No Logic:** Do not write business logic inside the UI. Delegate to the BLoC.
* **No Tests:** Do not write tests. Testing is handled by the **TestGuardian** agent.
* **Direct Execution:** Create the files on the file system.
* **Final Handoff:** End your response with this standard footer:
    > "I have built the UI and triggered DepOps. Please visually verify the screen in the simulator.
    >
    > * **Looks good?** You can run **TestGuardian** now to lock it in with tests.
    > * **Not ready?** You can refine the design or run tests later."