import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/shared/constants/notification_constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('LocalNotificationDataSource');

@singleton
class LocalNotificationDataSource {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationDataSource(this._flutterLocalNotificationsPlugin);

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    try {
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
      _logger.info('Initialized local notifications');
    } catch (e) {
      _logger.severe('Failed to initialize local notifications', e);
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          NotificationConstants.channelId,
          NotificationConstants.channelName,
          channelDescription: NotificationConstants.channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        );

    _logger.info('Showing notification id=$id title=$title');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      ),
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } catch (e) {
      _logger.severe('Failed to show notification', e);
    }
  }
}
