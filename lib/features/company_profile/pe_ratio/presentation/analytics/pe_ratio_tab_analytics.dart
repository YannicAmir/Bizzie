import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';
import 'pe_ratio_tab_view_state.dart';

final _logger = BizzieLogger('PeRatioTabAnalytics');

@lazySingleton
class PeRatioTabAnalytics
    implements CompanyProfileTabTracker<PeRatioTabViewState> {
  final IAnalyticsService _analytics;

  PeRatioTabAnalytics(this._analytics);

  static const _kEventSummary = 'pe_ratio_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamTappedChartViewAll = 'tapped_chart_view_all';
  static const _kParamTappedTableViewAll = 'tapped_table_view_all';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    PeRatioTabViewState state, {
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
      _kParamTappedChartViewAll: state.tappedChartViewAll,
      _kParamTappedTableViewAll: state.tappedTableViewAll,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log pe ratio tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
