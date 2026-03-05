import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SubscriptionTracker');

@lazySingleton
class SubscriptionTracker {
  final IAnalyticsService _analytics;

  SubscriptionTracker(this._analytics);

  static const _kPropIsSubscribed = 'is_subscribed';
  static const _kPropSubscriptionType = 'subscription_type';

  Future<void> syncSubscriptionProperties(SubscriptionStatus status) async {
    try {
      await _analytics.setUserProperty(
        name: _kPropIsSubscribed,
        value: status.isSubscribed.toString(),
      );
      final subType = _mapSubscriptionType(status);
      await _analytics.setUserProperty(
        name: _kPropSubscriptionType,
        value: subType,
      );

      _logger.info(
        'Synced subscription properties: is_subscribed=${status.isSubscribed}, type=$subType',
      );
    } catch (e, stack) {
      _logger.severe('Failed to sync subscription properties', e, stack);
    }
  }

  String _mapSubscriptionType(SubscriptionStatus status) {
    if (!status.isSubscribed) return 'none';

    if (status.periodType == SubscriptionPeriodType.trial) {
      return 'free_trial';
    }
    final planId = status.activePlanId?.toLowerCase() ?? '';

    if (planId.contains('annual') || planId.contains('yearly')) {
      if (planId.contains('discount')) {
        return 'discount_yearly';
      }
      return 'full_price_yearly';
    }

    if (planId.contains('monthly')) {
      return 'monthly';
    }

    return 'active_subscriber';
  }
}
