// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_skip_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingSkipConfig _$OnboardingSkipConfigFromJson(
  Map<String, dynamic> json,
) => _OnboardingSkipConfig(
  defaultWatchlist:
      (json['defaultWatchlist'] as List<dynamic>?)
          ?.map(
            (e) =>
                OnboardingSkipWatchlistItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  defaultSector: json['defaultSector'] as String,
  initialCompanyTicker: json['initialCompanyTicker'] as String,
);

Map<String, dynamic> _$OnboardingSkipConfigToJson(
  _OnboardingSkipConfig instance,
) => <String, dynamic>{
  'defaultWatchlist': instance.defaultWatchlist,
  'defaultSector': instance.defaultSector,
  'initialCompanyTicker': instance.initialCompanyTicker,
};

_OnboardingSkipWatchlistItem _$OnboardingSkipWatchlistItemFromJson(
  Map<String, dynamic> json,
) => _OnboardingSkipWatchlistItem(
  ticker: json['ticker'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$OnboardingSkipWatchlistItemToJson(
  _OnboardingSkipWatchlistItem instance,
) => <String, dynamic>{'ticker': instance.ticker, 'name': instance.name};
