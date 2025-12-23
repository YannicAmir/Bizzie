part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.setupRequested() = _SetupRequested;
  const factory NotificationEvent.subscribeToTopicRequested(String topic) =
      _SubscribeToTopicRequested;
  const factory NotificationEvent.unsubscribeFromTopicRequested(String topic) =
      _UnsubscribeFromTopicRequested;
  const factory NotificationEvent.messageReceived(NotificationMessage message) =
      _MessageReceived;
}
