import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';

@freezed
abstract class FeedbackModel with _$FeedbackModel {
  static const int maxMessageLength = 1000;

  const factory FeedbackModel({
    required String userId,
    required String userName,
    required String message,
    required DateTime timestamp,
    String? userEmail,
    String? fcmToken,
    required bool isSubscribed,
    required bool notificationsEnabled,
  }) = _FeedbackModel;
}
