import 'package:bizzie/features/notifications/domain/enums/notification_error_type.dart';

extension NotificationErrorTypeX on NotificationErrorType {
  String get analyticsValue => switch (this) {
    NotificationErrorType.permissionException => 'permission_exception',
    NotificationErrorType.subscriptionFailure => 'subscription_failure',
    NotificationErrorType.unsubscriptionFailure => 'unsubscription_failure',
    NotificationErrorType.tokenSyncFailure => 'token_sync_failure',
    NotificationErrorType.unknown => 'unknown',
  };
}
