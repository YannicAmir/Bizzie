import 'package:bizzie/core/analytics/analytics_context.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OnboardingTracker {
  final IAnalyticsService _analytics;
  final AnalyticsContext _analyticsContext;

  OnboardingTracker(this._analytics, this._analyticsContext);

  static const _kScreenName = 'onboarding';

  Future<void> _logEvent(String name, Map<String, Object> params) async {
    await _analytics.logEvent(
      name: name,
      parameters: {
        ...params,
        'screen_name': _kScreenName,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> logStepViewed({required OnboardingStep step}) async {
    final Map<String, Object> parameters = {'step_name': step.name};

    if (step == OnboardingStep.landing && _analyticsContext.isPostDeletion) {
      parameters['source'] = 'account_deletion';
      _analyticsContext.reset();
    }

    await _logEvent('onboarding_step_viewed', parameters);
  }

  Future<void> logStepDuration({
    required OnboardingStep step,
    required int seconds,
  }) async {
    await _logEvent('onboarding_step_duration', {
      'step_name': step.name,
      'duration_seconds': seconds,
    });
  }

  Future<void> logExitToLogin() async {
    await _logEvent('onboarding_exit_to_login', {
      'step_name': OnboardingStep.landing.name,
    });
  }

  Future<void> logConversion() async {
    await _logEvent('onboarding_conversion', {});
    await _analytics.setUserProperty(
      name: 'onboarding_converted',
      value: 'true',
    );
  }
}
