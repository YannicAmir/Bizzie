part of 'notification_bloc.dart';

@freezed
abstract class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.setupRequested() = NotificationSetupRequested;
  const factory NotificationEvent.subscribeToTopicRequested(String topic) =
      NotificationSubscribeToTopicRequested;
  const factory NotificationEvent.unsubscribeFromTopicRequested(String topic) =
      NotificationUnsubscribeFromTopicRequested;
  const factory NotificationEvent.messageReceived(NotificationMessage message) =
      NotificationMessageReceived;
  const factory NotificationEvent.interactionReceived(
    Map<String, dynamic> payload,
  ) = NotificationInteractionReceived;
  const factory NotificationEvent.reset() = NotificationReset;
}
