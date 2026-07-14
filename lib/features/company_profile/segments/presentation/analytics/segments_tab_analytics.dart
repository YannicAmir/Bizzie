import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SegmentsTabAnalytics');

@lazySingleton
class SegmentsTabAnalytics
    implements CompanyProfileTabTracker<SegmentsTabViewState> {
  final IAnalyticsService _analytics;

  SegmentsTabAnalytics(this._analytics);

  static const _kEventSummary = 'segments_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamViewedYearlySegTab = 'viewed_yearly_seg_tab';
  static const _kParamViewedQtrlySegTab = 'viewed_qtrly_seg_tab';
  static const _kParamChangedYrDate = 'changed_yr_date';
  static const _kParamChangedQtrDate = 'changed_qtr_date';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    SegmentsTabViewState state, {
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
      _kParamViewedYearlySegTab: state.viewedYearlySegTab,
      _kParamViewedQtrlySegTab: state.viewedQtrlySegTab,
      _kParamChangedYrDate: state.changedYrDate,
      _kParamChangedQtrDate: state.changedQtrDate,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log segments tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
