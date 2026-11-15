import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_profile_update.freezed.dart';

@freezed
abstract class OnboardingProfileUpdate with _$OnboardingProfileUpdate {
  const factory OnboardingProfileUpdate({
    required String uid,
    String? name,
    InvestingExperience? investingExperience,
    bool? notificationsEnabled,
  }) = _OnboardingProfileUpdate;
}
