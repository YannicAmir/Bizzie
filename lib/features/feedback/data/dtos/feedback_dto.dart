import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/feedback/domain/models/feedback_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_dto.freezed.dart';
part 'feedback_dto.g.dart';

@freezed
abstract class FeedbackDto with _$FeedbackDto {
  const FeedbackDto._();

  const factory FeedbackDto({
    required String userId,
    required String userName,
    required String message,
    @TimestampConverter() required DateTime timestamp,
    String? userEmail,
    String? fcmToken,
    required bool isSubscribed,
    required bool notificationsEnabled,
  }) = _FeedbackDto;

  factory FeedbackDto.fromDomain(FeedbackModel domain) {
    return FeedbackDto(
      userId: domain.userId,
      userName: domain.userName,
      message: domain.message,
      timestamp: domain.timestamp,
      userEmail: domain.userEmail,
      fcmToken: domain.fcmToken,
      isSubscribed: domain.isSubscribed,
      notificationsEnabled: domain.notificationsEnabled,
    );
  }

  FeedbackModel toDomain() {
    return FeedbackModel(
      userId: userId,
      userName: userName,
      message: message,
      timestamp: timestamp,
      userEmail: userEmail,
      fcmToken: fcmToken,
      isSubscribed: isSubscribed,
      notificationsEnabled: notificationsEnabled,
    );
  }

  factory FeedbackDto.fromJson(Map<String, dynamic> json) =>
      _$FeedbackDtoFromJson(json);
}
