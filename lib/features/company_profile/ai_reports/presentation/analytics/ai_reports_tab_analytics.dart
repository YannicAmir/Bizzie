import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('AiReportsTabAnalytics');

@lazySingleton
class AiReportsTabAnalytics
    implements CompanyProfileTabTracker<AiReportsTabViewState> {
  final IAnalyticsService _analytics;

  AiReportsTabAnalytics(this._analytics);

  static const _kEventSummary = 'ai_reports_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamViewedTenKTab = 'viewed_10k_tab';
  static const _kParamViewedTenQTab = 'viewed_10q_tab';
  static const _kParamViewedEightKTab = 'viewed_8k_tab';
  static const _kParamViewedRecapsTab = 'viewed_recaps_tab';
  static const _kParamOpenedReport = 'opened_report';
  static const _kParamOpenedFilingLink = 'opened_filing_link';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    AiReportsTabViewState state, {
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
      _kParamViewedTenKTab: state.viewedTenKTab,
      _kParamViewedTenQTab: state.viewedTenQTab,
      _kParamViewedEightKTab: state.viewedEightKTab,
      _kParamViewedRecapsTab: state.viewedRecapsTab,
      _kParamOpenedReport: state.openedReport,
      _kParamOpenedFilingLink: state.openedFilingLink,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log AI reports tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
