abstract class IAnalyticsService {
  /// Logs a custom event.
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  });

  /// Sets a user property.
  Future<void> setUserProperty({required String name, required String? value});

  /// Logs a screen view.
  Future<void> logScreenView({
    required String screenName,
    String? screenClassOverride,
  });

  /// Sets the user ID.
  Future<void> setUserId(String? id);

  /// Enables or disables analytics collection.
  Future<void> setAnalyticsCollectionEnabled(bool enabled);
}
