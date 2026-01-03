// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  uid: json['uid'] as String,
  name: json['name'] as String,
  favoriteSector: json['favoriteSector'] as String,
  favoriteSectorDisplay: json['favoriteSectorDisplay'] as String,
  watchlist: (json['watchlist'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
  investingExperience: json['investingExperience'] as String,
  isSubscribed: json['isSubscribed'] as bool? ?? false,
  fcmTokens: Map<String, String>.from(json['fcmTokens'] as Map),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'favoriteSector': instance.favoriteSector,
  'favoriteSectorDisplay': instance.favoriteSectorDisplay,
  'watchlist': instance.watchlist,
  'investingExperience': instance.investingExperience,
  'isSubscribed': instance.isSubscribed,
  'fcmTokens': instance.fcmTokens,
};
