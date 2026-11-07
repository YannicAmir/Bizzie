import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_reports_tab_view_state.freezed.dart';

@freezed
abstract class AiReportsTabViewState
    with _$AiReportsTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory AiReportsTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool viewedTenKTab,
    @Default(false) bool viewedTenQTab,
    @Default(false) bool viewedEightKTab,
    @Default(false) bool viewedRecapsTab,
    @Default(false) bool openedReport,
    @Default(false) bool openedFilingLink,
  }) = _AiReportsTabViewState;

  const AiReportsTabViewState._();

  @override
  String get screenName => 'ai_reports_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
