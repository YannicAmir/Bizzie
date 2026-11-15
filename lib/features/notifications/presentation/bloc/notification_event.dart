import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.freezed.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.setupRequested() = NotificationSetupRequested;

  const factory NotificationEvent.syncRequested() = NotificationSyncRequested;

  const factory NotificationEvent.interactionReceived(
    Map<String, dynamic> payload,
  ) = NotificationInteractionReceived;

  const factory NotificationEvent.reset() = NotificationReset;

  const factory NotificationEvent.appReadyForNavigation() =
      NotificationAppReadyForNavigation;
}
