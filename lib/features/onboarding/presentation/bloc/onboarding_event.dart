part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.started() = _Started;
  const factory OnboardingEvent.nameSubmitted(String name) = _NameSubmitted;
  const factory OnboardingEvent.sectorSelected(Sector sector) = _SectorSelected;
  const factory OnboardingEvent.uploadBrands(String brandsText) = _UploadBrands;
  const factory OnboardingEvent.loadSp500History() = _LoadSp500History;
  const factory OnboardingEvent.confirmWatchlist(
    List<Company> confirmedCompanies,
  ) = _ConfirmWatchlist;
  const factory OnboardingEvent.loadBrands() = _LoadBrands;
  const factory OnboardingEvent.toggleBrand(Brand brand) = _ToggleBrand;
  const factory OnboardingEvent.updateCustomBrandInput(String input) =
      _UpdateCustomBrandInput;
  const factory OnboardingEvent.experienceSelected(
    InvestingExperience experience,
  ) = _ExperienceSelected;
  const factory OnboardingEvent.completeOnboarding({
    required String uid,
    required String fcmToken,
  }) = _CompleteOnboarding;

  // Analysis
  const factory OnboardingEvent.startAnalysis() = _StartAnalysis;
  const factory OnboardingEvent.updateAnalysisStep(int step) =
      _UpdateAnalysisStep;

  // Watchlist Addition
  const factory OnboardingEvent.startWatchlistAddition() =
      _StartWatchlistAddition;
  const factory OnboardingEvent.updateWatchlistStep(int step) =
      _UpdateWatchlistStep;
}
