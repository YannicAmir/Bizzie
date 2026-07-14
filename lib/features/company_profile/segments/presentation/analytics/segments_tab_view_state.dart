import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'segments_tab_view_state.freezed.dart';

@freezed
abstract class SegmentsTabViewState
    with _$SegmentsTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory SegmentsTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedYearlySegTab,
    @Default(false) bool viewedQtrlySegTab,
    @Default(false) bool changedYrDate,
    @Default(false) bool changedQtrDate,
  }) = _SegmentsTabViewState;

  const SegmentsTabViewState._();

  @override
  String get screenName => 'segments_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
