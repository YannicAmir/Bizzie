# Flutter Frontend Best Practices Guide

This guide outlines the production-grade standards for frontend development within the Bizzie application. Adherence to these rules ensures a scalable, maintainable, and high-performance codebase.

---

## 1. Widget Design Patterns

### **A. Prohibit Widget-Returning Functions**
> **CRITICAL:** **Never** create functions or methods that return a `Widget` (e.g., `Widget _buildHeader()`).

- **The Problem**: Functions are not part of the Widget tree. They do not have their own `BuildContext`, causing inefficient rebuilds and making debugging harder.
- **The Standard**: Always extract UI into a `StatelessWidget` or `StatefulWidget`. This allows Flutter to optimize rebuilds (rebuilding only the sub-tree) and provides better developer tools visibility.

### **B. Widget Extraction (Private vs Public)**
Follow these rules for managing file length and reusability:

1. **Private Widgets (`_MyWidget`)**:
   - **Trigger**: If a snippet of UI exceeds **10 lines** and is not reused elsewhere.
   - **Placement**: Place at the bottom of the same file as the parent view.
   - **Benefit**: Keeps the main `build` method clean and readable.

2. **Public Widgets**:
   - **Trigger**: If the widget is used in multiple views within the feature OR is intended for app-wide use.
   - **Placement**: 
     - Feature-specific: `lib/features/[feature]/presentation/widgets/`.
     - App-wide: `lib/shared/widgets/`.
   - **Standard**: Follow **DRY (Don't Repeat Yourself)**. If you see yourself duplicating a UI pattern, extract it into a public/shared widget immediately.

---

## 2. State Management (BLoC + Freezed)

### **A. State Pattern Matching**
Always use the `map` or `maybeMap` methods provided by `Freezed` for handling states in `BlocBuilder` or `BlocConsumer`.
```dart
state.map(
  initial: (_) => const InitialView(),
  loading: (_) => const BizzieLoader(),
  success: (data) => DataDisplay(data: data.result),
  failure: (err) => BizzieError(message: 'Error loading [feature name]'),
);
```
- **Why?** It ensures exhaustive checking of all possible states, preventing "silent" bugs when new states are added.

### **B. Logic Extraction**
- **No Logic in Widgets**: Widgets should be "dumb." They should only emit events to the BLoC and listen to state changes. 
- **Validation**: Use `Validators` from `shared/utils/validators.dart`. Do not write regex or validation logic inside the widget.

---

## 3. Styling & Design Tokens

### **A. Strict Token Usage**
> **WARNING:** Hardcoded values (Colors, Font Sizes, Spacing) are **Forbidden**.

- **Colors**: Use `Theme.of(context).colorScheme` or `AppColors.colorName`.
- **Typography**: Use `AppTextStyles` from `app/themes/app_text_styles.dart`. 
  - **Forbidden**: `TextStyle(fontSize: 16, ...)` or `GoogleFonts.inter(...)` inline.
- **Spacing**: Use standard pixel values from the Figma design as `SizedBox(height: 16)` or `Padding(padding: EdgeInsets.all(16))`.

### **B. Global vs Local Themes**
- **Default**: Rely on the global `AppTheme` for standard widgets (AppBar, Buttons, Inputs).
- **Deviation**: Only set properties locally if they explicitly deviate from the global design for a specific use case.

---

## 4. Performance & Clean Code

- **Const Constructors**: Use `const` everywhere possible to reduce widget rebuild overhead.
- **monolithic Build Methods**: If your `build` method exceeds 40 lines, it's a signal to extract widgets.
- **Lists**: Always use `ListView.builder` for lists with more than 10 items or items of unknown length to ensure memory efficiency.
- **Imports**: Avoid barrel file loops. Import directly from the source if circular dependencies arise.

---

## 5. Checklist for Production-Grade UI
- [ ] No functions return widgets.
- [ ] Complex components are extracted into private or public widgets.
- [ ] `Freezed` pattern matching is used for all BLoC states.
- [ ] No business logic exists in the Widget layer.
- [ ] All colors and text styles reference `AppColors` and `AppTextStyles`.
- [ ] Assets are accessed via `AppAssets`.
- [ ] Forms use the centralized `Validator` utility.
