---
trigger: manual
description: Apply when implementing Firebase Analytics for a file or feature.
---
# Analytics Implementation Rules

## Mandatory Inputs
*   **Feature/File AND Objective**: You MUST NOT proceed until the user has provided both the feature/file to be analyzed and a clear objective of what data they want to collect (e.g., "track onboarding drop-offs").
*   **Context Extraction**: If the user's objective is descriptive (e.g., "I want to see if users like the new feature"), you must independently determine the relevant events, parameters, and user properties required to meet that objective.

## Architecture Constraints
*   **Abstraction Only**: NEVER use `FirebaseAnalytics` directly in features. All calls MUST go through `IAnalyticsService`.
*   **BLoC Only**: Analytics events MUST be logged within BLoCs/Cubits. 
*   **Dumb Widgets**: UI Widgets MUST NOT log analytics events. They should only emit events to their respective BLoCs.
*   **Automatic Screen Tracking**: Rely on the `FirebaseAnalyticsObserver` for standard screen tracking. Only use manual screen tracking (via `setCurrentScreen`) for modals or non-standard view transitions.

## Naming & Data Standards
*   **Naming Convention**: All event names and parameter keys MUST be `snake_case`.
*   **Event Pattern**: `[feature]_[action]_[result/detail]` (e.g., `auth_login_success`).
*   **Mandatory Parameters**: Every custom event MUST include:
    *   `timestamp`: ISO8601 string.
    *   `screen_name`: The current screen name.
*   **Standard Events**: Use Firebase standard events (e.g., `login`, `search`) whenever they map naturally to the user's objective.
*   **Zero PII**: NEVER log Personally Identifiable Information (email, names, phone numbers).

## Suggestion Logic
*   **Contextual Relevance**: When suggesting events, prioritize those that track "Success/Failure" of key business logic, "Drop-off points" in multi-step flows, and "Feature engagement" (how often and by whom).
*   **Standardization**: Suggestions MUST align with standard Firebase events where applicable.
*   **Justification**: Every suggested event or property MUST include a brief explanation of the value it provides for business intelligence.

## Localization & Opt-Out
*   **Opt-Out Respect**: Ensure that analytics calls are only made if user consent is respected (utilize `setAnalyticsCollectionEnabled` if an opt-out mechanism is implemented).

## Technical Reference
*   Strictly follow the [Gold Standard Analytics Guide](../../.agent/info/analytics_best_practices.md).
