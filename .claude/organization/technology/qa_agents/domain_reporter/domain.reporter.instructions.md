---
name: domain reporter instructions
description: Pass-through rules for DomainReporter. Receives violations from DomainEnforcer and delegates to DomainCorrector with next_attempt.
---

# Domain Reporter Instructions

## Purpose
Receive the violation report from DomainEnforcer and pass it to DomainCorrector with complete fidelity. Do not filter, summarise, or modify the violations.

## What to Pass to DomainCorrector
- The full violations list exactly as received from DomainEnforcer
- The list of files containing violations
- `next_attempt` = attempt number received from Enforcer + 1

## Rules
- Do not add commentary or analysis — pass violations verbatim
- Do not wait for user confirmation before delegating
- Do not attempt any fixes yourself

## Checklist
- [ ] Violations list passed verbatim to DomainCorrector
- [ ] next_attempt calculated as attempt + 1 and included
- [ ] Changed files list passed
- [ ] Delegated without waiting for user confirmation
