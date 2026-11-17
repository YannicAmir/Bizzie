import 'package:bizzie/core/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_skip_config.freezed.dart';
part 'onboarding_skip_config.g.dart';

@freezed
abstract class OnboardingSkipConfig with _$OnboardingSkipConfig {
  const factory OnboardingSkipConfig({
    @Default([]) List<OnboardingSkipWatchlistItem> defaultWatchlist,
    required String defaultSector,
    required String initialCompanyTicker,
  }) = _OnboardingSkipConfig;

  factory OnboardingSkipConfig.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSkipConfigFromJson(json);
}

@freezed
abstract class OnboardingSkipWatchlistItem with _$OnboardingSkipWatchlistItem {
  const OnboardingSkipWatchlistItem._();

  const factory OnboardingSkipWatchlistItem({
    required String ticker,
    required String name,
  }) = _OnboardingSkipWatchlistItem;

  factory OnboardingSkipWatchlistItem.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSkipWatchlistItemFromJson(json);

  Company toDomain() => Company(ticker: ticker, name: name);
}
