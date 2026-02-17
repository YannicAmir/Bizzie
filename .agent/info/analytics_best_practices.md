# Gold Standard Analytics & A/B Testing Guide

This document defines the production-grade standards for implementing analytics and A/B testing in the Bizzie application. It is designed to be used as a blueprint for the **Analytics Agent**.

---

## 1. Core Architecture

### **Abstraction Layer**
All analytics calls must go through an abstract interface. This ensures the app is not hard-coupled to Firebase and facilitates unit testing.

- **Interface**: `lib/core/interfaces/i_analytics_service.dart`
- **Implementation**: `lib/services/analytics_service.dart`

### **Dependency Injection**
The `AnalyticsService` should be registered as a lazy singleton using `injectable`.

```dart
@LazySingleton(as: IAnalyticsService)
class AnalyticsService implements IAnalyticsService {
  final FirebaseAnalytics _analytics;
  AnalyticsService(this._analytics);
  // ... implementation
}
```

---

## 2. Event Tracking Strategy

### **Naming Convention**
- **Strictly enforce `snake_case`** for all event names and parameter keys.
- **Pattern**: `[feature]_[action]_[result/detail]`
  - *Example*: `auth_login_success`, `search_query_executed`, `watchlist_stock_added`.

### **Mandatory Parameters**
Every custom event should include:
- `timestamp`: ISO8601 string.
- `screen_name`: The name of the screen where the event occurred.
- `user_id`: (If authenticated).

### **Standard vs. Custom Events**
- Use Firebase's **Standard Events** where possible (e.g., `login`, `sign_up`, `search`, `share`) to leverage built-in reporting.
- Use **Custom Events** for business-specific logic (e.g., `stock_viewed`, `ai_analysis_requested`).

---

## 3. User Properties

User properties are attributes used to describe segments of your user base, such as language preference or geographic location.

**Required Properties:**
- `user_plan`: (e.g., `free`, `pro`, `premium`)
- `subscription_status`: (e.g., `active`, `expired`, `trialing`)
- `app_theme`: (e.g., `light`, `dark`)
- `favorite_sector`: The user's preferred stock sector.

---

## 4. A/B Testing Integration (The Gold Standard)

A/B testing is powered by **Firebase Remote Config** in conjunction with **Analytics**.

### **Workflow:**
1.  **Define Experiment in Firebase Console**: Create a Remote Config parameter (e.g., `new_onboarding_flow_enabled`).
2.  **Access via `IConfigService`**: Use the existing `ConfigService` to retrieve the value.
3.  **Track the Variant**: When a user is exposed to an experiment, log a `user_property` or a specific `experiment_exposure` event.
    - *Property Name*: `exp_[experiment_name]`
    - *Value*: The variant ID (e.g., `control`, `variant_a`).

```dart
// Example exposure tracking
void trackExperimentExposure(String experimentName, String variant) {
  _analytics.setUserProperty(name: 'exp_$experimentName', value: variant);
  _analytics.logEvent(
    name: 'experiment_exposure',
    parameters: {'experiment_name': experimentName, 'variant': variant},
  );
}
```

---

## 5. Implementation Guidelines (For Developers & Agents)

### **Where to Log Events?**
- **Log in BLoCs/Cubits**: Business logic components should be responsible for triggering analytics events based on state transitions or user actions.
- **Do NOT log in UI Widgets**: Keep widgets "dumb." They should only emit events to the BLoC.

### **Screen Tracking**
- Use the `FirebaseAnalyticsObserver` in `app/router.dart` for automatic screen tracking.
- For manual screen tracking (e.g., in modals), use `_analytics.setCurrentScreen(screenName: '...')`.

---

## 6. Verification Plan

### **DebugView**
- During development, use **Firebase DebugView** to verify that events are being sent in real-time with the correct parameters.
- **Command**: `adb shell setprop debug.firebase.analytics.app [PACKAGE_NAME]` (Android) or add `-FIRDebugEnabled` to launch arguments (iOS).

### **Automated Tests**
- Unit test the BLoCs to ensure that the correct `IAnalyticsService` methods are called when specific actions occur.

---

## 7. Compliance & Privacy
- Ensure all tracking complies with GDPR/CCPA.
- **NEVER** track Personally Identifiable Information (PII) like email addresses, phone numbers, or real names in event parameters.
- Provide a way for users to opt-out of analytics in the app settings (tracked via `_analytics.setAnalyticsCollectionEnabled(bool)`).
