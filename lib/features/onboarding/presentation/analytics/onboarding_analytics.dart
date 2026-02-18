import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OnboardingAnalytics {
  final IAnalyticsService _analytics;

  OnboardingAnalytics(this._analytics);

  Future<void> logSectorSelected(Sector sector) async {
    await _analytics.logEvent(
      name: 'onboarding_sector_selected',
      parameters: {'sector_name': sector.name},
    );
  }

  Future<void> logExperienceSelected(InvestingExperience experience) async {
    await _analytics.logEvent(
      name: 'onboarding_experience_selected',
      parameters: {'experience_level': experience.name},
    );
  }

  Future<void> logBrandsSelected({
    required List<String> brandNames,
    required int count,
  }) async {
    await _analytics.logEvent(
      name: 'onboarding_brands_selected',
      parameters: {
        'brand_names': brandNames.take(10).join(','),
        'count': count,
      },
    );
  }

  Future<void> logNotificationsToggled(bool enabled) async {
    await _analytics.logEvent(
      name: 'onboarding_notifications_enabled',
      parameters: {'enabled': enabled},
    );
  }

  Future<void> logHighlightsSkipped(int index) async {
    await _analytics.logEvent(
      name: 'onboarding_highlights_skipped',
      parameters: {'index': index},
    );
  }

  Future<void> logProfileReadyContinue() async {
    await _analytics.logEvent(name: 'onboarding_profile_ready_continue');
  }

  Future<void> logComplete({
    required Sector sector,
    required InvestingExperience experience,
    required int brandCount,
  }) async {
    await _analytics.logEvent(
      name: 'onboarding_complete',
      parameters: {
        'sector': sector.name,
        'experience': experience.name,
        'brand_count': brandCount,
      },
    );
  }

  Future<void> logError({
    required String message,
    required String stepName,
  }) async {
    await _analytics.logEvent(
      name: 'onboarding_error',
      parameters: {'error_message': message, 'step_name': stepName},
    );
  }

  Future<void> logSignUp() async {
    await _analytics.logEvent(name: 'sign_up');
  }

  Future<void> setUserProperties({
    required InvestingExperience experience,
    required Sector sector,
  }) async {
    await _analytics.setUserProperty(
      name: 'investing_experience',
      value: experience.name,
    );
    await _analytics.setUserProperty(
      name: 'favorite_sector',
      value: sector.name,
    );
  }
}
