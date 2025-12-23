part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.success(String? fcmToken) = _Success;
  const factory NotificationState.failure(String message) = _Failure;
  const factory NotificationState.messageReceivedState(
    NotificationMessage message,
  ) = _MessageReceivedState;
}
