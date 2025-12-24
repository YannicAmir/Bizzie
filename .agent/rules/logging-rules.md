---
trigger: model_decision
description: This rule should be applied when update-logging.md is triggered
---

# Logging Rules

* **Environment Rule:** Logging is **STRICTLY PERMITTED IN DEV ONLY**. It must be silenced in QA and Prod to prevent performance degradation and security leaks.
*   print statements should not be present anywhere in the codebase