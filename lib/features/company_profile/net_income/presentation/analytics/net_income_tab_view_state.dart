import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'net_income_tab_view_state.freezed.dart';

@freezed
abstract class NetIncomeTabViewState
    with _$NetIncomeTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory NetIncomeTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedYearlyNetTab,
    @Default(false) bool viewedQtrlyNetTab,
    @Default(false) bool tappedQtrchartViewAll,
    @Default(false) bool tappedYrchartViewAll,
    @Default(false) bool tappedQtrtableViewAll,
    @Default(false) bool tappedYrtableViewAll,
  }) = _NetIncomeTabViewState;

  const NetIncomeTabViewState._();

  @override
  String get screenName => 'net_income_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
