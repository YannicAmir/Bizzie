---
name: webview updater instructions
description: Rules and procedures for the WebViewUpdater agent when modifying or extending existing Flutter WebView pages from a plan produced by WebViewPlanner.
---

# WebView Updater Instructions

## Purpose
The WebViewUpdater modifies or extends existing Flutter WebView pages using a structured plan from **WebViewPlanner**. It changes only what the plan specifies, preserves all existing behaviour, and does not introduce violations.

---

## Required Inputs

The following must be provided by WebViewPlanner. If missing, stop and request them:

1. **Implementation plan** -- the structured plan (Overview, Modified Files, Implementation Steps)
2. **Target context** -- the feature directory

---

## Pre-update Discovery

Before making any changes:
- Read each file listed in the plan's Modified Files section
- Understand the current structure of each webview page being modified
- Confirm the plan's steps are consistent with the current code state
- If a plan step is already implemented, skip it and note the skip

---

## Implementation Checklist

Execute plan steps in order. For each modification, verify:

### Adding custom URL interception
- [ ] `WebViewInterceptHandler` subclass created (not inline if/else logic)
- [ ] Subclass placed in the feature directory
- [ ] Instance passed via `WrappedWebViewPage(interceptHandler: ...)`
- [ ] Previous interception behaviour (if any) preserved unless the plan explicitly changes it

### Adding custom JS message handling
- [ ] `JsMessageHandler` subclass created with `super.handleMessage(...)` fallback
- [ ] Handles only the `eventType` values specified in the plan
- [ ] Existing message handling behaviour preserved

### Structural changes (e.g., converting direct prop usage to `fromRouter`)
- [ ] Route entry updated with `MaterialPage(key: ValueKey(state.uri.toString()))`
- [ ] All URL and title values correctly mapped to query params
- [ ] Page behaviour identical before and after the structural change

---

## Scope Rules
- Change only files and props listed in the plan
- Do not fix unrelated violations discovered while reading the files (note them at the end instead)
- Do not change existing URL values or callback behaviour unless the plan explicitly specifies otherwise

---

## Forbidden Patterns
- Do not instantiate `TKMaxxWebView` directly
- Do not hardcode URLs in widgets
- Do not add URL interception logic inline in the widget
- Do not inject auth tokens or call `WebViewCleaner` from feature code

---

## Checklist
- [ ] All Modified Files read before any changes made
- [ ] Plan steps consistent with current code state -- pre-implemented steps skipped and noted
- [ ] Steps executed in plan order
- [ ] Only files listed in the plan modified
- [ ] Existing behaviour (URL, callbacks) preserved unless plan specifies otherwise
- [ ] No forbidden patterns introduced
- [ ] If secondary violations discovered: noted at end of response, not fixed
