import 'package:bizzie/features/notifications/domain/models/notification_message.dart';

abstract class INotificationRepository {
  Future<void> requestPermission();
  Future<String?> getFcmToken();
  Stream<NotificationMessage> get onMessage;
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
}
