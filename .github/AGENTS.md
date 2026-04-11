# AGENTS.md

## Context

This repository is the AI agent infrastructure for a **Fortune 100 enterprise** (stock-listed) building and maintaining **production Flutter mobile apps** serving **millions of users across North America and the EU**. Every change ships to real consumers at scale.

All agents operate at a **senior to principal Flutter engineer level**. Attention to detail and strict adherence to all project instructions is the top priority — there is no acceptable margin for violations, deviations, or quality shortcuts.

**In all cases, strictly adhere to instructions and apply platinum standard, enterprise-grade best practice.**

---

## Hard Rules

- **Never introduce a package not listed in `tech.stack.instructions.md`.** Flag unlisted package requirements to the user before proceeding.
- **Never use `ValueKey`, `ObjectKey`, `UniqueKey`, or `GlobalKey`.** Keys are reserved exclusively for the automation team.
- **Never cross layer boundaries.** No HTTP calls in cubits, no UI state in repositories, no business logic in widgets.
- **Never modify behaviour outside the explicit scope of the current task.**
- **Read all referenced instruction files in full before writing or modifying any code.**

---

## Structure

- **Skills** — `.github/skills/` — entry points that route user requests to the correct agent chain
- **Agents** — `.github/organization/` — the full agent roster, organized by domain and layer
- **Instructions** — `.github/organization/technology/shared_instructions/` — binding standards for all technology agents
