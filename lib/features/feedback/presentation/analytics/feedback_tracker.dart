import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class FeedbackTracker {
  final IAnalyticsService _analytics;

  const FeedbackTracker(this._analytics);

  static const _kScreenName = 'feedback_modal';

  /// Logs when the feedback modal is viewed.
  Future<void> logFeedbackViewed({String? intentSource}) async {
    await _analytics.logEvent(
      name: 'feedback_viewed',
      parameters: {
        'screen_name': _kScreenName,
        if (intentSource != null) 'intent_source': intentSource,
      },
    );
  }

  /// Logs when the feedback modal is closed without submission.
  Future<void> logFeedbackAbandoned({
    required bool hasTyped,
    required int messageLength,
  }) async {
    await _analytics.logEvent(
      name: 'feedback_abandoned',
      parameters: {
        'has_typed': hasTyped,
        'message_length': messageLength,
        'screen_name': _kScreenName,
      },
    );
  }

  /// Updates the total feedback count user property.
  Future<void> setTotalFeedbackCount(int count) async {
    await _analytics.setUserProperty(
      name: 'total_feedback_count',
      value: count.toString(),
    );
  }

  /// Logs when feedback is successfully submitted.
  Future<void> logFeedbackSubmitted({required int messageLength}) async {
    await _analytics.logEvent(
      name: 'feedback_submitted',
      parameters: {
        'message_length': messageLength,
        'screen_name': _kScreenName,
      },
    );
  }

  /// Logs when feedback submission fails.
  Future<void> logFeedbackFailed({required String error}) async {
    await _analytics.logEvent(
      name: 'feedback_failed',
      parameters: {'error_description': error, 'screen_name': _kScreenName},
    );
  }

  /// Logs when a user attempts to submit feedback during the cooldown period.
  Future<void> logFeedbackCooldownHit() async {
    await _analytics.logEvent(
      name: 'feedback_cooldown_hit',
      parameters: {'screen_name': _kScreenName},
    );
  }
}
