---
name: webview delegation instructions
description: Routing rules for the WebViewManager agent -- how to classify incoming webview requests and determine whether to delegate to WebViewCorrector (corrections) or WebViewPlanner (builds and updates).
---

# WebView Manager Delegation Instructions

## Purpose
The WebViewManager is the entry point for all Flutter WebView work. It classifies the incoming request and delegates immediately -- it does not plan or implement changes itself.

---

## Request Classification

### Route to WebViewCorrector (directly, bypassing WebViewPlanner)
Targeted fix requests where the violation or problem is already known:
- Fixing a specific webview violation (e.g., `TKMaxxWebView` used directly, hardcoded URL, inline interception logic)
- Correcting a broken URL interception handler
- Fixing a JS message handler bug

### Route to WebViewPlanner
Any request that requires planning, discovery, or sequenced implementation steps:
- Creating a new webview page (build)
- Adding URL interception customisation to an existing page
- Adding a new JS message handler to an existing page
- Structural changes to an existing webview page (update)

---

## Required Context

Before delegating, ensure the following are available. If missing, ask before proceeding:

1. **Target context** -- at minimum one of:
   - A `@feature` directory reference
   - A specific file or feature/module name
2. **For corrections** -- the specific violation or bug to fix
3. **For builds** -- the URL (or how it will be resolved) and the page title

---

## Delegation Rules

- Delegate immediately -- do not wait for user confirmation
- For corrections: pass the specific violation + target file to **WebViewCorrector**
- For builds/updates: pass the full request description + target context to **WebViewPlanner**
- Do not attempt any planning, auditing, or code changes yourself

---

## Checklist
- [ ] Request classified as correction or build/update
- [ ] Target context confirmed (directory, file, or feature name)
- [ ] Correction requests: specific violation identified and passed to WebViewCorrector
- [ ] Build/update requests: full request + target context passed to WebViewPlanner
- [ ] Delegated without waiting for user confirmation
