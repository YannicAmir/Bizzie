import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_onboarding_params.freezed.dart';

@freezed
abstract class CompleteOnboardingParams with _$CompleteOnboardingParams {
  const factory CompleteOnboardingParams({
    required OnboardingData data,
    required String uid,
  }) = _CompleteOnboardingParams;
}
