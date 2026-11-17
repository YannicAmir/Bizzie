import 'package:bizzie/core/enums/day_of_week.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_skip_reason.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/onboarding_step_x.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('OnboardingAnalytics');

@lazySingleton
class OnboardingAnalytics {
  final IAnalyticsService _analyticsService;

  OnboardingAnalytics(this._analyticsService);

  // Screen name constant
  static const String _screenName = 'onboarding';

  static const String _kEventStepLanding = 'onb_step_landing';
  static const String _kEventStepAskName = 'onb_step_ask_name';
  static const String _kEventStepSectorSelection = 'onb_step_sector_selection';
  static const String _kEventStepBrandsSelection = 'onb_step_brands_selection';
  static const String _kEventStepNotificationsPrompt =
      'onb_step_notifications_prompt';
  static const String _kEventStepInvestingExperience =
      'onb_step_investing_experience';
  static const String _kEventStepFeatureHighlights =
      'onb_step_feature_highlights';
  static const String _kEventStepCreateAccount = 'onb_step_create_account';
  static const String _kEventStepBuildingProfile = 'onb_step_building_profile';
  static const String _kEventStepProfileReady = 'onb_step_profile_ready';
  static const String _kEventStepPaywall = 'onb_step_paywall';
  static const String _kEventStepGiftModal = 'onb_step_gift_modal';
  static const String _kEventStepDiscountPaywall = 'onb_step_discount_paywall';
  static const String _kEventStepCompanyProfile = 'onb_step_company_profile';
  static const String _kEventSignUp = 'onboarding_sign_up';
  static const String _kEventSessionSummary = 'onboarding_session_summary';
  static const String _kEventCompletionFailed = 'onb_completion_failed';
  static const String _kEventSkipped = 'onb_skipped';
  static const String _kEventInitialCompanyShown = 'onb_initial_company_shown';

  // Parameter name constants (private, snake_case)
  static const String _kParamScreenName = 'screen_name';
  static const String _kParamDayOfWeek = 'day_of_week';
  static const String _kParamStepIndex = 'step_index';
  static const String _kParamPrevDurationSec = 'prev_duration_sec';
  static const String _kParamSelectedSector = 'selected_sector';
  static const String _kParamBrandsSelectedCount = 'brands_selected_count';
  static const String _kParamExperienceSelected = 'experience_selected';
  static const String _kParamEnabledNotifications = 'enabled_notifications';
  static const String _kParamDidSubscribe = 'did_subscribe';
  static const String _kParamSubscriptionType = 'subscription_type';
  static const String _kParamErrorMessage = 'error_message';
  static const String _kParamMethod = 'method';
  static const String _kParamSessionId = 'session_id';
  static const String _kParamExitStep = 'exit_step';
  static const String _kParamTotalDurationSec = 'total_duration_sec';
  static const String _kParamDidSignup = 'did_signup';
  static const String _kParamDidSkip = 'did_skip';
  static const String _kParamSkipStep = 'skip_step';
  static const String _kParamHadAccount = 'had_account';
  static const String _kParamSectorSource = 'sector_source';
  static const String _kParamWatchlistSource = 'watchlist_source';
  static const String _kParamExperienceSource = 'experience_source';
  static const String _kParamNameSource = 'name_source';
  static const String _kParamNotificationsDecided = 'notifications_decided';
  static const String _kParamTicker = 'ticker';
  static const String _kParamTickerSource = 'ticker_source';
  static const String _kParamExitType = 'exit_type';
  static const String _kParamIsGuest = 'is_guest';
  static const String _kParamReason = 'reason';

  // Parameter value constants
  static const String _kValueSourceUser = 'user';
  static const String _kValueSourceDefault = 'default';
  static const String _kValueSourceNone = 'none';
  static const String _kValueTickerSourceUserSelection = 'user_selection';
  static const String _kValueTickerSourceRemoteDefault = 'remote_default';
  static const String _kValueTickerSourceLocalDefault = 'local_default';
  static const String _kValueTickerSourceNone = 'none';
  static const String _kValueExitTypeCompleted = 'completed';
  static const String _kValueExitTypeSkipped = 'skipped';
  static const String _kValueReasonUserSkipped = 'user_skipped';
  static const String _kValueReasonPurchased = 'purchased';

