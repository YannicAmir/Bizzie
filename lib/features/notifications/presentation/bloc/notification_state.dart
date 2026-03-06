part of 'notification_bloc.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;
  const factory NotificationState.loading() = NotificationLoading;
  const factory NotificationState.success(String? fcmToken) =
      NotificationSuccess;
  const factory NotificationState.failure(String message) = NotificationFailure;
  const factory NotificationState.messageReceivedState(
    NotificationMessage message,
  ) = NotificationMessageReceivedState;
  const factory NotificationState.navigationRequested(
    NotificationIntent intent,
    int timestamp,
  ) = NotificationNavigationRequested;
}
