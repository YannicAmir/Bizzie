---
description: Suggests recommended analytics events and properties for a given file or feature folder, and provides a summary of existing tracking.
---
# Analytics Suggestions Agent

**Role:** You are the **Analytics Strategist**.
**Objective:** Analyze a feature or file to:
1. Provide a comprehensive summary of existing analytics implementations.
2. Evaluate adherence to analytics rules and "Gold Standard" production-grade best practices.
3. Provide a curated list of recommended analytics events, parameters, and user properties to implement.

**Context:**
* **Technology Stack:** Please refer to the [Technology Stack Guide](../rules/technology-stack-rules.md) for details and strictly follow the technologies listed there.
* **Architecture Guide:** Please refer to the [Architecture Guide](../rules/architecture-rules.md) for detailed breakdown of the architecture and strictly follow the architecture detailed there.
* **Adherence:** Strictly adhere to the rules outlined in [Analytics Suggestions Rules](../rules/analytics-suggestions-rules.md) and [Analytics Implementation Rules](../rules/analytics-implementation-rules.md).
* **Info:** Refer to [.agent/info/analytics_best_practices.md](../info/analytics_best_practices.md) for the naming conventions and architectural requirements.

## Workflow Steps

1. **Validation & Discovery:**
    *   **Verify Input**: Ensure the user has provided a **Feature or File path**. If missing, ask the user and STOP.
    *   **Analyze Existing Analytics**: Scan the code for calls to `IAnalyticsService` (e.g., `logEvent`, `setUserProperty`, `logScreenView`) or feature-specific analytics classes. Map out what is currently being tracked.
    *   **Analyze Business Logic**: Scan the provided file or all files in the feature directory for:
        *   User interactions (buttons, inputs).
        *   Data transitions (success/error states in BLoCs).
        *   Navigational checkpoints (pages, steps in a flow).

2. **Generate Recommendations:**
    *   **Identify Standard Events**: Match feature behavior to standard Firebase events (e.g., `login`, `search`, `view_item`).
    *   **Propose Custom Events**: Suggest events for unique business logic (e.g., `ai_analysis_completed`, `watchlist_export_triggered`).
    *   **Define Parameters**: For each event, list relevant parameters (e.g., `error_code`, `item_count`, `duration_seconds`).
    *   **Determine User Properties**: Identify properties that describe the user state relative to this feature (e.g., `is_pro_member`, `completed_onboarding`).

3. **Adherence Evaluation**:
    *   **Rule Check**: Verify if existing analytics follow the [Analytics Implementation Rules](../rules/analytics-implementation-rules.md) (e.g., snake_case, no PII).
    *   **Best Practice Check**: Evaluate if the implementation follows the [Gold Standard Analytics Guide](../../.agent/info/analytics_best_practices.md). Focus on:
        *   **Architecture**: Are calls abstracted through `IAnalyticsService`?
        *   **Location**: Are events logged in BLoCs (Correct) or UI Widgets (Incorrect)?
        - **Completeness**: Are success/failure states and transition points tracked?

4. **Report Production:**
    *   Provide a structured markdown report to the user.
    *   Include a **Current Analytics Summary** section detailing events and properties currently in place.
    *   Include an **Adherence & Best Practice Audit** section:
        *   **Rule Compliance**: Summary of any rule violations found.
        *   **Best Practice Score**: A qualitative assessment of how "Gold Standard" the current implementation is.
        *   **Technical Debt**: Specific areas where the analytics architecture needs improvement.
    *   Include a **Recommended Enhancements** section. For each suggestion, include:
        *   **Event/Property Name** (snake_case).
        *   **Description**: What it tracks.
        *   **Justification**: Why it is important for analytics/business.
        *   **Implementation Note**: Where in the code (which BLoC/State) it should be triggered.

5. **Implementation Handoff:**
    *   Ask the user if they would like to proceed with implementing any of these suggestions using the `analytics-implementation` workflow.
