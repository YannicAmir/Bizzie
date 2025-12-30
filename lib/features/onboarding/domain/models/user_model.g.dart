// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  name: json['name'] as String,
  favoriteSector: json['favoriteSector'] as String,
  watchlist: (json['watchlist'] as List<dynamic>)
      .map((e) => Company.fromJson(e as Map<String, dynamic>))
      .toList(),
  investingExperience: $enumDecode(
    _$InvestingExperienceEnumMap,
    json['investingExperience'],
  ),
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  isSubscribed: json['isSubscribed'] as bool,
  fcmTokens: Map<String, String>.from(json['fcmTokens'] as Map),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'favoriteSector': instance.favoriteSector,
      'watchlist': instance.watchlist,
      'investingExperience':
          _$InvestingExperienceEnumMap[instance.investingExperience]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'isSubscribed': instance.isSubscribed,
      'fcmTokens': instance.fcmTokens,
    };

const _$InvestingExperienceEnumMap = {
  InvestingExperience.beginner: 'beginner',
  InvestingExperience.intermediate: 'intermediate',
  InvestingExperience.expert: 'expert',
};
