import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'security_tab_analytics.freezed.dart';

final _logger = BizzieLogger('SecurityTabAnalytics');

@lazySingleton
class SecurityTabAnalytics
    implements CompanyProfileTabTracker<SecurityTabViewState> {
  final IAnalyticsService _analytics;

  SecurityTabAnalytics(this._analytics);

  static const _kEventSummary = 'security_tab_view_summary';

  static const _kParamTicker = 'ticker';
  static const _kParamScreenName = 'screen_name';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamPriceLoadMs = 'price_load_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamIsPriceSuccess = 'is_price_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamHasUpcomingEarnings = 'has_upcoming_earnings';
  static const _kParamEarningsDaysAway = 'earnings_days_away';
  static const _kParamPriceChartChangeCount = 'price_chart_change_count';
  static const _kParamFinalPriceTimeframe = 'final_price_timeframe';
  static const _kParamSecurityType = 'security_type';
  static const _kParamIsFinal = 'is_final';
  static const _kParamTimestamp = 'timestamp';

  @override
  Future<void> logViewSummary(
    SecurityTabViewState state, {
    required bool isFinal,
  }) async {
    final params = {
      _kParamTicker: AnalyticsUtils.truncate(state.ticker),
      _kParamScreenName: state.screenName,
      _kParamLoadTimeMs: state.loadTimeMs ?? 0,
      _kParamPriceLoadMs: state.priceLoadMs ?? 0,
      _kParamIsSuccess: state.isSuccess,
      _kParamIsPriceSuccess: state.isPriceSuccess,
      _kParamDataSource: AnalyticsUtils.truncate(
        state.dataSource?.name ?? 'unknown',
      ),
      _kParamViewDurationSec: state.viewDurationSec,
      _kParamHasUpcomingEarnings: state.hasUpcomingEarnings,
      if (state.earningsDaysAway != null)
        _kParamEarningsDaysAway: state.earningsDaysAway!,
      _kParamPriceChartChangeCount: state.priceChartChangeCount,
      _kParamFinalPriceTimeframe: AnalyticsUtils.truncate(
        state.finalPriceTimeframe,
      ),
      _kParamSecurityType: AnalyticsUtils.truncate(state.securityType),
      _kParamIsFinal: isFinal,
      _kParamTimestamp: state.timestamp,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log security tab summary for ${state.ticker}',
        e,
        stack,
      );
    }
  }
}

@freezed
abstract class SecurityTabViewState
    with _$SecurityTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory SecurityTabViewState({
    required String ticker,
    required String securityType,
    required String timestamp,
    int? loadTimeMs,
    int? priceLoadMs,
    @Default(false) bool isSuccess,
    @Default(false) bool isPriceSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool hasUpcomingEarnings,
    String? earningsDaysAway,
    @Default(0) int priceChartChangeCount,
    @Default('1D') String finalPriceTimeframe,
  }) = _SecurityTabViewState;

  const SecurityTabViewState._();

  @override
  String get screenName => 'security_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
