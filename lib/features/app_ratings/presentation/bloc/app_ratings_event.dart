part of 'app_ratings_bloc.dart';

@freezed
class AppRatingsEvent with _$AppRatingsEvent {
  const factory AppRatingsEvent.interactionDetected() = _InteractionDetected;
}
