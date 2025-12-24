---
trigger: model_decision
description: This rule should be applied when notifications are being set up
---

# Notification Rules

> [!CRITICAL]
> **3-Environment Mandate**
> You must treat Dev, QA, and Prod as completely separate entities.
> * **Tokens:** A Dev token will not work on the Prod app.
> * **APNs Keys:** You must instruct the user to upload the APNs Auth Key to **all 3** Firebase Projects.

## Response Constraints:
* **No UI Code:** Do not build a "Notification Settings Screen". Just the Logic/Bloc.
* **Safety:** Wrap permission requests in `try/catch`.