import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_app_state.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_trigger_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationTracker {
  final IAnalyticsService _analytics;

  NotificationTracker(this._analytics);

  static const _kScreenName = 'notifications_request';

  /// Logs the result of the OS notification permission request.
  Future<void> logPermissionResult({required bool granted}) async {
    await _analytics.logEvent(
      name: 'notification_permission_result',
      parameters: {'granted': granted, 'screen_name': _kScreenName},
    );
  }

  /// Logs a successfull topic subscription.
  Future<void> logTopicSubscribed({required String topic}) async {
    await _analytics.logEvent(
      name: 'notification_topic_subscribed',
      parameters: {'topic': topic, 'screen_name': _kScreenName},
    );
  }

  /// Logs a successfull topic unsubscription.
  Future<void> logTopicUnsubscribed({required String topic}) async {
    await _analytics.logEvent(
      name: 'notification_topic_unsubscribed',
      parameters: {'topic': topic, 'screen_name': _kScreenName},
    );
  }

  /// Logs when a message is received in the app.
  Future<void> logMessageReceived({required String? type}) async {
    await _analytics.logEvent(
      name: 'notification_received',
      parameters: {
        if (type != null) 'notification_type': type,
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs when a notification is tapped by the user.
  Future<void> logNotificationOpened({
    required String? notificationType,
    required NotificationTriggerSource triggerSource,
    required NotificationAppState appState,
    required String? route,
  }) async {
    await _analytics.logEvent(
      name: 'notification_opened',
      parameters: {
        if (notificationType != null) 'notification_type': notificationType,
        'trigger_source': triggerSource.name,
        'app_state': appState.name,
        if (route != null) 'route': route,
        'screen_name': _kScreenName,
      },
    );
  }

  /// Updates the user property for global notification status.
  Future<void> setUserNotificationsEnabled(bool enabled) async {
    await _analytics.setUserProperty(
      name: 'notifications_enabled',
      value: enabled.toString(),
    );
  }
}
