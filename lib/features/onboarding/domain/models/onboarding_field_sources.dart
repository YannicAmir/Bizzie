import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_field_sources.freezed.dart';

@freezed
abstract class OnboardingFieldSources with _$OnboardingFieldSources {
  const factory OnboardingFieldSources({
    required OnboardingValueSource name,
    required OnboardingValueSource sector,
    required OnboardingValueSource companies,
    required OnboardingValueSource experience,
    required OnboardingValueSource notifications,
  }) = _OnboardingFieldSources;
}
