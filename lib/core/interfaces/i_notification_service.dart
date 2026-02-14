import 'package:bizzie/features/notifications/domain/models/notification_route.dart';

abstract class INotificationService {
  Future<String?> getFcmToken();
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Future<String> getDeviceUuid();
  Stream<NotificationRoute> get routeStream;
  Future<void> setupInteractions();
  Future<NotificationRoute?> getInitialRoute();
  Future<bool> isSystemAuthorized();
  Future<void> syncFcmToken({bool force = false});
  Future<void> clearCachedToken();
}
