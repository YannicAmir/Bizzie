import 'dart:convert';
import 'package:bizzie/core/data/dtos/company_tabs_config.dart';
import 'package:bizzie/core/data/dtos/fmp_config.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/env/app_env.dart';

class RemoteConfigKeys {
  static const String fmpConfig = 'fmp_config';
  static const String geminiModelName = 'gemini_model_front_end';
  static const String stockMarketSectors = 'stock_market_sectors';
  static const String sectorDescriptions = 'sector_descriptions';
  static const String privacyPolicyUrl = 'privacy_policy_url';
  static const String termsOfServiceUrl = 'terms_of_service_url';
  static const String minAppVersion = 'min_app_version';
  static const String appStoreLink = 'app_store_link';
  static const String playStoreLink = 'play_store_link';
  static const String maintenanceMode = 'maintenance_mode';
  static const String bypassTalsec = 'bypass_talsec';
  static const String forceImmediateFetch = 'force_immediate_fetch';
  static const String contactEmail = 'contact_email';
  static const String freePlanHistoryCount = 'free_plan_history_count';
  static const String reviewPromptEventCount = 'review_prompt_event_count';
  static const String aiSummaryButtonLabel = 'ai_summary_button_label';
  static const String subscriptionFeatureHighlights =
      'subscription_feature_highlights';
  static const String frankfurterConfig = 'frankfurter_config';
  static const String bizzieChatBaseUrl = 'bizzie_chat_base_url';
  static const String bizzieChatEnabled = 'bizzie_chat_enabled';
  static const String freeUsersCompanyTabsConfig =
      'free_users_company_tabs_config';
  static const String paidUsersCompanyTabsConfig =
      'paid_users_company_tabs_config';
}

final _logger = BizzieLogger('ConfigService');

