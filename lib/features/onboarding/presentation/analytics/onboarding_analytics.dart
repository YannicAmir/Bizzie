import 'package:bizzie/core/enums/day_of_week.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_session_summary.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('OnboardingAnalytics');

@lazySingleton
class OnboardingAnalytics {
  final IAnalyticsService _analyticsService;

  OnboardingAnalytics(this._analyticsService);

  // Screen name constant
  static const String _screenName = 'onboarding';

  static const String _kEventStepLanding = 'onb_step_01_landing';
  static const String _kEventStepAskName = 'onb_step_02_ask_name';
  static const String _kEventStepGladYouJoined = 'onb_step_03_glad_you_joined';
  static const String _kEventStepSectorSelection =
      'onb_step_04_sector_selection';
  static const String _kEventStepMeetYourBizzie =
      'onb_step_05_meet_your_bizzie';
  static const String _kEventStepBrandsSelection =
      'onb_step_06_brands_selection';
  static const String _kEventStepAnalyzingBrands =
      'onb_step_07_analyzing_brands';
  static const String _kEventStepCompaniesFound =
      'onb_step_08_companies_found';
  static const String _kEventStepAddingToWatchlist =
      'onb_step_09_adding_to_watchlist';
  static const String _kEventStepNotificationsPrompt =
      'onb_step_10_notifications_prompt';
  static const String _kEventStepInvestingExperience =
      'onb_step_11_investing_experience';
  static const String _kEventStepFeatureHighlights =
      'onb_step_12_feature_highlights';
  static const String _kEventStepCreateAccount = 'onb_step_13_create_account';
  static const String _kEventStepBuildingProfile =
      'onb_step_14_building_profile';
  static const String _kEventStepProfileReady = 'onb_step_15_profile_ready';
  static const String _kEventStepPaywall = 'onb_step_16_paywall';
  static const String _kEventStepGiftModal = 'onb_step_17_gift_modal';
  static const String _kEventStepDiscountPaywall =
      'onb_step_18_discount_paywall';
  static const String _kEventSignUp = 'onboarding_sign_up';
  static const String _kEventSessionSummary = 'onboarding_session_summary';
  static const String _kEventCompletionFailed = 'onb_completion_failed';

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
  static const String _kParamHighlightsSkipped = 'highlights_skipped';
  static const String _kParamErrorMessage = 'error_message';
  static const String _kParamMethod = 'method';
  static const String _kParamSessionId = 'session_id';
  static const String _kParamExitStep = 'exit_step';
  static const String _kParamTotalDurationSec = 'total_duration_sec';
  static const String _kParamDidSignup = 'did_signup';

  // User property name constants
  static const String _kPropFavoriteSector = 'favorite_sector';
  static const String _kPropInvestingExperience = 'investing_experience';

  // The three highlight pages and their container step are one logical
  // funnel step, so they share one event name and index.
  static const Map<OnboardingStep, String> _stepEventNames = {
    OnboardingStep.landing: _kEventStepLanding,
    OnboardingStep.askName: _kEventStepAskName,
    OnboardingStep.gladYouJoined: _kEventStepGladYouJoined,
    OnboardingStep.sectorSelection: _kEventStepSectorSelection,
    OnboardingStep.meetYourBizzie: _kEventStepMeetYourBizzie,
    OnboardingStep.brandsSelection: _kEventStepBrandsSelection,
    OnboardingStep.analyzingSelectedBrands: _kEventStepAnalyzingBrands,
    OnboardingStep.companiesFound: _kEventStepCompaniesFound,
    OnboardingStep.addingToWatchlist: _kEventStepAddingToWatchlist,
    OnboardingStep.notificationsPrompt: _kEventStepNotificationsPrompt,
    OnboardingStep.investingExperience: _kEventStepInvestingExperience,
    OnboardingStep.featureHighlights: _kEventStepFeatureHighlights,
    OnboardingStep.highlight1: _kEventStepFeatureHighlights,
    OnboardingStep.highlight2: _kEventStepFeatureHighlights,
    OnboardingStep.highlight3: _kEventStepFeatureHighlights,
    OnboardingStep.createAccount: _kEventStepCreateAccount,
    OnboardingStep.buildingProfile: _kEventStepBuildingProfile,
    OnboardingStep.profileReady: _kEventStepProfileReady,
    OnboardingStep.paywall: _kEventStepPaywall,
    OnboardingStep.giftModal: _kEventStepGiftModal,
    OnboardingStep.discountPaywall: _kEventStepDiscountPaywall,
  };

  static const Map<OnboardingStep, int> _stepIndexes = {
    OnboardingStep.landing: 1,
    OnboardingStep.askName: 2,
    OnboardingStep.gladYouJoined: 3,
    OnboardingStep.sectorSelection: 4,
    OnboardingStep.meetYourBizzie: 5,
    OnboardingStep.brandsSelection: 6,
    OnboardingStep.analyzingSelectedBrands: 7,
    OnboardingStep.companiesFound: 8,
    OnboardingStep.addingToWatchlist: 9,
    OnboardingStep.notificationsPrompt: 10,
    OnboardingStep.investingExperience: 11,
    OnboardingStep.featureHighlights: 12,
    OnboardingStep.highlight1: 12,
    OnboardingStep.highlight2: 12,
    OnboardingStep.highlight3: 12,
    OnboardingStep.createAccount: 13,
    OnboardingStep.buildingProfile: 14,
    OnboardingStep.profileReady: 15,
    OnboardingStep.paywall: 16,
    OnboardingStep.giftModal: 17,
    OnboardingStep.discountPaywall: 18,
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
    bool? highlightsSkipped,
  }) async {
    final eventName = _stepEventNames[step];
    final stepIndex = _stepIndexes[step];
    if (eventName == null || stepIndex == null) {
      _logger.warning('No analytics mapping for onboarding step: $step');
      return;
    }

    await _logEvent(eventName, {
      _kParamStepIndex: stepIndex,
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
      if (highlightsSkipped != null)
        _kParamHighlightsSkipped: highlightsSkipped,
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
      _kParamHighlightsSkipped: summary.highlightsSkipped,
      _kParamDidSignup: summary.didSignup,
    });
  }

  Future<void> setUserProperties({String? sector, String? experience}) async {
    if (sector != null) {
      await _analyticsService.setUserProperty(
        name: _kPropFavoriteSector,
        value: sector,
      );
    }
    if (experience != null) {
      await _analyticsService.setUserProperty(
        name: _kPropInvestingExperience,
        value: experience,
      );
    }
  }

  Future<void> resetUserProperties() async {
    await _analyticsService.setUserProperty(
      name: _kPropFavoriteSector,
      value: null,
    );
    await _analyticsService.setUserProperty(
      name: _kPropInvestingExperience,
      value: null,
    );
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
