import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_ratings_event.freezed.dart';

@freezed
sealed class AppRatingsEvent with _$AppRatingsEvent {
  const factory AppRatingsEvent.interactionDetected({
    required CompanyProfile company,
    required String currentTab,
  }) = AppRatingsInteractionDetected;
}
