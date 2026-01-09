import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/notifications/data/datasources/local_notification_datasource.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('NotificationService');

@LazySingleton(as: INotificationService)
class NotificationService implements INotificationService {
  final INotificationRepository _notificationRepository;
  final LocalNotificationDataSource _localNotificationDataSource;
  final DeviceInfoPlugin _deviceInfo;

  NotificationService(
    this._notificationRepository,
    this._localNotificationDataSource,
    this._deviceInfo,
  ) {
    _initialize();
  }

  void _initialize() {
    _notificationRepository.onMessage.listen((message) {
      if (message.title.isNotEmpty || message.body.isNotEmpty) {
        _logger.info('Received message, showing local notification');
        _localNotificationDataSource.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: message.title,
          body: message.body,
          payload: message.data.toString(),
        );
      }
    });
  }

  @override
  Future<String?> getFcmToken() async {
    final result = await _notificationRepository.getFcmToken();
    return result.fold((failure) {
      _logger.severe('Failed to fetch FCM token: ${failure.message}');
      return null;
    }, (token) => token);
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    _logger.info('Subscribing to topic: $topic');
    final result = await _notificationRepository.subscribeToTopic(topic);
    result.fold((failure) {
      _logger.severe('Failed to subscribe to topic $topic: ${failure.message}');
      throw Exception(failure.message);
    }, (_) => _logger.info('Successfully subscribed to topic: $topic'));
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    _logger.info('Unsubscribing from topic: $topic');
    final result = await _notificationRepository.unsubscribeFromTopic(topic);
    result.fold((failure) {
      _logger.severe(
        'Failed to unsubscribe from topic $topic: ${failure.message}',
      );
      throw Exception(failure.message);
    }, (_) => _logger.info('Successfully unsubscribed from topic: $topic'));
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
