import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_cash_flow_tab_view_state.freezed.dart';

@freezed
abstract class FreeCashFlowTabViewState
    with _$FreeCashFlowTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory FreeCashFlowTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedYearlyFcfTab,
    @Default(false) bool viewedQtrlyFcfTab,
    @Default(false) bool tappedQtrchartViewAll,
    @Default(false) bool tappedYrchartViewAll,
    @Default(false) bool tappedQtrtableViewAll,
    @Default(false) bool tappedYrtableViewAll,
  }) = _FreeCashFlowTabViewState;

  const FreeCashFlowTabViewState._();

  @override
  String get screenName => 'free_cash_flow_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
