import 'package:bizzie/core/data/dtos/onboarding_skip_config.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';

extension OnboardingSkipConfigMapper on OnboardingSkipConfig {
  OnboardingSkipDefaults toDomain() => OnboardingSkipDefaults(
    defaultWatchlist: defaultWatchlist.map((item) => item.toDomain()).toList(),
    defaultSector: Sector.fromString(defaultSector),
    initialCompanyTicker: initialCompanyTicker,
  );
}
