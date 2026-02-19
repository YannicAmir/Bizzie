import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_event.freezed.dart';

@freezed
abstract class FeedbackEvent with _$FeedbackEvent {
  const factory FeedbackEvent.viewed({String? intentSource}) = FeedbackViewed;
  const factory FeedbackEvent.submit(String message) = FeedbackSubmit;
  const factory FeedbackEvent.messageChanged(String message) =
      FeedbackMessageChanged;
  const factory FeedbackEvent.cooldownEnded() = FeedbackCooldownEnded;
}
