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
  packageType: json['packageType'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  priceString: json['priceString'] as String,
  price: (json['price'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
);

Map<String, dynamic> _$SubscriptionPackageDtoToJson(
  _SubscriptionPackageDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'packageType': instance.packageType,
  'title': instance.title,
  'description': instance.description,
  'priceString': instance.priceString,
  'price': instance.price,
  'currencyCode': instance.currencyCode,
};
