import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('PaywallAnalytics');

@lazySingleton
class PaywallAnalytics {
  final IAnalyticsService _analytics;

  PaywallAnalytics(this._analytics);

  // Screen Names
  static const _kScreenName = 'paywall';

  // Event Names
  static const _kEventTriggered = 'paywall_triggered';
  static const _kEventGiftViewed = 'paywall_gift_viewed';
  static const _kEventGiftClaimed = 'paywall_gift_claimed';
  static const _kEventGiftDismissed = 'paywall_gift_dismissed';
  static const _kEventConversion = 'paywall_conversion';
  static const _kEventPurchaseSuccess = 'paywall_purchase_success';
  static const _kEventTrialStarted = 'paywall_trial_started';
  static const _kEventDismissed = 'paywall_dismissed';
  static const _kEventRestoreRequested = 'paywall_restore_requested';

  // Parameter Keys
  static const _kParamScreenName = 'screen_name';
  static const _kParamTimestamp = 'timestamp';
  static const _kParamSource = 'source';
  static const _kParamPaywallType = 'paywall_type';
  static const _kParamIsDiscountFlow = 'is_discount_flow';
  static const _kParamIsTrial = 'is_trial';
  static const _kParamValue = 'value';
  static const _kParamCurrency = 'currency';
  static const _kParamPeriodType = 'period_type';
  static const _kParamProductId = 'product_id';
  static const _kParamSubscriptionType = 'subscription_type';

  // User Properties
  static const _kPropLastPaywallSource = 'last_paywall_source';
  static const _kPropFirstPaywallSource = 'first_paywall_source';
  static const _kPropSubTrialEligible = 'sub_trial_eligible';
  static const _kPropOnboardingConverted = 'onboarding_converted';

  /// Internal helper to log events with standard paywall metadata.
  Future<void> _logEvent(String name, Map<String, Object> params) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: {
          ...params,
          _kParamScreenName: _kScreenName,
          _kParamTimestamp: DateTime.now().toIso8601String(),
        },
      );
    } catch (e, stack) {
      _logger.severe('Failed to log event: $name', e, stack);
    }
  }

  /// Logs when a paywall is triggered and displayed to the user.
  Future<void> logTriggered({
    required PaywallSource source,
    required PaywallType paywallType,
  }) async {
    await _logEvent(_kEventTriggered, {
      _kParamSource: source.name,
      _kParamPaywallType: paywallType.name,
    });
  }

  /// Logs when the subscription gift modal is viewed.
  Future<void> logGiftViewed({required PaywallSource source}) async {
    await _logEvent(_kEventGiftViewed, {_kParamSource: source.name});
  }

  /// Logs when the user claims the gift from the modal.
  Future<void> logGiftClaimed({required PaywallSource source}) async {
    await _logEvent(_kEventGiftClaimed, {_kParamSource: source.name});
  }

  /// Logs when the user dismisses the gift modal without claiming.
  Future<void> logGiftDismissed({required PaywallSource source}) async {
    await _logEvent(_kEventGiftDismissed, {_kParamSource: source.name});
  }

  /// Logs when the user initiates a purchase restoration.
  Future<void> logRestoreRequested({required PaywallSource source}) async {
    await _logEvent(_kEventRestoreRequested, {_kParamSource: source.name});
  }

  /// Logs a successful subscription conversion with financial and architectural metadata.
  Future<void> logConversion({
    required PaywallSource source,
    bool isDiscountFlow = false,
    bool isTrial = false,
    double? value,
    String? currency,
    SubscriptionPeriodType? periodType,
  }) async {
    try {
      await _logEvent(_kEventConversion, {
        _kParamSource: source.name,
        _kParamIsDiscountFlow: isDiscountFlow,
        _kParamIsTrial: isTrial,
        _kParamValue: value ?? 0.0,
        _kParamCurrency: currency ?? 'USD',
        _kParamPeriodType: periodType?.name ?? 'unknown',
      });

      await _analytics.setUserProperty(
        name: _kPropLastPaywallSource,
        value: source.name,
      );

      await _analytics.setUserProperty(
        name: _kPropFirstPaywallSource,
        value: source.name,
      );

      await _analytics.setUserProperty(
        name: _kPropSubTrialEligible,
        value: (periodType == SubscriptionPeriodType.trial).toString(),
      );
    } catch (e, stack) {
      _logger.severe('Failed to log conversion for internal metrics', e, stack);
    }
  }

  /// Logs a successful non-trial purchase completion.
  Future<void> logPurchaseSuccess(AnalyticsPurchaseParams params) async {
    try {
      if (params.source == PaywallSource.onboarding) {
        await _analytics.setUserProperty(
          name: _kPropOnboardingConverted,
          value: 'true',
        );
      }

      await logConversion(
        source: params.source,
        value: params.value,
        currency: params.currency,
        periodType: params.periodType,
        isTrial: false,
      );

      await _logEvent(_kEventPurchaseSuccess, {
        _kParamProductId: params.productId,
        _kParamSubscriptionType: params.packageType.name,
        _kParamPeriodType: params.periodType.name,
        _kParamSource: params.source.name,
      });
    } catch (e, stack) {
      _logger.severe('Failed to log purchase success', e, stack);
    }
  }

  /// Logs the start of a subscription trial period.
  Future<void> logTrialStarted(AnalyticsPurchaseParams params) async {
    try {
      if (params.source == PaywallSource.onboarding) {
        await _analytics.setUserProperty(
          name: _kPropOnboardingConverted,
          value: 'true',
        );
      }

      await logConversion(
        source: params.source,
        value: 0.0,
        currency: params.currency,
        periodType: params.periodType,
        isTrial: true,
      );

      await _logEvent(_kEventTrialStarted, {
        _kParamProductId: params.productId,
        _kParamSubscriptionType: params.packageType.name,
        _kParamPeriodType: params.periodType.name,
        _kParamSource: params.source.name,
      });
    } catch (e, stack) {
      _logger.severe('Failed to log trial start', e, stack);
    }
  }

  /// Logs when the paywall is dismissed by the user.
  Future<void> logDismissed({required PaywallSource source}) async {
    await _logEvent(_kEventDismissed, {_kParamSource: source.name});
  }
}
