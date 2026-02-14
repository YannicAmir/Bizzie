import 'package:bizzie/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_state.freezed.dart';

@freezed
abstract class FeedbackState with _$FeedbackState {
  const factory FeedbackState.initial({@Default(false) bool isCoolingDown}) =
      Initial;
  const factory FeedbackState.loading({@Default(false) bool isCoolingDown}) =
      Loading;
  const factory FeedbackState.success({@Default(true) bool isCoolingDown}) =
      Success;
  const factory FeedbackState.failure(
    Failure failure, {
    @Default(false) bool isCoolingDown,
  }) = FailureState;
}
