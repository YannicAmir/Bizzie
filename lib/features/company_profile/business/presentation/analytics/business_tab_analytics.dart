import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'business_tab_analytics.freezed.dart';

final _logger = BizzieLogger('BusinessTabAnalytics');

@lazySingleton
class BusinessTabAnalytics
    implements CompanyProfileTabTracker<BusinessTabViewState> {
  final IAnalyticsService _analytics;

  BusinessTabAnalytics(this._analytics);

  static const _kEventSummary = 'business_tab_view_summary';

  static const _kParamScreenName = 'screen_name';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamTicker = 'ticker';
  static const _kParamLoadTimeMs = 'load_time_ms';
  static const _kParamIsSuccess = 'is_success';
  static const _kParamDataSource = 'data_source';
  static const _kParamViewDurationSec = 'view_duration_sec';
  static const _kParamTappedWebsite = 'tapped_website';
  static const _kParamTappedProxy = 'tapped_proxy';
  static const _kParamDidExpandDescription = 'did_expand_description';
  static const _kParamViewed10Ks = 'viewed_10ks';
  static const _kParamViewed10Qs = 'viewed_10qs';
  static const _kParamViewAll10KsTapped = 'view_all_10ks_tapped';
  static const _kParamViewAll10QsTapped = 'view_all_10qs_tapped';
  static const _kParamIsFinal = 'is_final';

  @override
  Future<void> logViewSummary(
    BusinessTabViewState state, {
    required bool isFinal,
  }) async {
    final params = {
      _kParamScreenName: state.screenName,
      _kParamTimestamp: state.timestamp,
      _kParamTicker: AnalyticsUtils.truncate(state.ticker),
      _kParamLoadTimeMs: state.loadTimeMs ?? 0,
      _kParamIsSuccess: state.isSuccess,
      _kParamDataSource: AnalyticsUtils.truncate(
        state.dataSource?.name ?? 'unknown',
      ),
      _kParamViewDurationSec: state.viewDurationSec,
      _kParamTappedWebsite: state.tappedWebsite,
      _kParamTappedProxy: state.tappedProxy,
      _kParamDidExpandDescription: state.didExpandDescription,
      _kParamViewed10Ks: state.viewed10Ks,
      _kParamViewed10Qs: state.viewed10Qs,
      _kParamViewAll10KsTapped: state.viewAll10KsTapped,
      _kParamViewAll10QsTapped: state.viewAll10QsTapped,
      _kParamIsFinal: isFinal,
    };

    try {
      await _analytics.logEvent(name: _kEventSummary, parameters: params);
    } catch (e, stack) {
      _logger.severe(
        'Failed to log business tab summary for ${state.ticker} (final=$isFinal)',
        e,
        stack,
      );
    }
  }
}

@freezed
abstract class BusinessTabViewState
    with _$BusinessTabViewState
    implements CompanyProfileTabAnalyticsState {
  const factory BusinessTabViewState({
    required String ticker,
    required String timestamp, // Mandatory parameter
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    CompanyProfileDataOrigin? dataSource,
    @Default(0) int viewDurationSec,
    @Default(false) bool tappedWebsite,
    @Default(false) bool tappedProxy,
    @Default(false) bool didExpandDescription,
    @Default(false) bool viewed10Ks,
    @Default(false) bool viewed10Qs,
    @Default(false) bool viewAll10KsTapped,
    @Default(false) bool viewAll10QsTapped,
  }) = _BusinessTabViewState;

  const BusinessTabViewState._();

  @override
  String get screenName => 'business_tab';

  @override
  CompanyProfileTabAnalyticsState copyWithDuration(int durationSec) =>
      copyWith(viewDurationSec: durationSec);
}
