import 'package:bizzie/core/enums/day_of_week.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OnboardingAnalytics {
  final IAnalyticsService _analyticsService;

  OnboardingAnalytics(this._analyticsService);

  void logStep({
    required String stepName,
    int? durationSec,
    String? errorMessage,
    Map<String, Object?>? extraParams,
  }) {
    final normalizedStepName = _getNormalizedStepName(stepName);

    final params = <String, Object?>{'step_name': normalizedStepName};

    if (durationSec != null) {
      params['duration_sec'] = durationSec;
    }

    if (errorMessage != null) {
      params['error_message'] = errorMessage;
    }

    if (extraParams != null) {
      params.addAll(extraParams);
    }

    _logEvent('onboarding_step_logged', params);
  }

  void logSignUp({required String method}) {
    _logEvent('onboarding_sign_up', {'method': method});
  }

  void logSessionSummary(OnboardingSessionSummary summary) {
    _logEvent(
      'onboarding_session_summary',
      Map<String, Object?>.from(summary.toJson()),
    );
  }

  void setUserProperties({String? sector, String? experience}) {
    if (sector != null) {
      _analyticsService.setUserProperty(name: 'favorite_sector', value: sector);
    }
    if (experience != null) {
      _analyticsService.setUserProperty(
        name: 'investing_experience',
        value: experience,
      );
    }
  }

  void resetUserProperties() {
    _analyticsService.setUserProperty(name: 'favorite_sector', value: null);
    _analyticsService.setUserProperty(
      name: 'investing_experience',
      value: null,
    );
  }

  void _logEvent(String name, Map<String, Object?> params) {
    final enrichedParams = Map<String, Object?>.from(params);
    enrichedParams['day_of_week'] = DayOfWeek.fromDateTime(DateTime.now()).name;
    enrichedParams['timestamp'] = DateTime.now().toIso8601String();
    _analyticsService.logEvent(name: name, parameters: enrichedParams);
  }

  static final _camelCaseRegex = RegExp(r'[A-Z]');

  static const _overrides = <String, String>{
    'highlight1': 'feature_highlights',
    'highlight2': 'feature_highlights',
    'highlight3': 'feature_highlights',
    'featureHighlights': 'feature_highlights',
    'analyzingSelectedBrands': 'analyzing_brands',
  };

  String _getNormalizedStepName(String stepName) {
    if (_overrides.containsKey(stepName)) {
      return _overrides[stepName]!;
    }

    return stepName.replaceAllMapped(
      _camelCaseRegex,
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
  }
}
