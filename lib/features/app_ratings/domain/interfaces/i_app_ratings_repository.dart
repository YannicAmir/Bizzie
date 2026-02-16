abstract class IAppRatingsRepository {
  /// Gets the total number of significant user interactions tracked for ratings.
  Future<int> getInteractionCount();

  /// Increments the total interaction count.
  Future<void> incrementInteractionCount();

  /// Gets the number of times the rating prompt has been attempted/shown.
  Future<int> getPromptAttempts();

  /// Increments the prompt attempt count.
  ///
  /// Should be called immediately after a prompt is successfully triggered.
  Future<void> incrementPromptAttempts();
}
