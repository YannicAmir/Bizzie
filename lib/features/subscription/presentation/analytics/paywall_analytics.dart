import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaywallAnalytics {
  final IAnalyticsService _analytics;

  PaywallAnalytics(this._analytics);

  static const _kScreenName = 'paywall';

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

  Future<void> logViewed({required PaywallSource source}) async {
    await _logEvent('paywall_viewed', {'source': source.name});
  }

  Future<void> logPurchaseSuccess(AnalyticsPurchaseParams params) async {
    if (params.source == PaywallSource.onboarding) {
      await _analytics.setUserProperty(
        name: 'converted_during_onboarding',
        value: 'true',
      );
    }

    await _logEvent('paywall_purchase_success', {
      'product_id': params.productId,
      'subscription_type': params.packageType.name,
      'period_type': params.periodType.name,
      'source': params.source.name,
    });
  }

  Future<void> logTrialStarted(AnalyticsPurchaseParams params) async {
    if (params.source == PaywallSource.onboarding) {
      await _analytics.setUserProperty(
        name: 'converted_during_onboarding',
        value: 'true',
      );
    }

    await _logEvent('paywall_trial_started', {
      'product_id': params.productId,
      'subscription_type': params.packageType.name,
      'period_type': params.periodType.name,
      'source': params.source.name,
    });
  }

  Future<void> logDismissed({required PaywallSource source}) async {
    await _logEvent('paywall_dismissed', {'source': source.name});
  }
}
