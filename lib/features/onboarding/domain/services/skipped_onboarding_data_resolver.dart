import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:bizzie/features/onboarding/domain/models/resolved_onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/services/guest_username_generator.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:injectable/injectable.dart';

const _defaultInvestingExperience = InvestingExperience.beginner;

@lazySingleton
class SkippedOnboardingDataResolver {
  final GuestUsernameGenerator _usernameGenerator;

  SkippedOnboardingDataResolver(this._usernameGenerator);

  ResolvedOnboardingData resolve({
    required OnboardingData data,
    required OnboardingSkipDefaults defaults,
  }) {
    return ResolvedOnboardingData(
      data: data.copyWith(
        firstName: _usernameGenerator.resolveName(data.firstName),
        selectedSector: data.selectedSector ?? defaults.defaultSector,
        detectedCompanies: data.detectedCompanies.isNotEmpty
            ? data.detectedCompanies
            : defaults.defaultWatchlist,
        investingExperience:
            data.investingExperience ?? _defaultInvestingExperience,
      ),
      sources: _sourcesOf(data, defaults: defaults),
    );
  }

  ResolvedOnboardingData unresolved(OnboardingData data) {
    return ResolvedOnboardingData(data: data, sources: _sourcesOf(data));
  }

  OnboardingFieldSources _sourcesOf(
    OnboardingData data, {
    OnboardingSkipDefaults? defaults,
  }) {
    final hasDefaults = defaults != null;
    return OnboardingFieldSources(
      name: _sourceOf(
        isUserProvided: data.firstName.trim().isNotEmpty,
        fallback: OnboardingValueSource.localDefault,
        hasFallback: hasDefaults,
      ),
      sector: _sourceOf(
        isUserProvided: data.selectedSector != null,
        fallback: OnboardingValueSource.remoteDefault,
        hasFallback: defaults?.defaultSector != null,
      ),
      companies: _sourceOf(
        isUserProvided: data.detectedCompanies.isNotEmpty,
        fallback: OnboardingValueSource.remoteDefault,
        hasFallback: defaults?.defaultWatchlist.isNotEmpty ?? false,
      ),
      experience: _sourceOf(
        isUserProvided: data.investingExperience != null,
        fallback: OnboardingValueSource.localDefault,
        hasFallback: hasDefaults,
      ),
      notifications: _sourceOf(
        isUserProvided: data.hasDecidedNotifications,
        fallback: OnboardingValueSource.localDefault,
        hasFallback: hasDefaults,
      ),
    );
  }

  OnboardingValueSource _sourceOf({
    required bool isUserProvided,
    required OnboardingValueSource fallback,
    required bool hasFallback,
  }) {
    if (isUserProvided) return OnboardingValueSource.userSelection;
    return hasFallback ? fallback : OnboardingValueSource.none;
  }
}
