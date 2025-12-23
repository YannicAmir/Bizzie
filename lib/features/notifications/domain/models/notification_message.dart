import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_message.freezed.dart';
part 'notification_message.g.dart';

@freezed
abstract class NotificationMessage with _$NotificationMessage {
  const factory NotificationMessage({
    required String title,
    required String body,
    Map<String, dynamic>? data,
    DateTime? sentTime,
  }) = _NotificationMessage;

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      _$NotificationMessageFromJson(json);
}
