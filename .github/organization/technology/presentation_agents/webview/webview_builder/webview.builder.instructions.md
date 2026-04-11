---
name: webview builder instructions
description: Rules and procedures for the WebViewBuilder agent when implementing new Flutter WebView pages from a plan produced by WebViewPlanner.
---

# WebView Builder Instructions

## Purpose
The WebViewBuilder creates new Flutter WebView pages from scratch based on a structured plan from **WebViewPlanner**. It follows the plan step by step, ensuring every implementation conforms to the webview architecture rules.

---

## Required Inputs

The following must be provided by WebViewPlanner. If missing, stop and request them:

1. **Implementation plan** -- the structured plan (Overview, New Files, Implementation Steps, etc.)
2. **Target context** -- the feature directory

---

## Implementation Checklist

Execute the plan in step order. For every new webview page, verify:

### WrappedWebViewPage widget
- [ ] Uses `WrappedWebViewPage` -- not `TKMaxxWebView` directly
- [ ] `url` sourced from Routes constants or AppConfig -- not hardcoded
- [ ] `forceLoad`, `handleScreenView`, `onPageFinished` set only if the plan specifies them

### Route entry
- [ ] Added to the appropriate `router.dart`
- [ ] Uses `MaterialPage(key: ValueKey(state.uri.toString()))` when using `fromRouter`
- [ ] Uses `WrappedWebViewPage.fromRouter(context, state)` for route-based pages

### Custom WebViewInterceptHandler (if planned)
- [ ] Subclass created in the correct location (feature or shared webview directory)
- [ ] Subclass overrides only `shouldHandleDeeplink` and/or `handleRouting`
- [ ] No URL interception `if/else` logic inside the page widget itself
- [ ] Instance passed to `WrappedWebViewPage(interceptHandler: ...)`

### Custom JsMessageHandler (if planned)
- [ ] Subclass created and calls `super.handleMessage(...)` as fallback
- [ ] Handles only the `eventType` values specified in the plan
- [ ] No inline JS message parsing outside the handler subclass

---

## Forbidden Patterns
- Do not instantiate `TKMaxxWebView` directly from feature code
- Do not hardcode URLs in widgets -- always use Routes constants + AppConfig
- Do not inject auth tokens or call `SsoCubit` methods from feature code
- Do not call `WebViewCleaner` from feature code
- Do not add URL interception logic inline in the widget

---

## Checklist
- [ ] Plan steps executed in order
- [ ] `WrappedWebViewPage` used with all required props
- [ ] URL sourced from constants -- not hardcoded
- [ ] Custom interception and JS handlers implemented as subclasses, not inline
- [ ] No forbidden patterns used
