---
name: restrictions
description: Reserved patterns and restricted changes for all technology agents. Referenced by RefactorPlanner, RefactorPlanReviewer, and RefactorBuilder. Placeholder — populate with project-specific restrictions.
---

# Restrictions

> **Placeholder.** This file is referenced by the refactoring agent chain but had not
> been authored yet. It currently codifies only restrictions already established
> elsewhere in the instruction set. Add project-specific reserved patterns here.

---

## 1. Serialized Enum Names

- Enum values whose `.name` is serialized externally (analytics event parameters,
  deep-link query parameters, notification payloads, persisted storage) must **not**
  be renamed for style compliance. Renaming changes the emitted wire value and breaks
  analytics continuity and externally-issued links.
- Known instance: `PaywallSource.company_profile` (`lib/core/enums/paywall_source.dart`)
  — round-tripped via `.name` in paywall deep links and Firebase Analytics parameters.
  It carries an explicit `// ignore: constant_identifier_names` for this reason.

## 2. Behaviour-Preservation Boundaries

- No refactor may alter `ValueKey` strings, analytics event names/parameters,
  user-facing strings, or dispatched BLoC events (see `refactor.guidance.instructions.md`).

## Checklist
- [ ] No serialized enum value renamed
- [ ] No reserved pattern altered without explicit human approval
