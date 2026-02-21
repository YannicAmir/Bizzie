import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyProfileAnalytics');

@lazySingleton
class CompanyProfileAnalytics {
  final IAnalyticsService _analytics;

  // Event Names
  static const String _kEventSessionSummary = 'cp_session_summary';

  // Screen Names
  static const String kScreenCompanyProfile = 'company_profile';

  // Parameter Keys (Max 24 chars)
  static const String _kParamSessionId = 'session_id';
  static const String _kParamTicker = 'ticker';
  static const String _kParamCoName = 'co_name';
  static const String _kParamIndustry = 'industry';
  static const String _kParamSector = 'sector';
  static const String _kParamTabsCount = 'tabs_count';
  static const String _kParamTabsList = 'tabs_list';
  static const String _kParamDurationSec = 'duration_sec';
  static const String _kParamIsWatchlisted = 'is_watchlisted';
  static const String _kParamInitWatchlisted = 'init_watchlisted';
  static const String _kParamIsCompany = 'is_company';
  static const String _kParamIsEtf = 'is_etf';
  static const String _kParamIsFund = 'is_fund';
  static const String _kParamIsFinal = 'is_final';
  static const String _kParamTimestamp = 'timestamp';

  CompanyProfileAnalytics(this._analytics);

  /// Logs a comprehensive session summary.
  /// This is called on background (snapshot) and exit (final).
  Future<void> logSessionSummary(CompanyProfileSessionSummary summary) async {
    final tabsString = summary.tabsList.map(AnalyticsUtils.truncate).join(',');

    final params = {
      _kParamSessionId: summary.sessionId,
      _kParamTicker: AnalyticsUtils.truncate(summary.ticker),
      _kParamCoName: AnalyticsUtils.truncate(summary.companyName),
      if (summary.industry != null)
        _kParamIndustry: AnalyticsUtils.truncate(summary.industry!),
      if (summary.sector != null)
        _kParamSector: AnalyticsUtils.truncate(summary.sector!),
      _kParamTabsCount: summary.tabsCount,
      _kParamTabsList: AnalyticsUtils.truncate(tabsString),
      _kParamDurationSec: summary.durationSeconds,
      _kParamIsWatchlisted: summary.isWatchlisted,
      _kParamInitWatchlisted: summary.initWatchlisted,
      _kParamIsCompany: summary.isCompany,
      _kParamIsEtf: summary.isEtf,
      _kParamIsFund: summary.isFund,
      _kParamIsFinal: summary.isFinal,
      _kParamTimestamp: DateTime.now().toIso8601String(),
    };

    try {
      await _analytics.logEvent(
        name: _kEventSessionSummary,
        parameters: params,
      );
    } catch (e, stack) {
      _logger.severe(
        'Failed to log session summary: ${summary.ticker}',
        e,
        stack,
      );
    }
  }
}
