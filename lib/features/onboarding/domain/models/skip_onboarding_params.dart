import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'skip_onboarding_params.freezed.dart';

@freezed
abstract class SkipOnboardingParams with _$SkipOnboardingParams {
  const factory SkipOnboardingParams({
    required OnboardingData data,
    @Default(false) bool hasExistingProfile,
  }) = _SkipOnboardingParams;
}
