import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_event.freezed.dart';

@freezed
abstract class FeedbackEvent with _$FeedbackEvent {
  const factory FeedbackEvent.submit(String message) = Submit;
  const factory FeedbackEvent.messageChanged(String message) = MessageChanged;
  const factory FeedbackEvent.cooldownEnded() = CooldownEnded;
}
