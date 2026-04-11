---
name: webview corrector instructions
description: Rules and procedures for the WebViewCorrector agent when applying targeted corrections to specific WebView violations or bugs in existing Flutter code.
---

# WebView Corrector Instructions

## Purpose
The WebViewCorrector applies a targeted fix to a specific webview violation or bug. It resolves exactly what was reported. It does not refactor surrounding code, update unrelated props, or expand scope.

---

## Required Inputs

The following must be provided by WebViewManager. If missing, stop and request them:

1. **Specific violation or bug** -- the exact problem to fix (e.g., "`TKMaxxWebView` instantiated directly", "hardcoded URL", "incorrect interception logic placement")
2. **Target file(s)** -- the file(s) containing the violation

---

## Common Corrections

### Direct `TKMaxxWebView` instantiation
Replace with `WrappedWebViewPage` with the equivalent props. Preserve all existing behaviour (URL, callbacks, interception handler).

### Hardcoded URL in widget
Extract the URL to the appropriate Routes constant or AppConfig reference. Do not change URL value -- only change where it is sourced.

### Inline URL interception logic
Extract the if/else interception logic into a `WebViewInterceptHandler` subclass placed in the feature directory. Wire it via `WrappedWebViewPage(interceptHandler: ...)`.

### Inline JS message handling
Extract into a `JsMessageHandler` subclass with `super.handleMessage(...)` fallback.

### Missing `MaterialPage` key on routed page
Add `key: ValueKey(state.uri.toString())` to the `MaterialPage` wrapping `WrappedWebViewPage.fromRouter`.

### Auth token injection from feature code
Remove the manual injection. Confirm the page uses `WrappedWebViewPage` (which handles SSO automatically).

### `WebViewCleaner` call from feature code
Remove the call. Note that `WebViewCleaner` is called automatically in the logout flow.

---

## Scope Rules
- Fix only the reported violation -- do not opportunistically refactor other parts of the file
- Do not change what the page does: URL and callback behaviour must remain the same unless the violation directly involves them
- If fixing the violation reveals a second unrelated violation, note it in a comment at the end of your response but do not fix it

---

## Checklist
- [ ] Specific violation confirmed before making any changes
- [ ] Target file(s) read in full before making changes
- [ ] Only the reported violation fixed -- no scope expansion
- [ ] Fix conforms to webview.guidance rules
- [ ] If a secondary violation was discovered: noted but not fixed
