part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.started() = _Started;
  const factory OnboardingEvent.nameSubmitted(String name) = _NameSubmitted;
  const factory OnboardingEvent.sectorSelected(String sector) = _SectorSelected;
  const factory OnboardingEvent.uploadBrands(String brandsText) = _UploadBrands;
  const factory OnboardingEvent.loadSp500History() = _LoadSp500History;
  const factory OnboardingEvent.confirmWatchlist(
    List<Company> confirmedCompanies,
  ) = _ConfirmWatchlist;
  const factory OnboardingEvent.experienceSelected(
    InvestingExperience experience,
  ) = _ExperienceSelected;
  const factory OnboardingEvent.completeOnboarding({
    required String uid,
    required String fcmToken,
  }) = _CompleteOnboarding;
}