  // User property name constants
  static const String _kPropFavoriteSector = 'favorite_sector';
  static const String _kPropInvestingExperience = 'investing_experience';

  // The three highlight pages and their container step are one logical
  // funnel step, so they share one event name and index.
  static String _stepEventName(OnboardingStep step) => switch (step) {
    OnboardingStep.landing => _kEventStepLanding,
    OnboardingStep.askName => _kEventStepAskName,
    OnboardingStep.sectorSelection => _kEventStepSectorSelection,
    OnboardingStep.brandsSelection => _kEventStepBrandsSelection,
    OnboardingStep.companyProfile => _kEventStepCompanyProfile,
    OnboardingStep.notificationsPrompt => _kEventStepNotificationsPrompt,
    OnboardingStep.investingExperience => _kEventStepInvestingExperience,
    OnboardingStep.featureHighlights ||
    OnboardingStep.highlight1 ||
    OnboardingStep.highlight2 ||
    OnboardingStep.highlight3 => _kEventStepFeatureHighlights,
    OnboardingStep.createAccount => _kEventStepCreateAccount,
    OnboardingStep.buildingProfile => _kEventStepBuildingProfile,
    OnboardingStep.profileReady => _kEventStepProfileReady,
    OnboardingStep.paywall => _kEventStepPaywall,
    OnboardingStep.giftModal => _kEventStepGiftModal,
    OnboardingStep.discountPaywall => _kEventStepDiscountPaywall,
  };

  static int _stepIndex(OnboardingStep step) => switch (step) {
    OnboardingStep.landing => 1,
    OnboardingStep.sectorSelection => 2,
    OnboardingStep.brandsSelection => 3,
    OnboardingStep.companyProfile => 4,
    OnboardingStep.notificationsPrompt => 5,
    OnboardingStep.investingExperience => 6,
    OnboardingStep.askName => 7,
    OnboardingStep.featureHighlights ||
    OnboardingStep.highlight1 ||
    OnboardingStep.highlight2 ||
    OnboardingStep.highlight3 => 8,
    OnboardingStep.createAccount => 9,
    OnboardingStep.buildingProfile => 10,
    OnboardingStep.profileReady => 11,
    OnboardingStep.paywall => 12,
    OnboardingStep.giftModal => 13,
    OnboardingStep.discountPaywall => 14,
  };

  /// Logs the entry into an onboarding step as a distinct per-step event.
  ///
  /// Optional parameters describe the step the user just completed and are
  /// only attached when the caller provides them.
  Future<void> logStepViewed({
    required OnboardingStep step,
    int? prevDurationSec,
    String? selectedSector,
    int? brandsSelectedCount,
    String? experienceSelected,
    bool? notificationsEnabled,
    bool? didSubscribe,
    String? subscriptionType,
  }) async {
    await _logEvent(_stepEventName(step), {
      _kParamStepIndex: _stepIndex(step),
      if (prevDurationSec != null) _kParamPrevDurationSec: prevDurationSec,
      if (selectedSector != null) _kParamSelectedSector: selectedSector,
      if (brandsSelectedCount != null)
        _kParamBrandsSelectedCount: brandsSelectedCount,
      if (experienceSelected != null)
        _kParamExperienceSelected: experienceSelected,
      if (notificationsEnabled != null)
        _kParamEnabledNotifications: notificationsEnabled,
      if (didSubscribe != null) _kParamDidSubscribe: didSubscribe,
      if (subscriptionType != null) _kParamSubscriptionType: subscriptionType,
    });
  }

  Future<void> logSignUp({required String method}) async {
    await _logEvent(_kEventSignUp, {_kParamMethod: method});
  }

  Future<void> logCompletionFailed({required String errorMessage}) async {
    await _logEvent(_kEventCompletionFailed, {
      _kParamErrorMessage: errorMessage,
    });
  }

