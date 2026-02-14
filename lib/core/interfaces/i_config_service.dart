import 'package:bizzie/core/data/dtos/fmp_config.dart';

abstract class IConfigService {
  String get geminiModelName;
  List<String> get stockMarketSectors;
  FmpConfig get fmpConfig;
  String get privacyPolicyUrl;
  String get termsOfServiceUrl;

  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);

  String getSectorApiName(String sectorName);
  String getSectorDescription(String sectorName);
  String getSectorDisplayName(String sectorName);
}
