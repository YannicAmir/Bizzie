import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_skip_defaults.freezed.dart';

@freezed
abstract class OnboardingSkipDefaults with _$OnboardingSkipDefaults {
  const factory OnboardingSkipDefaults({
    required List<Company> defaultWatchlist,
    Sector? defaultSector,
    required String initialCompanyTicker,
  }) = _OnboardingSkipDefaults;
}
