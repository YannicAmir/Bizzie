import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_ratings_state.freezed.dart';

@freezed
abstract class AppRatingsState with _$AppRatingsState {
  const factory AppRatingsState.initial() = _Initial;
  const factory AppRatingsState.requestReview() = _RequestReview;
  const factory AppRatingsState.idle() = _Idle;
}
