import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';

class AnalyticsPurchaseParams {
  final String productId;
  final SubscriptionPackageType packageType;
  final SubscriptionPeriodType periodType;
  final PaywallSource source;
  final bool isDiscount;
  final double? value;
  final String? currency;

  const AnalyticsPurchaseParams({
    required this.productId,
    required this.packageType,
    required this.periodType,
    required this.source,
    this.isDiscount = false,
    this.value,
    this.currency,
  });
}
