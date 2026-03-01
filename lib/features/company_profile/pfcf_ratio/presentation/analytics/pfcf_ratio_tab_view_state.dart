import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pfcf_ratio_tab_view_state.freezed.dart';

@freezed
abstract class PfcfRatioTabViewState
    with _$PfcfRatioTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory PfcfRatioTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool tappedChartViewAll,
    @Default(false) bool tappedTableViewAll,
  }) = _PfcfRatioTabViewState;

  const PfcfRatioTabViewState._();

  @override
  String get screenName => 'pfcf_ratio_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
