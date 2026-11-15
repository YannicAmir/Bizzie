// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_profile_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingProfileUpdateDto _$OnboardingProfileUpdateDtoFromJson(
  Map<String, dynamic> json,
) => _OnboardingProfileUpdateDto(
  name: json['name'] as String?,
  investingExperience: json['investingExperience'] as String?,
  notificationsEnabled: json['notificationsEnabled'] as bool?,
);

Map<String, dynamic> _$OnboardingProfileUpdateDtoToJson(
  _OnboardingProfileUpdateDto instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'investingExperience': ?instance.investingExperience,
  'notificationsEnabled': ?instance.notificationsEnabled,
};
