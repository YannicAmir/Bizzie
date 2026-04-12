---
name: domain delegation instructions
description: Rules for the DomainManager agent for routing domain layer requests to the correct specialist agent.
---

# Domain Delegation Instructions

## Purpose
The DomainManager assesses incoming domain layer requests and delegates to the appropriate specialist agent.

---

## Routing Logic

| Request type | Delegate to |
|---|---|
| New use case, model, interface, or service | DomainPlanner → DomainBuilder |
| Modifying existing use case, model, or interface | DomainPlanner → DomainUpdater |
| Fixing a specific violation or bug | DomainCorrector |
| Reviewing a plan before implementation | DomainPlanReviewer |

---

## Before Delegating

1. Read the feature's `domain/` directory to understand existing structure
2. Confirm whether the request is a build (nothing exists) or update (modifying existing code)
3. Provide the specialist agent with:
   - The feature directory path
   - The request description
   - Any relevant context (BLoC that will consume the use case, Firestore collections involved, etc.)

---

## Checklist
- [ ] Request type assessed (new vs. update vs. fix)
- [ ] Relevant domain directory read
- [ ] Correct specialist agent selected
- [ ] Full context provided to the delegated agent
