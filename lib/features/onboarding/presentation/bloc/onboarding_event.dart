import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_event.freezed.dart';

@freezed
sealed class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.started() = OnboardingStarted;
  const factory OnboardingEvent.nameSubmitted(String name) =
      OnboardingNameSubmitted;
  const factory OnboardingEvent.sectorSelected(Sector sector) =
      OnboardingSectorSelected;
  const factory OnboardingEvent.sp500HistoryRequested() =
      OnboardingSp500HistoryRequested;

  const factory OnboardingEvent.brandToggled(Brand brand) =
      OnboardingBrandToggled;
  const factory OnboardingEvent.experienceSelected(
    InvestingExperience experience,
  ) = OnboardingExperienceSelected;
  const factory OnboardingEvent.notificationsToggled(bool enabled) =
      OnboardingNotificationsToggled;

  const factory OnboardingEvent.completionRequested() =
      OnboardingCompletionRequested;

  // Analysis
  const factory OnboardingEvent.analysisStarted() = OnboardingAnalysisStarted;
  const factory OnboardingEvent.analysisStepUpdated(int step) =
      OnboardingAnalysisStepUpdated;

  // Watchlist Addition
  const factory OnboardingEvent.watchlistAdditionStarted() =
      OnboardingWatchlistAdditionStarted;
  const factory OnboardingEvent.watchlistStepUpdated(int step) =
      OnboardingWatchlistStepUpdated;

  // Feature Highlights
  const factory OnboardingEvent.highlightPageChanged(int index) =
      OnboardingHighlightPageChanged;
  const factory OnboardingEvent.highlightContinuePressed() =
      OnboardingHighlightContinuePressed;
  const factory OnboardingEvent.highlightSkipPressed() =
      OnboardingHighlightSkipPressed;

  // Landing
  const factory OnboardingEvent.landingPageViewed() =
      OnboardingLandingPageViewed;
  const factory OnboardingEvent.loginRequested() = OnboardingLoginRequested;

  // Profile Ready
  const factory OnboardingEvent.profileReadyPageViewed() =
      OnboardingProfileReadyPageViewed;
  const factory OnboardingEvent.stepViewed(OnboardingStep step) =
      OnboardingStepViewed;
  const factory OnboardingEvent.subscriptionStatusChanged({
    required bool didSubscribe,
    required String subscriptionType,
  }) = OnboardingSubscriptionStatusChanged;
  const factory OnboardingEvent.onboardingFlowFinished() =
      OnboardingFlowFinished;
  const factory OnboardingEvent.reset() = OnboardingReset;
}
