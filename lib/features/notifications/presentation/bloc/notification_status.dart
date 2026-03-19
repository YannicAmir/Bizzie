import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';
import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';

part 'notification_status.freezed.dart';

@freezed
sealed class NotificationStatus with _$NotificationStatus {
  const factory NotificationStatus.initial() = NotificationStatusInitial;

  const factory NotificationStatus.loading() = NotificationStatusLoading;

  const factory NotificationStatus.success(String? fcmToken) =
      NotificationStatusSuccess;

  const factory NotificationStatus.failure(String message) =
      NotificationStatusFailure;

  const factory NotificationStatus.messageReceived(
    NotificationMessage message,
  ) = NotificationStatusMessageReceived;

  const factory NotificationStatus.navigationRequested(
    NotificationIntent intent,
    int timestamp,
  ) = NotificationStatusNavigationRequested;
}
