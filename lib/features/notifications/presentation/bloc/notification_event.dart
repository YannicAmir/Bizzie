import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/notifications/domain/models/notification_message.dart';

part 'notification_event.freezed.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.setupRequested() = NotificationSetupRequested;

  const factory NotificationEvent.subscribeToTopicRequested(String topic) =
      NotificationSubscribeToTopicRequested;

  const factory NotificationEvent.unsubscribeFromTopicRequested(String topic) =
      NotificationUnsubscribeFromTopicRequested;

  const factory NotificationEvent.messageReceived(
    NotificationMessage message,
  ) = NotificationMessageReceived;

  const factory NotificationEvent.interactionReceived(
    Map<String, dynamic> payload,
  ) = NotificationInteractionReceived;

  const factory NotificationEvent.reset() = NotificationReset;

  const factory NotificationEvent.appReadyForNavigation() =
      NotificationAppReadyForNavigation;
}
