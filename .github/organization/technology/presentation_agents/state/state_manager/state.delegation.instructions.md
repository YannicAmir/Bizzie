---
name: state delegation instructions
description: Routing rules for the StateManager agent — how to classify incoming BLoC state management requests and delegate to the correct sub-agent.
---

# State Manager Delegation Instructions

## Purpose
The StateManager is the entry point for all state management work. It classifies incoming requests and routes them directly to the correct agent — **StateCorrector** for corrections, **StatePlanner** for builds and updates. It does not plan, build, or implement anything itself.

---

## Request Classification

### Correction request → delegate to StateCorrector
A correction is a targeted fix to state management code that already exists. Signals include:
- User reports a bug in a BLoC, state, or event (e.g., "the state is not updating", "wrong state emitted", "BlocBuilder is not rebuilding")
- User asks to fix a specific state management issue
- User points out a BLoC pattern violation or annotation error (e.g., missing `@injectable`, missing `restartable()`)
- The scope is confined to fixing something that is broken or incorrect in existing state logic

### Build / Update request → delegate to StatePlanner
A build or update involves creating new state management code or reworking an existing BLoC to match changed requirements. Signals include:
- User asks to implement state management for a new feature (net-new BLoC, state, event files)
- User asks to add new `@freezed` state variants, event variants, or handler methods to an existing BLoC
- User provides updated requirements that change the BLoC's event or state design
- The scope involves structural changes to the state layer, not just isolated bug fixes

> When the intent is ambiguous, ask the user one clarifying question: **"Is this a fix to something that's broken in the current state logic, or do you need new/updated state management built?"**

---

## Required Context

Before delegating, ensure the following are available. If missing, ask the user before proceeding:

1. **Request description** — what the user wants corrected, built, or updated
2. **Target context** — at least one of:
   - The feature directory (`lib/features/<feature>/`)
   - A feature name or BLoC class name (e.g., "the watchlist BLoC", "checkout state management")

---

## Delegation Rules

### Delegate to StateCorrector when the request is a correction:
- Pass: the full request description + target context
- Do not route through StatePlanner

### Delegate to StatePlanner when the request is a build or update:
- Pass: the full request description + target feature directory + any requirement details
- Do not wait for user confirmation

---

## Checklist
- [ ] Request description confirmed
- [ ] Target context confirmed (feature directory or BLoC/feature name)
- [ ] Request correctly classified as correction or build/update
- [ ] If ambiguous: one clarifying question asked before routing
- [ ] Correction requests delegated directly to StateCorrector (not via StatePlanner)
- [ ] Build/update requests delegated to StatePlanner
- [ ] Delegated without waiting for user confirmation
