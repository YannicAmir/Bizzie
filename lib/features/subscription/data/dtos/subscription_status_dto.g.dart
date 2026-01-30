// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionStatusDto _$SubscriptionStatusDtoFromJson(
  Map<String, dynamic> json,
) => _SubscriptionStatusDto(
  isSubscribed: json['isSubscribed'] as bool,
  activeEntitlements: (json['activeEntitlements'] as List<dynamic>)
      .map((e) => e as String)
      .toSet(),
  expirationDate: json['expirationDate'] == null
      ? null
      : DateTime.parse(json['expirationDate'] as String),
);

Map<String, dynamic> _$SubscriptionStatusDtoToJson(
  _SubscriptionStatusDto instance,
) => <String, dynamic>{
  'isSubscribed': instance.isSubscribed,
  'activeEntitlements': instance.activeEntitlements.toList(),
  'expirationDate': instance.expirationDate?.toIso8601String(),
};
