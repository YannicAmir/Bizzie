import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcps_tab_view_state.freezed.dart';

@freezed
abstract class FcpsTabViewState
    with _$FcpsTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory FcpsTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedYearlyFcpsTab,
    @Default(false) bool viewedQtrlyFcpsTab,
    @Default(false) bool tappedQtrchartViewAll,
    @Default(false) bool tappedYrchartViewAll,
    @Default(false) bool tappedQtrtableViewAll,
    @Default(false) bool tappedYrtableViewAll,
  }) = _FcpsTabViewState;

  const FcpsTabViewState._();

  @override
  String get screenName => 'fcps_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
