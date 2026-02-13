import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
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
    required SubscriptionPackageType packageType,
    required String title,
    required String description,
    required String priceString,
    required double price,
    required String currencyCode,
    @Default(false) bool isEligibleForTrial,
    @Default(false) bool hasFreeTrial,
  }) = _SubscriptionPackageDto;

  factory SubscriptionPackageDto.empty() => const SubscriptionPackageDto(
    id: '',
    identifier: '',
    productId: '',
    packageType: SubscriptionPackageType.unknown,
    title: '',
    description: '',
    priceString: '',
    price: 0.0,
    currencyCode: '',
  );

  factory SubscriptionPackageDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageDtoFromJson(json);

  factory SubscriptionPackageDto.fromRevenueCat(Package p) {
    return SubscriptionPackageDto(
      id: p.identifier,
      identifier: p.identifier,
      productId: p.storeProduct.identifier,
      packageType: _mapPackageType(p.packageType, p.storeProduct.identifier),
      title: p.storeProduct.title,
      description: p.storeProduct.description,
      priceString: p.storeProduct.priceString,
      price: p.storeProduct.price,
      currencyCode: p.storeProduct.currencyCode,
      isEligibleForTrial: p.storeProduct.introductoryPrice != null,
      hasFreeTrial: p.storeProduct.introductoryPrice != null,
    );
  }

  static SubscriptionPackageType _mapPackageType(
    PackageType type,
    String productId,
  ) {
    final lowerId = productId.toLowerCase();

    switch (type) {
      case PackageType.monthly:
        return SubscriptionPackageType.monthly;
      case PackageType.annual:
        return SubscriptionPackageType.annual;
      case PackageType.sixMonth:
        return SubscriptionPackageType.sixMonth;
      case PackageType.threeMonth:
        return SubscriptionPackageType.threeMonth;
      case PackageType.twoMonth:
        return SubscriptionPackageType.twoMonth;
      case PackageType.weekly:
        return SubscriptionPackageType.weekly;
      case PackageType.lifetime:
        return SubscriptionPackageType.lifetime;
      case PackageType.custom:
      case PackageType.unknown:
        if (lowerId.contains('annual')) return SubscriptionPackageType.annual;
        if (lowerId.contains('monthly')) return SubscriptionPackageType.monthly;
        return type == PackageType.custom
            ? SubscriptionPackageType.custom
            : SubscriptionPackageType.unknown;
    }
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
      hasFreeTrial: hasFreeTrial,
    );
  }
}
