import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';
import 'fcps_tab_view_state.dart';

final _logger = BizzieLogger('FcpsTabAnalytics');

@lazySingleton
class FcpsTabAnalytics implements CompanyProfileTabTracker<FcpsTabViewState> {
  final IAnalyticsService _analytics;

  FcpsTabAnalytics(this._analytics);

  static const _kEventSummary = 'fcps_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamViewedYearlyFcpsTab = 'viewed_yearly_fcps_tab';
  static const _kParamViewedQtrlyFcpsTab = 'viewed_qtrly_fcps_tab';
  static const _kParamTappedQtrchartViewAll = 'tapped_qtrchart_view_all';
  static const _kParamTappedYrchartViewAll = 'tapped_yrchart_view_all';
  static const _kParamTappedQtrtableViewAll = 'tapped_qtrtable_view_all';
  static const _kParamTappedYrtableViewAll = 'tapped_yrtable_view_all';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    FcpsTabViewState state, {
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
      _kParamViewedYearlyFcpsTab: state.viewedYearlyFcpsTab,
      _kParamViewedQtrlyFcpsTab: state.viewedQtrlyFcpsTab,
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
        'Failed to log fcps tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
