import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pe_ratio_tab_view_state.freezed.dart';

@freezed
abstract class PeRatioTabViewState
    with _$PeRatioTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory PeRatioTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool tappedChartViewAll,
    @Default(false) bool tappedTableViewAll,
  }) = _PeRatioTabViewState;

  const PeRatioTabViewState._();

  @override
  String get screenName => 'pe_ratio_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
