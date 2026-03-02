import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_stmt_tab_view_state.freezed.dart';

@freezed
abstract class CashStmtTabViewState
    with _$CashStmtTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory CashStmtTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedCashFlowTab,
    @Default(false) bool tappedAllCashflYrly,
    @Default(false) bool tappedAllCashflQtrly,
    @Default(false) bool switchedCashflYear,
    @Default(false) bool switchedCashflQtr,
  }) = _CashStmtTabViewState;

  const CashStmtTabViewState._();

  @override
  String get screenName => 'cash_stmt_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