  Future<void> logSessionSummary(OnboardingSessionSummary summary) async {
    final sector = summary.sector;
    final experience = summary.experience;
    await _logEvent(_kEventSessionSummary, {
      _kParamSessionId: summary.sessionId,
      _kParamExitStep: summary.exitStep,
      _kParamTotalDurationSec: summary.totalDurationSeconds,
      if (sector != null) _kParamSelectedSector: sector,
      if (experience != null) _kParamExperienceSelected: experience,
      _kParamBrandsSelectedCount: summary.addedBrandsCount,
      _kParamEnabledNotifications: summary.notificationsEnabled,
      _kParamDidSignup: summary.didSignup,
      _kParamDidSkip: summary.didSkip,
    });
  }

  Future<void> logSkipped({
    required OnboardingStep step,
    required OnboardingSkipReason reason,
    required String sessionId,
    required bool hadAccount,
    required int brandsSelectedCount,
    required OnboardingFieldSources fieldSources,
    required bool notificationsDecided,
  }) async {
    await _logEvent(_kEventSkipped, {
      _kParamSkipStep: step.analyticsName,
      _kParamReason: _skipReasonValue(reason),
      _kParamStepIndex: _stepIndex(step),
      _kParamSessionId: sessionId,
      _kParamHadAccount: hadAccount,
      _kParamBrandsSelectedCount: brandsSelectedCount,
      _kParamSectorSource: _fieldSourceValue(fieldSources.sector),
      _kParamWatchlistSource: _fieldSourceValue(fieldSources.companies),
      _kParamExperienceSource: _fieldSourceValue(fieldSources.experience),
      _kParamNameSource: _fieldSourceValue(fieldSources.name),
      _kParamNotificationsDecided: notificationsDecided,
    });
  }

  Future<void> logInitialCompanyShown({
    required String ticker,
    required OnboardingValueSource tickerSource,
    required bool isSkipped,
    required bool isGuest,
  }) async {
    await _logEvent(_kEventInitialCompanyShown, {
      _kParamTicker: ticker,
      _kParamTickerSource: _tickerSourceValue(tickerSource),
      _kParamExitType: isSkipped
          ? _kValueExitTypeSkipped
          : _kValueExitTypeCompleted,
      _kParamIsGuest: isGuest,
    });
  }

  String _fieldSourceValue(OnboardingValueSource source) => switch (source) {
    OnboardingValueSource.userSelection => _kValueSourceUser,
    OnboardingValueSource.remoteDefault => _kValueSourceDefault,
    OnboardingValueSource.localDefault => _kValueSourceDefault,
    OnboardingValueSource.none => _kValueSourceNone,
  };

  String _skipReasonValue(OnboardingSkipReason reason) => switch (reason) {
    OnboardingSkipReason.userSkipped => _kValueReasonUserSkipped,
    OnboardingSkipReason.purchased => _kValueReasonPurchased,
  };

  String _tickerSourceValue(OnboardingValueSource source) => switch (source) {
    OnboardingValueSource.userSelection => _kValueTickerSourceUserSelection,
    OnboardingValueSource.remoteDefault => _kValueTickerSourceRemoteDefault,
    OnboardingValueSource.localDefault => _kValueTickerSourceLocalDefault,
    OnboardingValueSource.none => _kValueTickerSourceNone,
  };

  Future<void> setUserProperties({String? sector, String? experience}) async {
    if (sector != null) {
      await _setUserProperty(_kPropFavoriteSector, sector);
    }
    if (experience != null) {
      await _setUserProperty(_kPropInvestingExperience, experience);
    }
  }

  Future<void> resetUserProperties() async {
    await _setUserProperty(_kPropFavoriteSector, null);
    await _setUserProperty(_kPropInvestingExperience, null);
  }

  Future<void> _setUserProperty(String name, String? value) async {
    try {
      await _analyticsService.setUserProperty(name: name, value: value);
    } catch (e, stack) {
      _logger.severe('Failed to set user property: $name', e, stack);
    }
  }

  Future<void> _logEvent(String name, [Map<String, Object>? parameters]) async {
    try {
      await _analyticsService.logEvent(
        name: name,
        parameters: {
          ...?parameters,
          _kParamScreenName: _screenName,
          _kParamDayOfWeek: DayOfWeek.fromDateTime(DateTime.now()).name,
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }
}
