import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bal_stmt_tab_view_state.freezed.dart';

@freezed
abstract class BalStmtTabViewState
    with _$BalStmtTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory BalStmtTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedBalanceTab,
    @Default(false) bool tappedAllBalSheet,
    @Default(false) bool switchedBalancePeriod,
    @Default(false) bool viewedNetWorthChart,
    @Default(false) bool viewedCurrChart,
    @Default(false) bool viewedDebteqChart,
  }) = _BalStmtTabViewState;

  const BalStmtTabViewState._();

  @override
  String get screenName => 'bal_stmt_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
