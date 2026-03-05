import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/analytics/revenue_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('RevenueTabAnalytics');

@lazySingleton
class RevenueTabAnalytics
    implements CompanyProfileTabTracker<RevenueTabViewState> {
  final IAnalyticsService _analytics;

  RevenueTabAnalytics(this._analytics);

  static const _kEventSummary = 'revenue_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamViewedYearlyRevTab = 'viewed_yearly_rev_tab';
  static const _kParamViewedQtrlyRevTab = 'viewed_qtrly_rev_tab';
  static const _kParamTappedQtrchartViewAll = 'tapped_qtrchart_view_all';
  static const _kParamTappedYrchartViewAll = 'tapped_yrchart_view_all';
  static const _kParamTappedQtrtableViewAll = 'tapped_qtrtable_view_all';
  static const _kParamTappedYrtableViewAll = 'tapped_yrtable_view_all';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    RevenueTabViewState state, {
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
      _kParamViewedYearlyRevTab: state.viewedYearlyRevTab,
      _kParamViewedQtrlyRevTab: state.viewedQtrlyRevTab,
      _kParamTappedQtrchartViewAll: state.tappedQtrchartViewAll,
      _kParamTappedYrchartViewAll: state.tappedYrchartViewAll,
      _kParamTappedQtrtableViewAll: state.tappedQtrtableViewAll,
      _kParamTappedYrtableViewAll: state.tappedYrtableViewAll,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log revenue tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
