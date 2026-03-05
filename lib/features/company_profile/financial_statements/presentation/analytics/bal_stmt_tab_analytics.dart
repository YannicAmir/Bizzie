import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('BalStmtTabAnalytics');

@lazySingleton
class BalStmtTabAnalytics
    implements CompanyProfileTabTracker<BalStmtTabViewState> {
  final IAnalyticsService _analytics;

  BalStmtTabAnalytics(this._analytics);

  static const _kEventSummary = 'bal_sheet_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTicker = 'ticker';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'balance_view_duration';
  static const _kParamViewedBalanceTab = 'viewed_balance_tab';
  static const _kParamTappedAllBalSheet = 'tapped_all_bal_sheet';
  static const _kParamSwitchedBalancePeriod = 'switched_balance_period';
  static const _kParamViewedNetWorthChart = 'viewed_net_worth_chart';
  static const _kParamViewedCurrChart = 'viewed_curr_chart';
  static const _kParamViewedDebteqChart = 'viewed_debteq_chart';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    BalStmtTabViewState state, {
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
      _kParamViewedBalanceTab: state.viewedBalanceTab,
      _kParamTappedAllBalSheet: state.tappedAllBalSheet,
      _kParamSwitchedBalancePeriod: state.switchedBalancePeriod,
      _kParamViewedNetWorthChart: state.viewedNetWorthChart,
      _kParamViewedCurrChart: state.viewedCurrChart,
      _kParamViewedDebteqChart: state.viewedDebteqChart,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log balance sheet tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}
