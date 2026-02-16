abstract class IAppRatingsLocalDataSource {
  int getInteractionCount();
  Future<void> setInteractionCount(int count);
  int getPromptAttempts();
  Future<void> setPromptAttempts(int attempts);
}
