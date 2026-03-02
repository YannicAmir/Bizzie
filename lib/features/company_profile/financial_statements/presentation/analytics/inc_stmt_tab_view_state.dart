import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inc_stmt_tab_view_state.freezed.dart';

@freezed
abstract class IncStmtTabViewState
    with _$IncStmtTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory IncStmtTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedIncomeTab,
    @Default(false) bool tappedAllIncomeYrly,
    @Default(false) bool tappedAllIncomeQtrly,
    @Default(false) bool switchedIncomeYear,
    @Default(false) bool switchedIncomeQtr,
  }) = _IncStmtTabViewState;

  const IncStmtTabViewState._();

  @override
  String get screenName => 'inc_stmt_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
