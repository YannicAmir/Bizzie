import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_data.freezed.dart';

enum InvestingExperience { beginner, intermediate, expert }

@freezed
abstract class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    @Default('') String firstName,
    @Default(null) Sector? selectedSector,
    @Default('') String rawBrandsText,
    @Default([]) List<Company> detectedCompanies,
    @Default(null) InvestingExperience? investingExperience,
  }) = _OnboardingData;
}
