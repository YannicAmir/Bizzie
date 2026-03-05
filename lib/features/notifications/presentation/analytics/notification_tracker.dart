import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_app_state.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_error_type.dart';
import 'package:bizzie/features/notifications/domain/enums/notification_trigger_source.dart';
import 'package:bizzie/features/notifications/presentation/extensions/notification_error_type_extension.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationTracker {
  final IAnalyticsService _analytics;

  NotificationTracker(this._analytics);

  static const _kScreenName = 'notifications';

  /// Internal helper to ensure all notification events follow the Gold Standard.
  Future<void> _logEvent(String name, Map<String, dynamic> params) async {
    await _analytics.logEvent(
      name: name,
      parameters: {
        ...params,
        'screen_name': _kScreenName,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Logs the result of the OS notification permission request.
  Future<void> logPermissionResult({required bool granted}) async {
    await _logEvent('notification_permission_result', {'granted': granted});
  }

  /// Logs a successfull topic subscription.
  Future<void> logTopicSubscribed({required String topic}) async {
    await _logEvent('notification_topic_subscribed', {'topic': topic});
  }

  /// Logs a successfull topic unsubscription.
  Future<void> logTopicUnsubscribed({required String topic}) async {
    await _logEvent('notification_topic_unsubscribed', {'topic': topic});
  }

  /// Logs when a message is received in the app.
  Future<void> logMessageReceived({required String? type}) async {
    await _logEvent('notification_received', {
      if (type != null) 'notification_type': type,
    });
  }

  /// Logs when a notification is tapped by the user.
  Future<void> logNotificationOpened({
    required String? notificationType,
    required NotificationTriggerSource triggerSource,
    required NotificationAppState appState,
    required String? route,
    String? ticker,
  }) async {
    await _logEvent('notification_opened', {
      if (notificationType != null) 'notification_type': notificationType,
      'trigger_source': triggerSource.name,
      'app_state': appState.name,
      if (route != null) 'route': route,
      if (ticker != null) 'ticker': ticker,
    });
  }

  /// Logs when a synchronization failure occurs (e.g. FCM token update).
  Future<void> logSyncFailure({required String message}) async {
    await _logEvent('notification_sync_failure', {
      'error_type': NotificationErrorType.tokenSyncFailure.analyticsValue,
      'error_message': message,
    });
  }

  /// Logs a generic error within the notification feature.
  Future<void> logError({
    required NotificationErrorType type,
    required String message,
  }) async {
    await _logEvent('notification_error', {
      'error_type': type.analyticsValue,
      'error_message': message,
    });
  }

  /// Updates the user property for global notification status.
  Future<void> setUserNotificationsEnabled(bool enabled) async {
    await _analytics.setUserProperty(
      name: 'notifications_enabled',
      value: enabled.toString(),
    );
  }
}
