import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dividend_tab_view_state.freezed.dart';

@freezed
abstract class DividendTabViewState
    with _$DividendTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory DividendTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool tappedChartViewAll,
    @Default(false) bool tappedTableViewAll,
  }) = _DividendTabViewState;

  const DividendTabViewState._();

  @override
  String get screenName => 'dividends_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
