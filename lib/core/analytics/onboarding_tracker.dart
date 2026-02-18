import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

enum OnboardingStep {
  landing,
  askName,
  gladYouJoined,
  sectorSelection,
  meetYourBizzie,
  brandsSelection,
  analyzingSelectedBrands,
  companiesFound,
  addingToWatchlist,
  notificationsPrompt,
  investingExperience,
  featureHighlights,
  highlight1,
  highlight2,
  highlight3,
  createAccount,
  buildingProfile,
  profileReady,
  paywall,
}

@lazySingleton
class OnboardingTracker {
  final IAnalyticsService _analytics;

  OnboardingTracker(this._analytics);

  Future<void> logStepViewed({required OnboardingStep step}) async {
    await _analytics.logEvent(
      name: 'onboarding_step_viewed',
      parameters: {'step_name': step.name},
    );
  }

  Future<void> logStepDuration({
    required OnboardingStep step,
    required int seconds,
  }) async {
    await _analytics.logEvent(
      name: 'onboarding_step_duration',
      parameters: {'step_name': step.name, 'duration_seconds': seconds},
    );
  }
}
