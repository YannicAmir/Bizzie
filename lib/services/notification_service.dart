import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('NotificationService');

@LazySingleton(as: INotificationService)
class NotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final DeviceInfoPlugin _deviceInfo;

  NotificationService(this._firebaseMessaging, this._deviceInfo);

  @override
  Future<String?> getFcmToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      _logger.severe('Failed to fetch FCM token: $e');
      return null;
    }
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    _logger.info('Subscribing to topic: $topic');
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      _logger.info('Successfully subscribed to topic: $topic');
    } catch (e) {
      _logger.severe('Failed to subscribe to topic $topic: $e');
      rethrow;
    }
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    _logger.info('Unsubscribing from topic: $topic');
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      _logger.info('Successfully unsubscribed from topic: $topic');
    } catch (e) {
      _logger.severe('Failed to unsubscribe from topic $topic: $e');
      rethrow;
    }
  }

  @override
  Future<String> getDeviceUuid() async {
    if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios_device';
    } else if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id;
    } else {
      return 'unknown_platform_device';
    }
  }
}
