import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shares_tab_view_state.freezed.dart';

@freezed
abstract class SharesTabViewState
    with _$SharesTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory SharesTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedYearlySharesTab,
    @Default(false) bool viewedQtrlySharesTab,
    @Default(false) bool tappedQtrchartViewAll,
    @Default(false) bool tappedYrchartViewAll,
    @Default(false) bool tappedQtrtableViewAll,
    @Default(false) bool tappedYrtableViewAll,
  }) = _SharesTabViewState;

  const SharesTabViewState._();

  @override
  String get screenName => 'shares_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
