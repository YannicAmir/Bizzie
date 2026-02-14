import 'dart:convert';
import 'package:bizzie/core/data/dtos/fmp_config.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/utils/sector_normalizer.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

class RemoteConfigKeys {
  static const String fmpConfig = 'fmp_config';
  static const String geminiModelName = 'gemini_model_front_end';
  static const String stockMarketSectors = 'stock_market_sectors';
  static const String sectorDescriptions = 'sector_descriptions';
  static const String privacyPolicyUrl = 'privacy_policy_url';
  static const String termsOfServiceUrl = 'terms_of_service_url';
}

final _logger = BizzieLogger('ConfigService');

const _sectorApiAliases = {
  'informationtechnology': 'Technology',
  'information_technology': 'Technology',
  'technology': 'Technology',
  'financials': 'Financial Services',
  'communicationservices': 'Communication Services',
  'telecommunicationservices': 'Communication Services',
  'consumerdiscretionary': 'Consumer Cyclical',
  'consumerstaples': 'Consumer Defensive',
  'healthcare': 'Healthcare',
  'materials': 'Basic Materials',
  'industrials': 'Industrials',
  'energy': 'Energy',
  'utilities': 'Utilities',
  'realestate': 'Real Estate',
  'real_estate': 'Real Estate',
};

@Singleton(as: IConfigService)
class ConfigService implements IConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  static const _defaultGeminiModel = 'gemini-2.5-flash';
  static const _defaultSectors = [
    "Energy",
    "Materials",
    "Industrials",
    "Consumer Discretionary",
    "Consumer Staples",
    "Healthcare",
    "Financials",
    "Information Technology",
    "Communication Services",
    "Utilities",
    "Real Estate",
  ];
  static const _defaultFmpConfig = {
    "baseUrl": "https://financialmodelingprep.com/stable",
    "v4Url": "https://financialmodelingprep.com/api/v4",
    "v3Url": "https://financialmodelingprep.com/api/v3",
  };

  static const _defaultSectorDescriptions = {
    "Energy":
        "Companies involved in oil, gas, and consumable fuels—typically excluding renewable energy firms.",
    "Materials":
        "Suppliers of raw goods used in manufacturing, such as chemicals, construction materials, and packaging.",
    "Industrials":
        "Businesses using heavy equipment, including those in transportation, aerospace, defense, and construction.",
    "Consumer Discretionary":
        "Businesses selling non-essential goods and services, such as automobiles, luxury items, leisure, and retail.",
    "Consumer Staples":
        "Providers of essential daily goods that people buy regardless of the economy, including food, beverages, and household products.",
    "Health Care":
        "Firms providing medical services, biotechnology, pharmaceuticals, and healthcare equipment.",
    "Financials":
        "Institutions handling money, transaction processing, and risk, including banks, insurance carriers, and investment firms.",
    "Information Technology":
        "Developers of software, hardware, semiconductors, and IT services that drive digital infrastructure.",
    "Communication Services":
        "Providers of telecommunications, media, entertainment, and interactive social media content.",
    "Utilities":
        "Regulated providers of essential infrastructure services like electricity, natural gas, water, and renewable power.",
    "Real Estate":
        "Companies involved in property development, management, and Real Estate Investment Trusts (REITs).",
  };

  ConfigService(this._remoteConfig);

  @factoryMethod
  @preResolve
  static Future<ConfigService> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: kReleaseMode
            ? const Duration(hours: 1)
            : Duration.zero,
      ),
    );

    await remoteConfig.setDefaults({
      RemoteConfigKeys.geminiModelName: _defaultGeminiModel,
      RemoteConfigKeys.stockMarketSectors: jsonEncode(_defaultSectors),
      RemoteConfigKeys.fmpConfig: jsonEncode(_defaultFmpConfig),
      RemoteConfigKeys.sectorDescriptions: jsonEncode(
        _defaultSectorDescriptions,
      ),
      RemoteConfigKeys.privacyPolicyUrl: 'https://bizzie.app/privacy',
      RemoteConfigKeys.termsOfServiceUrl: 'https://bizzie.app/terms',
    });

    try {
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      _logger.warning('Remote Config fetch failed', e);
    }

    return ConfigService(remoteConfig);
  }

  @override
  String get geminiModelName =>
      _remoteConfig.getString(RemoteConfigKeys.geminiModelName);

  @override
  String get privacyPolicyUrl =>
      _remoteConfig.getString(RemoteConfigKeys.privacyPolicyUrl);

  @override
  String get termsOfServiceUrl =>
      _remoteConfig.getString(RemoteConfigKeys.termsOfServiceUrl);

  @override
  List<String> get stockMarketSectors {
    final jsonString = _remoteConfig.getString(
      RemoteConfigKeys.stockMarketSectors,
    );
    try {
      return List<String>.from(jsonDecode(jsonString));
    } catch (e) {
      _logger.severe('Error parsing stockMarketSectors', e);
      return _defaultSectors;
    }
  }

  @override
  FmpConfig get fmpConfig {
    final jsonString = _remoteConfig.getString(RemoteConfigKeys.fmpConfig);
    try {
      return FmpConfig.fromJson(jsonDecode(jsonString));
    } catch (e) {
      _logger.severe('Error parsing fmpConfig', e);
      return FmpConfig.fromJson(_defaultFmpConfig);
    }
  }

  @override
  String getString(String key) => _remoteConfig.getString(key);
  @override
  bool getBool(String key) => _remoteConfig.getBool(key);
  @override
  int getInt(String key) => _remoteConfig.getInt(key);
  @override
  double getDouble(String key) => _remoteConfig.getDouble(key);

  @override
  String getSectorApiName(String sectorName) {
    final normalized = normalizeSectorKey(sectorName);
    return _sectorApiAliases[normalized] ?? sectorName;
  }

  @override
  String getSectorDescription(String sectorName) {
    final match = _getSectorMetaData(sectorName);
    return match?.value ?? "";
  }

  @override
  String getSectorDisplayName(String sectorName) {
    final match = _getSectorMetaData(sectorName);
    if (match != null) {
      return match.key;
    }

    return sectorName
        .split('_')
        .map((word) {
          if (word.isEmpty) return '';
          return '${word[0].toUpperCase()}${word.substring(1)}';
        })
        .join(' ');
  }

  ({String key, String value})? _getSectorMetaData(String sectorName) {
    Map<String, dynamic> descriptionsMap;
    try {
      final jsonString = _remoteConfig.getString(
        RemoteConfigKeys.sectorDescriptions,
      );
      if (jsonString.isEmpty) {
        descriptionsMap = _defaultSectorDescriptions;
      } else {
        descriptionsMap = jsonDecode(jsonString) as Map<String, dynamic>;
      }
    } catch (e) {
      _logger.severe('Error parsing sectorDescriptions', e);
      descriptionsMap = _defaultSectorDescriptions;
    }

    if (descriptionsMap.containsKey(sectorName)) {
      return (key: sectorName, value: descriptionsMap[sectorName].toString());
    }

    final normalizedInput = normalizeSectorKey(sectorName);
    for (final entry in descriptionsMap.entries) {
      if (normalizeSectorKey(entry.key) == normalizedInput) {
        return (key: entry.key, value: entry.value.toString());
      }
    }

    return null;
  }
}
