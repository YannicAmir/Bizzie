import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_status.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(NotificationStatus.initial()) NotificationStatus status,
    @Default(false) bool isAppReady,
    NotificationIntent? pendingIntent,
  }) = _NotificationState;
}
