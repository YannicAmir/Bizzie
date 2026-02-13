// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_subscription_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncSubscriptionResponseDto _$SyncSubscriptionResponseDtoFromJson(
  Map<String, dynamic> json,
) => _SyncSubscriptionResponseDto(
  active: json['active'] as bool,
  status: json['status'] as String?,
  expirationDate: json['expirationDate'] as String?,
);

Map<String, dynamic> _$SyncSubscriptionResponseDtoToJson(
  _SyncSubscriptionResponseDto instance,
) => <String, dynamic>{
  'active': instance.active,
  'status': instance.status,
  'expirationDate': instance.expirationDate,
};
