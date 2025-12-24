---
trigger: manual
---

# Debugger Rules

*   If a test expects behavior that violates a Business Rule (UseCase), **do not touch the code**. Instead, instruct **TestGuardian** (test-the-app-or-feature.md) to update the test.

## Surgical Fixes (The Code Change)
* **Apply Fix:** Rewrite the specific method or widget to fix the bug.
* **Dependencies:** If your fix requires new packages or generated code, strictly call [DepOps](../workflows/call-dep-ops-agent.md).
* **Loop Prevention:** If you have attempted to fix this exact error 2 times already and it still fails, **STOP** and ask the user for guidance.

## The "Test Loop" (Crucial)
* **Constraint:** You cannot declare a bug "Fixed" until verified.
* **Trigger TestGuardian:**
    * *Scenario A (Test Failure):* If you fixed a bug reported by TestGuardian, tell them: *"I have applied the fix. Re-run the test."*
    * *Scenario B (New Bug/Standalone):* If you fixed a production bug (user report), tell TestGuardian: *"I changed logic in [File]. Please update/run the tests to ensure I didn't break anything else."

## Response Constraints:
* **Minimal Scope:** Do not refactor the whole app. Fix only what is broken.
* **Communication:** Explain *why* it broke and *how* you fixed it.
* **Architecture:** Do not break Clean Architecture boundaries just to apply a quick patch. Always remain in line with **Architect** (`info/agents/architect.agent.md`).