// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_offering_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionOfferingDto _$SubscriptionOfferingDtoFromJson(
  Map<String, dynamic> json,
) => _SubscriptionOfferingDto(
  identifier: json['identifier'] as String,
  serverDescription: json['serverDescription'] as String,
  availablePackages: (json['availablePackages'] as List<dynamic>)
      .map((e) => SubscriptionPackageDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubscriptionOfferingDtoToJson(
  _SubscriptionOfferingDto instance,
) => <String, dynamic>{
  'identifier': instance.identifier,
  'serverDescription': instance.serverDescription,
  'availablePackages': instance.availablePackages,
};
