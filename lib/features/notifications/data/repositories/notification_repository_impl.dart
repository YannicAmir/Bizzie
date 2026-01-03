import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/notifications/data/datasources/fcm_remote_datasource.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';

@LazySingleton(as: INotificationRepository)
class NotificationRepositoryImpl implements INotificationRepository {
  final FcmRemoteDataSource _fcmRemoteDataSource;
  final LocalNotificationDataSource _localNotificationDataSource;

  NotificationRepositoryImpl(
    this._fcmRemoteDataSource,
    this._localNotificationDataSource,
  );

  @override
  Future<void> requestPermission() async {
    await _fcmRemoteDataSource.requestPermission();
  }

  @override
  Future<String?> getFcmToken() async {
    return await _fcmRemoteDataSource.getToken();
  }

  @override
  Stream<NotificationMessage> get onMessage {
    return _fcmRemoteDataSource.onMessage.map((remoteMessage) {
      final notification = remoteMessage.notification;

      if (notification != null) {
        _localNotificationDataSource.showNotification(
          id: notification.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: remoteMessage.data.toString(),
        );
      }

      return NotificationMessage(
        title: notification?.title ?? 'No Title',
        body: notification?.body ?? 'No Body',
        data: remoteMessage.data,
        sentTime: remoteMessage.sentTime,
      );
    });
  }

  @override
  Future<void> subscribeToTopic(String topic) =>
      _fcmRemoteDataSource.subscribeToTopic(topic);

  @override
  Future<void> unsubscribeFromTopic(String topic) =>
      _fcmRemoteDataSource.unsubscribeFromTopic(topic);
}
