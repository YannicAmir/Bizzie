import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_skip_reason.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
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
  const factory OnboardingEvent.notificationsToggled({required bool enabled}) =
      OnboardingNotificationsToggled;

  const factory OnboardingEvent.completionRequested() =
      OnboardingCompletionRequested;
  const factory OnboardingEvent.buildingProfileStarted() =
      OnboardingBuildingProfileStarted;
  const factory OnboardingEvent.skipRequested(
    OnboardingStep step, {
    @Default(OnboardingSkipReason.userSkipped) OnboardingSkipReason reason,
  }) = OnboardingSkipRequested;
  const factory OnboardingEvent.notificationGrantPersistRequested() =
      OnboardingNotificationGrantPersistRequested;
  const factory OnboardingEvent.initialCompanyShown(
    PostOnboardingDestination destination,
  ) = OnboardingInitialCompanyShown;

  const factory OnboardingEvent.guestSessionRequested() =
      OnboardingGuestSessionRequested;
  const factory OnboardingEvent.brandsConfirmed() = OnboardingBrandsConfirmed;
  const factory OnboardingEvent.brandsPrefetchRequested() =
      OnboardingBrandsPrefetchRequested;

  // Feature Highlights
  const factory OnboardingEvent.highlightPageChanged(int index) =
      OnboardingHighlightPageChanged;
  const factory OnboardingEvent.highlightContinuePressed() =
      OnboardingHighlightContinuePressed;

  // Landing
  const factory OnboardingEvent.loginRequested() = OnboardingLoginRequested;

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
