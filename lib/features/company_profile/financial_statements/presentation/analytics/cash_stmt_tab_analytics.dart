import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CashStmtTabAnalytics');

@lazySingleton
class CashStmtTabAnalytics
    implements CompanyProfileTabTracker<CashStmtTabViewState> {
  final IAnalyticsService _analytics;

  CashStmtTabAnalytics(this._analytics);

  static const _kEventSummary = 'cash_stmt_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'cashfl_view_duration';
  static const _kParamViewedCashFlowTab = 'viewed_cash_flow_tab';
  static const _kParamTappedAllCashflYrly = 'tapped_all_cashfl_yrly';
  static const _kParamTappedAllCashflQtrly = 'tapped_all_cashfl_qtrly';
  static const _kParamSwitchedCashflYear = 'switched_cashfl_year';
  static const _kParamSwitchedCashflQtr = 'switched_cashfl_qtr';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    CashStmtTabViewState state, {
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
      _kParamViewedCashFlowTab: state.viewedCashFlowTab,
      _kParamTappedAllCashflYrly: state.tappedAllCashflYrly,
      _kParamTappedAllCashflQtrly: state.tappedAllCashflQtrly,
      _kParamSwitchedCashflYear: state.switchedCashflYear,
      _kParamSwitchedCashflQtr: state.switchedCashflQtr,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log cash flow statement tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
