import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resolved_onboarding_data.freezed.dart';

@freezed
abstract class ResolvedOnboardingData with _$ResolvedOnboardingData {
  const factory ResolvedOnboardingData({
    required OnboardingData data,
    required OnboardingFieldSources sources,
  }) = _ResolvedOnboardingData;
}
