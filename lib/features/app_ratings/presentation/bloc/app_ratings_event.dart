part of 'app_ratings_bloc.dart';

@freezed
abstract class AppRatingsEvent with _$AppRatingsEvent {
  const factory AppRatingsEvent.interactionDetected({
    required CompanyProfile company,
    required String currentTab,
  }) = _InteractionDetected;
}
