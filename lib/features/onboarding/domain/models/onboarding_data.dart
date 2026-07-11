import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/user/domain/enums/investing_experience.dart';

part 'onboarding_data.freezed.dart';

@freezed
abstract class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    @Default('') String firstName,
    @Default(null) Sector? selectedSector,
    @Default('') String rawBrandsText,
    @Default([]) List<Company> detectedCompanies,
    @Default(null) InvestingExperience? investingExperience,
    @Default(false) bool notificationsEnabled,
  }) = _OnboardingData;
}
