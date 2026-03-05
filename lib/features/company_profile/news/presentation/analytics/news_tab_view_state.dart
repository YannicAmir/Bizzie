import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_tab_view_state.freezed.dart';

@freezed
abstract class NewsTabViewState
    with _$NewsTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory NewsTabViewState({
    required String ticker,
    required String timestamp,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool featuredArticleTapped,
    @Default(false) bool normalArticleTapped,
    @Default(0) int refreshTriggeredCount,
  }) = _NewsTabViewState;

  const NewsTabViewState._();

  @override
  String get screenName => 'news_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
