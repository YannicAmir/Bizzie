part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.started() = _Started;
  const factory OnboardingEvent.nameSubmitted(String name) = _NameSubmitted;
  const factory OnboardingEvent.sectorSelected(Sector sector) = _SectorSelected;
  const factory OnboardingEvent.loadSp500History() = _LoadSp500History;

  const factory OnboardingEvent.toggleBrand(Brand brand) = _ToggleBrand;
  const factory OnboardingEvent.experienceSelected(
    InvestingExperience experience,
  ) = _ExperienceSelected;
  const factory OnboardingEvent.notificationsToggled(bool enabled) =
      _NotificationsToggled;

  const factory OnboardingEvent.completeOnboarding() = _CompleteOnboarding;

  // Analysis
  const factory OnboardingEvent.startAnalysis() = _StartAnalysis;
  const factory OnboardingEvent.updateAnalysisStep(int step) =
      _UpdateAnalysisStep;

  // Watchlist Addition
  const factory OnboardingEvent.startWatchlistAddition() =
      _StartWatchlistAddition;
  const factory OnboardingEvent.updateWatchlistStep(int step) =
      _UpdateWatchlistStep;

  // Feature Highlights
  const factory OnboardingEvent.highlightPageChanged(int index) =
      _HighlightPageChanged;
  const factory OnboardingEvent.highlightContinuePressed() =
      _HighlightContinuePressed;
  const factory OnboardingEvent.highlightSkipPressed() = _HighlightSkipPressed;

  // Landing
  const factory OnboardingEvent.landingPageViewed() = _LandingPageViewed;
  const factory OnboardingEvent.loginRequested() = _LoginRequested;

  // Profile Ready
  const factory OnboardingEvent.profileReadyPageViewed() =
      _ProfileReadyPageViewed;
  const factory OnboardingEvent.profileReadyContinuePressed() =
      _ProfileReadyContinuePressed;
  const factory OnboardingEvent.stepViewed(OnboardingStep step) = _StepViewed;
  const factory OnboardingEvent.subscriptionStatusChanged({
    required bool didSubscribe,
    required String subscriptionType,
  }) = SubscriptionStatusChanged;
  const factory OnboardingEvent.onboardingFlowFinished() =
      _OnboardingFlowFinished;
  const factory OnboardingEvent.reset() = _Reset;
}