@preResolve
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

  static const _defaultSubscriptionFeatureHighlights = [
    'Unlimited AI analysis of financial reports',
    'Unlimited product search to find stocks',
    'Unlimited summaries of SEC filings',
  ];
  static const _defaultFrankfurterBaseUrl = "https://api.frankfurter.dev/v1";

  static const _defaultFreeUsersCompanyTabsConfig = {
    "mainTabs": ["business", "news", "dividends", "revenue"],
    "moreTabs": ["netIncome", "eps"],
    "bizziePlusTabs": [
      "chat",
      "segments",
      "freeCash",
      "fcps",
      "shares",
      "financialStatements",
      "roe",
      "peRatio",
      "pfcfRatio",
    ],
  };

  static const _defaultPaidUsersCompanyTabsConfig = {
    "mainTabs": [
      "business",
      "news",
      "dividends",
      "revenue",
      "segments",
      "netIncome",
      "eps",
      "freeCash",
      "fcps",
      "shares",
      "financialStatements",
    ],
    "moreTabs": ["roe", "peRatio", "pfcfRatio", "chat"],
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

  Future<void> initialize(AppEnv env) async {
    final forceImmediate = _remoteConfig.getBool(
      RemoteConfigKeys.forceImmediateFetch,
    );
    final fetchInterval = forceImmediate
        ? Duration.zero
        : env.minimumFetchInterval;

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: fetchInterval,
      ),
    );

    await _remoteConfig.setDefaults({
      RemoteConfigKeys.geminiModelName: _defaultGeminiModel,
      RemoteConfigKeys.stockMarketSectors: jsonEncode(_defaultSectors),
      RemoteConfigKeys.fmpConfig: jsonEncode(_defaultFmpConfig),
      RemoteConfigKeys.sectorDescriptions: jsonEncode(
        _defaultSectorDescriptions,
      ),
      RemoteConfigKeys.privacyPolicyUrl: 'https://bizzie.app/privacy',
      RemoteConfigKeys.termsOfServiceUrl: 'https://bizzie.app/terms',
      RemoteConfigKeys.minAppVersion: '1.0.0',
      RemoteConfigKeys.appStoreLink: 'https://bizzie.app',
      RemoteConfigKeys.playStoreLink: 'https://bizzie.app',
      RemoteConfigKeys.maintenanceMode: false,
      RemoteConfigKeys.bypassTalsec: false,
      RemoteConfigKeys.forceImmediateFetch: false,
      RemoteConfigKeys.contactEmail: 'yannic@getbizzie.io',
      RemoteConfigKeys.freePlanHistoryCount: 5,
      RemoteConfigKeys.reviewPromptEventCount: 3,
      RemoteConfigKeys.aiSummaryButtonLabel: 'Summarize',
      RemoteConfigKeys.subscriptionFeatureHighlights: jsonEncode(
        _defaultSubscriptionFeatureHighlights,
      ),
      RemoteConfigKeys.frankfurterConfig: _defaultFrankfurterBaseUrl,
      RemoteConfigKeys.bizzieChatBaseUrl: '',
      RemoteConfigKeys.bizzieChatEnabled: true,
      RemoteConfigKeys.freeUsersCompanyTabsConfig: jsonEncode(
        _defaultFreeUsersCompanyTabsConfig,
      ),
      RemoteConfigKeys.paidUsersCompanyTabsConfig: jsonEncode(
        _defaultPaidUsersCompanyTabsConfig,
      ),
    });

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      _logger.warning('Remote Config fetch failed', e);
    }
  }

  @factoryMethod
  static Future<ConfigService> init(
    AppEnv env,
    FirebaseRemoteConfig remoteConfig,
  ) async {
    final service = ConfigService(remoteConfig);
    await service.initialize(env);
    return service;
  }

  @override
  String get geminiModelName =>
      _remoteConfig.getString(RemoteConfigKeys.geminiModelName);

  @override
  String get securityWatcherMail =>
      _remoteConfig.getString(RemoteConfigKeys.contactEmail);

  @override
  String get privacyPolicyUrl =>
      _remoteConfig.getString(RemoteConfigKeys.privacyPolicyUrl);

  @override
  String get termsOfServiceUrl =>
      _remoteConfig.getString(RemoteConfigKeys.termsOfServiceUrl);

  @override
  String get minAppVersion =>
      _remoteConfig.getString(RemoteConfigKeys.minAppVersion);

  @override
  String get appStoreLink =>
      _remoteConfig.getString(RemoteConfigKeys.appStoreLink);

  @override
  String get playStoreLink =>
      _remoteConfig.getString(RemoteConfigKeys.playStoreLink);

  @override
  bool get maintenanceMode =>
      _remoteConfig.getBool(RemoteConfigKeys.maintenanceMode);

  @override
  bool get bypassTalsec => _remoteConfig.getBool(RemoteConfigKeys.bypassTalsec);

  @override
  bool get forceImmediateFetch =>
      _remoteConfig.getBool(RemoteConfigKeys.forceImmediateFetch);

  @override
  int get freePlanHistoryCount =>
      _remoteConfig.getInt(RemoteConfigKeys.freePlanHistoryCount);

  @override
  int get reviewPromptEventCount =>
      _remoteConfig.getInt(RemoteConfigKeys.reviewPromptEventCount);

  @override
  String get aiSummaryButtonLabel =>
      _remoteConfig.getString(RemoteConfigKeys.aiSummaryButtonLabel);

  @override
  DateTime get lastFetchTime => _remoteConfig.lastFetchTime;

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
  List<String> get subscriptionFeatureHighlights {
    final jsonString = _remoteConfig.getString(
      RemoteConfigKeys.subscriptionFeatureHighlights,
    );
    try {
      return List<String>.from(jsonDecode(jsonString));
    } catch (e) {
      _logger.severe('Error parsing subscriptionFeatureHighlights', e);
      return _defaultSubscriptionFeatureHighlights;
    }
  }

  @override
  Map<String, String> get sectorDescriptions {
    final jsonString = _remoteConfig.getString(
      RemoteConfigKeys.sectorDescriptions,
    );
    try {
      final Map<String, dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      _logger.severe('Error parsing sectorDescriptions', e);
      return _defaultSectorDescriptions;
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
  CompanyTabsConfig get freeUsersCompanyTabsConfig => _companyTabsConfig(
    RemoteConfigKeys.freeUsersCompanyTabsConfig,
    _defaultFreeUsersCompanyTabsConfig,
  );

  @override
  CompanyTabsConfig get paidUsersCompanyTabsConfig => _companyTabsConfig(
    RemoteConfigKeys.paidUsersCompanyTabsConfig,
    _defaultPaidUsersCompanyTabsConfig,
  );

  CompanyTabsConfig _companyTabsConfig(
    String key,
    Map<String, dynamic> fallback,
  ) {
    final jsonString = _remoteConfig.getString(key);
    try {
      return CompanyTabsConfig.fromJson(jsonDecode(jsonString));
    } catch (e) {
      _logger.severe('Error parsing $key', e);
      return CompanyTabsConfig.fromJson(fallback);
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
  Future<bool> fetchAndActivate() => _remoteConfig.fetchAndActivate();

  @override
  Future<bool> activate() => _remoteConfig.activate();

  @override
  String get frankfurterBaseUrl =>
      _remoteConfig.getString(RemoteConfigKeys.frankfurterConfig);

  @override
  String get bizzieChatBaseUrl =>
      _remoteConfig.getString(RemoteConfigKeys.bizzieChatBaseUrl);

  @override
  bool get bizzieChatEnabled =>
      _remoteConfig.getBool(RemoteConfigKeys.bizzieChatEnabled);

  @override
  Stream<void> get onConfigUpdated => _remoteConfig.onConfigUpdated;
}
