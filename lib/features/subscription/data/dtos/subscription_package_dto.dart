import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_package_dto.freezed.dart';
part 'subscription_package_dto.g.dart';

@freezed
abstract class SubscriptionPackageDto with _$SubscriptionPackageDto {
  const SubscriptionPackageDto._();
  const factory SubscriptionPackageDto({
    required String id,
    required String identifier,
    required String productId,
    required String packageType,
    required String title,
    required String description,
    required String priceString,
    required double price,
    required String currencyCode,
    @Default(false) bool isEligibleForTrial,
  }) = _SubscriptionPackageDto;

  factory SubscriptionPackageDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageDtoFromJson(json);

  factory SubscriptionPackageDto.fromRevenueCat(Package p) {
    return SubscriptionPackageDto(
      id: p.identifier,
      identifier: p.identifier,
      productId: p.storeProduct.identifier,
      packageType: p.packageType.toString(),
      title: p.storeProduct.title,
      description: p.storeProduct.description,
      priceString: p.storeProduct.priceString,
      price: p.storeProduct.price,
      currencyCode: p.storeProduct.currencyCode,
      isEligibleForTrial: false,
    );
  }

  SubscriptionPackage toDomain() {
    return SubscriptionPackage(
      id: id,
      identifier: identifier,
      productId: productId,
      packageType: packageType,
      title: title,
      description: description,
      priceString: priceString,
      price: price,
      currencyCode: currencyCode,
      isEligibleForTrial: isEligibleForTrial,
    );
  }
}
