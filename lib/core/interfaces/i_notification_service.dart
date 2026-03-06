abstract class INotificationService {
  Future<String?> getFcmToken();
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Future<String> getDeviceUuid();
  Stream<Map<String, dynamic>> get payloadStream;
  Future<void> setupInteractions();
  Future<Map<String, dynamic>?> getInitialPayload();
  Future<bool> isSystemAuthorized();
  Future<void> syncFcmToken({bool force = false});
  Future<void> clearCachedToken();
}
