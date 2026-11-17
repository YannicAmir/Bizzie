import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_onboarding_progress_result.freezed.dart';

@freezed
sealed class SaveOnboardingProgressResult with _$SaveOnboardingProgressResult {
  const factory SaveOnboardingProgressResult.saved({required String uid}) =
      SaveOnboardingProgressSaved;

  const factory SaveOnboardingProgressResult.existingProfile() =
      SaveOnboardingProgressExistingProfile;
}
