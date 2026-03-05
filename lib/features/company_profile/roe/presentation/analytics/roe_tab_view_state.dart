import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roe_tab_view_state.freezed.dart';

@freezed
abstract class RoeTabViewState
    with _$RoeTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory RoeTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool tappedChartViewAll,
    @Default(false) bool tappedTableViewAll,
  }) = _RoeTabViewState;

  const RoeTabViewState._();

  @override
  String get screenName => 'roe_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
