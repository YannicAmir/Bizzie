part of 'app_ratings_bloc.dart';

@freezed
abstract class AppRatingsState with _$AppRatingsState {
  const factory AppRatingsState.initial() = _Initial;
  const factory AppRatingsState.requestReview() = _RequestReview;
  const factory AppRatingsState.idle() = _Idle;
}
