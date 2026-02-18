---
trigger: manual
description: Apply when generating analytics suggestions for a file or feature.
---
# Analytics Suggestions Rules

## Mandatory Inputs
*   **Feature/File Path**: You MUST NOT proceed until the user has provided the path to be analyzed.

## Analysis & Evaluation Constraints
*   **Existing Analytics Audit**: You MUST search for and list all current usages of `IAnalyticsService` or feature-specific analytics classes within the scope.
*   **Adherence Check**: You MUST flag any existing analytics that violate the [Analytics Implementation Rules](../rules/analytics-implementation-rules.md). Pay special attention to:
    *   **Naming**: Non-snake_case names.
    *   **PII**: Logging of email, names, or other personal data.
    *   **UI Logging**: UI Widgets making analytics calls (MUST be from BLoC).
*   **Gold Standard Evaluation**: You MUST evaluate the implementation against the [Analytics Best Practices](../../.agent/info/analytics_best_practices.md).
    *   **Abstraction**: Is `IAnalyticsService` used instead of direct Firebase calls?
    *   **Context**: Are parameters like `timestamp` and `screen_name` consistently included?
    *   **Testability**: Is the analytics logic cleanly separated for unit testing?
*   **Coverage Gap Analysis**: You MUST compare existing analytics against the feature's user flow to identify missing critical events (e.g., error states, transition points).

## Suggestion Constraints
*   **Architecture First**: Recommendations MUST prioritize fixing architectural violations before suggesting new events.
*   **Naming Consistency**: All suggested names MUST be `snake_case` and follow the `[feature]_[action]_[result]` pattern.

## Reporting Format
*   **Audited Summary**: The report MUST start with the **Current Analytics Summary**.
*   **Adherence Scorecard**: Provide a specific table or list summarizing compliance with "Gold Standard" practices.
*   **Categorized Recommendations**: Group suggestions into "Critical Fixes" (rule violations) and "Enhancements" (new tracking).
*   **Technical Specificity**: Clearly identify the BLoC and State where each implementation should occur.
