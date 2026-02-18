import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_purchase_params.freezed.dart';

@freezed
abstract class AnalyticsPurchaseParams with _$AnalyticsPurchaseParams {
  const AnalyticsPurchaseParams._();

  const factory AnalyticsPurchaseParams({
    required String productId,
    required SubscriptionPackageType packageType,
    required SubscriptionPeriodType periodType,
    required PaywallSource source,
  }) = _AnalyticsPurchaseParams;
}
