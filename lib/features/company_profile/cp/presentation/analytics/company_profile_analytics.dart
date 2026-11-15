import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
import 'package:bizzie/shared/utils/analytics_utils.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyProfileAnalytics');

@lazySingleton
class CompanyProfileAnalytics {
  final IAnalyticsService _analytics;

  // Event Names
  static const String _kEventSessionSummary = 'cp_session_summary';
  static const String _kEventEditTabs = 'cp_edit_tabs';
  static const String _kEventTourStarted = 'cp_tour_started';
  static const String _kEventTourStepViewed = 'cp_tour_step_viewed';
  static const String _kEventTourCompleted = 'cp_tour_completed';
  static const String _kEventTourSkipped = 'cp_tour_skipped';
  static const String _kEventTourRevenueGrowthBandShown =
      'cp_tour_revenue_growth_band_shown';

  // Screen Names
  static const String _kScreenName = 'company_profile';

  // Parameter Keys (Max 24 chars)
  static const String _kParamScreenName = 'screen_name';
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
  static const String _kParamAction = 'action';
  static const String _kParamMainTabs = 'main_tabs';
  static const String _kParamMoreTabs = 'more_tabs';
  static const String _kParamIsSubscribed = 'is_subscribed';
  static const String _kParamStepIndex = 'step_index';
  static const String _kParamStepName = 'step_name';
  static const String _kParamBand = 'band';
  static const String _kParamYears = 'years';
  static const String _kActionOpened = 'opened';
  static const String _kActionSaved = 'saved';
  static const String _kStepCompanyOverview = 'company_overview';
  static const String _kStepTabs = 'tabs';
  static const String _kStepRevenueTab = 'revenue_tab';
  static const String _kStepRevenueGrowth = 'revenue_growth';
  static const String _kStepStayUpdated = 'stay_updated';
  static const String _kBandNegative = 'negative';
  static const String _kBandLow = 'low';
  static const String _kBandModerate = 'moderate';
  static const String _kBandHigh = 'high';
  static const String _kBandTurnedPositive = 'turned_positive';
  static const String _kBandTurnedNegative = 'turned_negative';
  static const int _kTabNameMaxLength = 4;

  CompanyProfileAnalytics(this._analytics);

  Future<void> _logEvent(String name, [Map<String, Object>? parameters]) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {
          ...?parameters,
          _kParamScreenName: _kScreenName,
          _kParamTimestamp: DateTime.now().toIso8601String(),
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }

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
    };

    await _logEvent(_kEventSessionSummary, params);
  }

  Future<void> logEditTabsOpened({
    required String ticker,
    required bool isSubscribed,
  }) async {
    await _logEvent(_kEventEditTabs, {
      _kParamAction: _kActionOpened,
      _kParamTicker: AnalyticsUtils.truncate(ticker),
      _kParamIsSubscribed: isSubscribed,
    });
  }

  Future<void> logEditTabsSaved({
    required String ticker,
    required bool isSubscribed,
    required List<String> mainTabs,
    required List<String> moreTabs,
  }) async {
    await _logEvent(_kEventEditTabs, {
      _kParamAction: _kActionSaved,
      _kParamTicker: AnalyticsUtils.truncate(ticker),
      _kParamIsSubscribed: isSubscribed,
      _kParamMainTabs: _joinTabNames(mainTabs),
      _kParamMoreTabs: _joinTabNames(moreTabs),
    });
  }

  Future<void> logTourStarted({required String ticker}) async {
    await _logEvent(_kEventTourStarted, {
      _kParamTicker: AnalyticsUtils.truncate(ticker),
    });
  }

  Future<void> logTourStepViewed({required CompanyProfileTourStep step}) async {
    await _logEvent(_kEventTourStepViewed, {
      _kParamStepIndex: step.number,
      _kParamStepName: _tourStepName(step),
    });
  }

  Future<void> logTourCompleted({required String ticker}) async {
    await _logEvent(_kEventTourCompleted, {
      _kParamTicker: AnalyticsUtils.truncate(ticker),
    });
  }

  Future<void> logTourSkipped({required CompanyProfileTourStep step}) async {
    await _logEvent(_kEventTourSkipped, {
      _kParamStepIndex: step.number,
      _kParamStepName: _tourStepName(step),
    });
  }

  Future<void> logTourRevenueGrowthBandShown({
    required GrowthBand band,
    required int years,
  }) async {
    await _logEvent(_kEventTourRevenueGrowthBandShown, {
      _kParamBand: _growthBandName(band),
      _kParamYears: years,
    });
  }

  static String _tourStepName(CompanyProfileTourStep step) => switch (step) {
    CompanyProfileTourStep.companyOverview => _kStepCompanyOverview,
    CompanyProfileTourStep.tabs => _kStepTabs,
    CompanyProfileTourStep.revenueTab => _kStepRevenueTab,
    CompanyProfileTourStep.revenueGrowth => _kStepRevenueGrowth,
    CompanyProfileTourStep.stayUpdated => _kStepStayUpdated,
  };

  static String _growthBandName(GrowthBand band) => switch (band) {
    GrowthBand.negative => _kBandNegative,
    GrowthBand.low => _kBandLow,
    GrowthBand.moderate => _kBandModerate,
    GrowthBand.high => _kBandHigh,
    GrowthBand.turnedPositive => _kBandTurnedPositive,
    GrowthBand.turnedNegative => _kBandTurnedNegative,
  };

  static String _joinTabNames(List<String> tabs) {
    return tabs
        .map(
          (tab) => tab.length <= _kTabNameMaxLength
              ? tab
              : tab.substring(0, _kTabNameMaxLength),
        )
        .join(',');
  }
}
