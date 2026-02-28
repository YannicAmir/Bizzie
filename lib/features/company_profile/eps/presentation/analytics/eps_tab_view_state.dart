import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eps_tab_view_state.freezed.dart';

@freezed
abstract class EpsTabViewState
    with _$EpsTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory EpsTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedYearlyEpsTab,
    @Default(false) bool viewedQtrlyEpsTab,
    @Default(false) bool tappedQtrchartViewAll,
    @Default(false) bool tappedYrchartViewAll,
    @Default(false) bool tappedQtrtableViewAll,
    @Default(false) bool tappedYrtableViewAll,
  }) = _EpsTabViewState;

  const EpsTabViewState._();

  @override
  String get screenName => 'eps_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
