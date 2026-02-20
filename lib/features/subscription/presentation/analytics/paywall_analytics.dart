import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaywallAnalytics {
  final IAnalyticsService _analytics;

  PaywallAnalytics(this._analytics);

  static const _kScreenName = 'paywall';

  /// Internal helper to log events with standard paywall metadata.
  Future<void> _logEvent(String name, Map<String, Object> params) async {
    await _analytics.logEvent(
      name: name,
      parameters: {
        ...params,
        'screen_name': _kScreenName,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Logs when a paywall is triggered and displayed to the user.
  Future<void> logTriggered({
    required PaywallSource source,
    required PaywallType paywallType,
  }) async {
    await _logEvent('paywall_triggered', {
      'source': source.name,
      'paywall_type': paywallType.name,
    });
  }

  /// Logs when the subscription gift modal is viewed.
  Future<void> logGiftViewed({required PaywallSource source}) async {
    await _logEvent('paywall_gift_viewed', {'source': source.name});
  }

  /// Logs when the user claims the gift from the modal.
  Future<void> logGiftClaimed({required PaywallSource source}) async {
    await _logEvent('paywall_gift_claimed', {'source': source.name});
  }

  /// Logs when the user dismisses the gift modal without claiming.
  Future<void> logGiftDismissed({required PaywallSource source}) async {
    await _logEvent('paywall_gift_dismissed', {'source': source.name});
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
    await _logEvent('paywall_conversion', {
      'source': source.name,
      'is_discount_flow': isDiscountFlow,
      'is_trial': isTrial,
      'value': value ?? 0.0,
      'currency': currency ?? 'USD',
      'period_type': periodType?.name ?? 'unknown',
    });

    await _analytics.setUserProperty(
      name: 'last_paywall_source',
      value: source.name,
    );

    await _analytics.setUserProperty(
      name: 'first_paywall_source',
      value: source.name,
    );

    await _analytics.setUserProperty(
      name: 'sub_trial_eligible',
      value: (periodType == SubscriptionPeriodType.trial).toString(),
    );
  }

  /// Logs a successful non-trial purchase completion.
  Future<void> logPurchaseSuccess(AnalyticsPurchaseParams params) async {
    if (params.source == PaywallSource.onboarding) {
      await _analytics.setUserProperty(
        name: 'onboarding_converted',
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

    await _logEvent('paywall_purchase_success', {
      'product_id': params.productId,
      'subscription_type': params.packageType.name,
      'period_type': params.periodType.name,
      'source': params.source.name,
    });
  }

  /// Logs the start of a subscription trial period.
  Future<void> logTrialStarted(AnalyticsPurchaseParams params) async {
    if (params.source == PaywallSource.onboarding) {
      await _analytics.setUserProperty(
        name: 'onboarding_converted',
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

    await _logEvent('paywall_trial_started', {
      'product_id': params.productId,
      'subscription_type': params.packageType.name,
      'period_type': params.periodType.name,
      'source': params.source.name,
    });
  }

  /// Logs when the paywall is dismissed by the user.
  Future<void> logDismissed({required PaywallSource source}) async {
    await _logEvent('paywall_dismissed', {'source': source.name});
  }
}
