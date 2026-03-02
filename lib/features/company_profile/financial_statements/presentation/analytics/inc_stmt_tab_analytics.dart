import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('IncStmtTabAnalytics');

@lazySingleton
class IncStmtTabAnalytics
    implements CompanyProfileTabTracker<IncStmtTabViewState> {
  final IAnalyticsService _analytics;

  IncStmtTabAnalytics(this._analytics);

  static const _kEventSummary = 'inc_stmt_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'income_view_duration';
  static const _kParamViewedIncomeTab = 'viewed_income_tab';
  static const _kParamTappedAllIncomeYrly = 'tapped_all_income_yrly';
  static const _kParamTappedAllIncomeQtrly = 'tapped_all_income_qtrly';
  static const _kParamSwitchedIncomeYear = 'switched_income_year';
  static const _kParamSwitchedIncomeQtr = 'switched_income_qtr';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    IncStmtTabViewState state, {
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
      _kParamViewedIncomeTab: state.viewedIncomeTab,
      _kParamTappedAllIncomeYrly: state.tappedAllIncomeYrly,
      _kParamTappedAllIncomeQtrly: state.tappedAllIncomeQtrly,
      _kParamSwitchedIncomeYear: state.switchedIncomeYear,
      _kParamSwitchedIncomeQtr: state.switchedIncomeQtr,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log income statement tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
