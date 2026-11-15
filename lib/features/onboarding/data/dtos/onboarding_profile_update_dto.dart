// ignore_for_file: invalid_annotation_target
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_profile_update_dto.freezed.dart';
part 'onboarding_profile_update_dto.g.dart';

@freezed
abstract class OnboardingProfileUpdateDto with _$OnboardingProfileUpdateDto {
  const OnboardingProfileUpdateDto._();

  @JsonSerializable(includeIfNull: false)
  const factory OnboardingProfileUpdateDto({
    String? name,
    String? investingExperience,
    bool? notificationsEnabled,
  }) = _OnboardingProfileUpdateDto;

  factory OnboardingProfileUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$OnboardingProfileUpdateDtoFromJson(json);

  factory OnboardingProfileUpdateDto.fromDomain(
    OnboardingProfileUpdate domain,
  ) {
    return OnboardingProfileUpdateDto(
      name: domain.name,
      investingExperience: domain.investingExperience?.name,
      notificationsEnabled: domain.notificationsEnabled,
    );
  }
}
