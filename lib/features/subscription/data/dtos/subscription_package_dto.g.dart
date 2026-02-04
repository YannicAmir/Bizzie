// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_package_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionPackageDto _$SubscriptionPackageDtoFromJson(
  Map<String, dynamic> json,
) => _SubscriptionPackageDto(
  id: json['id'] as String,
  identifier: json['identifier'] as String,
  productId: json['productId'] as String,
  packageType: $enumDecode(
    _$SubscriptionPackageTypeEnumMap,
    json['packageType'],
  ),
  title: json['title'] as String,
  description: json['description'] as String,
  priceString: json['priceString'] as String,
  price: (json['price'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  isEligibleForTrial: json['isEligibleForTrial'] as bool? ?? false,
);

Map<String, dynamic> _$SubscriptionPackageDtoToJson(
  _SubscriptionPackageDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'productId': instance.productId,
  'packageType': _$SubscriptionPackageTypeEnumMap[instance.packageType]!,
  'title': instance.title,
  'description': instance.description,
  'priceString': instance.priceString,
  'price': instance.price,
  'currencyCode': instance.currencyCode,
  'isEligibleForTrial': instance.isEligibleForTrial,
};

const _$SubscriptionPackageTypeEnumMap = {
  SubscriptionPackageType.monthly: 'monthly',
  SubscriptionPackageType.annual: 'annual',
  SubscriptionPackageType.sixMonth: 'sixMonth',
  SubscriptionPackageType.threeMonth: 'threeMonth',
  SubscriptionPackageType.twoMonth: 'twoMonth',
  SubscriptionPackageType.weekly: 'weekly',
  SubscriptionPackageType.lifetime: 'lifetime',
  SubscriptionPackageType.custom: 'custom',
  SubscriptionPackageType.unknown: 'unknown',
};
