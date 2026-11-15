import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'skip_onboarding_result.freezed.dart';

@freezed
sealed class SkipOnboardingResult with _$SkipOnboardingResult {
  const factory SkipOnboardingResult.completed({
    required PostOnboardingDestination destination,
    required OnboardingFieldSources fieldSources,
  }) = SkipOnboardingCompleted;

  const factory SkipOnboardingResult.existingProfile() =
      SkipOnboardingExistingProfile;
}
