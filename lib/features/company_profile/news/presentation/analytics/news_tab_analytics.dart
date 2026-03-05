import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/news/presentation/analytics/news_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('NewsTabAnalytics');

@lazySingleton
class NewsTabAnalytics implements CompanyProfileTabTracker<NewsTabViewState> {
  final IAnalyticsService _analytics;

  NewsTabAnalytics(this._analytics);

  static const _kEventSummary = 'news_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamFeaturedArticleTapped = 'featured_article_tapped';
  static const _kParamNormalArticleTapped = 'normal_article_tapped';
  static const _kParamRefreshTriggeredCount = 'refresh_triggered_count';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    NewsTabViewState state, {
    required bool isFinal,
  }) async {
    final params = {
      _kParamScreenName: state.screenName,
      _kParamTicker: AnalyticsUtils.truncate(state.ticker),
      _kParamTimestamp: state.timestamp,
      _kParamLoadTimeMs: state.loadTimeMs ?? 0,
      _kParamIsSuccess: state.isSuccess,
      _kParamDataSource: AnalyticsUtils.truncate(
        state.dataSource?.name ?? 'unknown',
      ),
      _kParamViewDurationSec: state.viewDurationSec,
      _kParamFeaturedArticleTapped: state.featuredArticleTapped,
      _kParamNormalArticleTapped: state.normalArticleTapped,
      _kParamRefreshTriggeredCount: state.refreshTriggeredCount,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log news tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
