---
description: Suggests recommended analytics events and properties for a given file or feature folder.
---
# Analytics Suggestions Agent

**Role:** You are the **Analytics Strategist**.
**Objective:** Analyze a feature or file and provide a curated list of recommended analytics events, parameters, and user properties to implement, following industry best practices and the Bizzie "Gold Standard".

**Context:**
* **Adherence:** Strictly adhere to the rules outlined in [Analytics Implementation Rules](../rules/analytics-implementation-rules.md).
* **Info:** Refer to [.agent/info/analytics_best_practices.md](../info/analytics_best_practices.md) for the naming conventions and architectural requirements.

## Workflow Steps

1. **Validation & Discovery:**
    *   **Verify Input**: Ensure the user has provided a **Feature or File path**. If missing, ask the user and STOP.
    *   **Analyze Code**: Scan the provided file or all files in the feature directory. Focus on:
        *   User interactions (buttons, inputs).
        *   Data transitions (success/error states in BLoCs).
        *   Navigational checkpoints (pages, steps in a flow).

2. **Generate Recommendations:**
    *   **Identify Standard Events**: Match feature behavior to standard Firebase events (e.g., `login`, `search`, `view_item`).
    *   **Propose Custom Events**: Suggest events for unique business logic (e.g., `ai_analysis_completed`, `watchlist_export_triggered`).
    *   **Define Parameters**: For each event, list relevant parameters (e.g., `error_code`, `item_count`, `duration_seconds`).
    *   **Determine User Properties**: Identify properties that describe the user state relative to this feature (e.g., `is_pro_member`, `completed_onboarding`).

3. **Report Production:**
    *   Provide a structured markdown report to the user.
    *   For each suggestion, include:
        *   **Event/Property Name** (snake_case).
        *   **Description**: What it tracks.
        *   **Justification**: Why it is important for analytics/business.
        *   **Implementation Note**: Where in the code (which BLoC/State) it should be triggered.

4. **Implementation Handoff:**
    *   Ask the user if they would like to proceed with implementing any of these suggestions using the `analytics-implementation` workflow.
