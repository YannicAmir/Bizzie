import 'package:bizzie/core/data/dtos/fmp_config.dart';

abstract class IConfigService {
  String get geminiModelName;
  String get securityWatcherMail;
  List<String> get stockMarketSectors;
  Map<String, String> get sectorDescriptions;
  FmpConfig get fmpConfig;
  String get frankfurterBaseUrl;
  String get bizzieChatBaseUrl;
  bool get bizzieChatEnabled;
  String get privacyPolicyUrl;
  String get termsOfServiceUrl;
  String get minAppVersion;
  String get appStoreLink;
  String get playStoreLink;
  bool get maintenanceMode;
  bool get bypassTalsec;
  bool get forceImmediateFetch;
  int get freePlanHistoryCount;
  int get reviewPromptEventCount;
  String get aiSummaryButtonLabel;
  List<String> get subscriptionFeatureHighlights;
  DateTime get lastFetchTime;

  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);

  Future<bool> fetchAndActivate();
  Future<bool> activate();
  Stream<void> get onConfigUpdated;
}
