import 'package:bizzie/core/analytics/models/app_rating_prompt_context.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

enum AppRatingJourneyStatus { inProgress, completed, maxAttemptsReached }

@injectable
class AppRatingsTracker {
  final IAnalyticsService _analytics;

  AppRatingsTracker(this._analytics);

  static const _kScreenName = 'company_profile';

  Future<void> updateJourneyStatus(AppRatingJourneyStatus status) async {
    final value = switch (status) {
      AppRatingJourneyStatus.inProgress => 'in_progress',
      AppRatingJourneyStatus.completed => 'completed',
      AppRatingJourneyStatus.maxAttemptsReached => 'max_attempts_reached',
    };

    await _analytics.setUserProperty(name: 'app_rating_status', value: value);
  }

  Future<void> logInteraction({
    required String ticker,
    required int count,
  }) async {
    await _analytics.logEvent(
      name: 'app_rating_interaction',
      parameters: {
        'screen_name': _kScreenName,
        'ticker': ticker,
        'interaction_count': count,
      },
    );
  }

  Future<void> logPromptShown({required AppRatingPromptContext context}) async {
    await _analytics.logEvent(
      name: 'app_rating_prompt_shown',
      parameters: context.toMap(_kScreenName),
    );
  }

  Future<void> logMaxAttemptsReached({
    required String ticker,
    required int attempts,
  }) async {
    await _analytics.logEvent(
      name: 'app_rating_max_attempts_reached',
      parameters: {
        'screen_name': _kScreenName,
        'ticker': ticker,
        'prompt_attempts': attempts,
      },
    );
  }
}
