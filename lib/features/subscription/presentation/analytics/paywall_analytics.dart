import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaywallAnalytics {
  final IAnalyticsService _analytics;

  PaywallAnalytics(this._analytics);

  Future<void> logViewed({required PaywallSource source}) async {
    await _analytics.logEvent(
      name: 'paywall_viewed',
      parameters: {'source': source.name},
    );
  }

  Future<void> logPurchaseSuccess(AnalyticsPurchaseParams params) async {
    await _analytics.logEvent(
      name: 'paywall_purchase_success',
      parameters: {
        'product_id': params.productId,
        'subscription_type': params.packageType.name,
        'period_type': params.periodType.name,
        'source': params.source.name,
      },
    );
  }

  Future<void> logTrialStarted(AnalyticsPurchaseParams params) async {
    await _analytics.logEvent(
      name: 'paywall_trial_started',
      parameters: {
        'product_id': params.productId,
        'subscription_type': params.packageType.name,
        'period_type': params.periodType.name,
        'source': params.source.name,
      },
    );
  }

  Future<void> logDismissed({required PaywallSource source}) async {
    await _analytics.logEvent(
      name: 'paywall_dismissed',
      parameters: {'source': source.name},
    );
  }
}
