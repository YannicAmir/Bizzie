import 'dart:convert';
import 'package:bizzie/services/dtos/fmp_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

class RemoteConfigKeys {
  static const String fmpConfig = 'fmp_config';
  static const String geminiModelName = 'gemini_model_name';
  static const String stockMarketSectors = 'stock_market_sectors';
}

@singleton
class ConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  // Defaults - Safety Net
  static const _defaultGeminiModel = 'gemini-3-flash-preview';
  static const _defaultSectors = [
    "Energy",
    "Materials",
    "Industrials",
    "Consumer Discretionary",
    "Consumer Staples",
    "Health Care",
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

    // 1. Set Defaults
    await remoteConfig.setDefaults({
      RemoteConfigKeys.geminiModelName: _defaultGeminiModel,
      RemoteConfigKeys.stockMarketSectors: jsonEncode(_defaultSectors),
      RemoteConfigKeys.fmpConfig: jsonEncode(_defaultFmpConfig),
    });

    try {
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('Remote Config fetch failed: $e');
      // Fallback to defaults or cached values
    }

    return ConfigService(remoteConfig);
  }

  // 2. Strongly Typed Getters

  String get geminiModelName =>
      _remoteConfig.getString(RemoteConfigKeys.geminiModelName);

  List<String> get stockMarketSectors {
    final jsonString = _remoteConfig.getString(
      RemoteConfigKeys.stockMarketSectors,
    );
    try {
      return List<String>.from(jsonDecode(jsonString));
    } catch (e) {
      debugPrint('Error parsing stockMarketSectors: $e');
      return _defaultSectors;
    }
  }

  FmpConfig get fmpConfig {
    final jsonString = _remoteConfig.getString(RemoteConfigKeys.fmpConfig);
    try {
      return FmpConfig.fromJson(jsonDecode(jsonString));
    } catch (e) {
      debugPrint('Error parsing fmpConfig: $e');
      return FmpConfig.fromJson(_defaultFmpConfig);
    }
  }

  // 3. Generic Getters (Kept for backward compatibility/testing)
  String getString(String key) => _remoteConfig.getString(key);
  bool getBool(String key) => _remoteConfig.getBool(key);
  int getInt(String key) => _remoteConfig.getInt(key);
  double getDouble(String key) => _remoteConfig.getDouble(key);
}
