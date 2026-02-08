// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  uid: json['uid'] as String,
  name: json['name'] as String,
  favoriteSector: json['favoriteSector'] as String,
  investingExperience: json['investingExperience'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt'] as Object),
  isSubscribed: json['isSubscribed'] as bool? ?? false,
  notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
  fcmTokens: Map<String, String>.from(json['fcmTokens'] as Map),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'favoriteSector': instance.favoriteSector,
  'investingExperience': instance.investingExperience,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'isSubscribed': instance.isSubscribed,
  'notificationsEnabled': instance.notificationsEnabled,
  'fcmTokens': instance.fcmTokens,
};
