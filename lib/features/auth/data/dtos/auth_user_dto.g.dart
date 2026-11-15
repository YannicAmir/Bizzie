// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUserDto _$AuthUserDtoFromJson(Map<String, dynamic> json) => _AuthUserDto(
  uid: json['uid'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  providers:
      (json['providers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isAnonymous: json['isAnonymous'] as bool? ?? false,
);

Map<String, dynamic> _$AuthUserDtoToJson(_AuthUserDto instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'providers': instance.providers,
      'isAnonymous': instance.isAnonymous,
    };
