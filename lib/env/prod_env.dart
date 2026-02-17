import 'package:envied/envied.dart';

part 'prod_env.g.dart';

@Envied(path: '.env.prod', obfuscate: true)
abstract class ProdEnv {
  @EnviedField(varName: 'FMP_API_KEY')
  static final String fmpApiKey = _ProdEnv.fmpApiKey;

  @EnviedField(varName: 'REVENUECAT_PUBLIC_API_KEY_IOS')
  static final String revenueCatApiKeyIos = _ProdEnv.revenueCatApiKeyIos;

  @EnviedField(varName: 'APPLE_TEAM_ID')
  static final String appleTeamId = _ProdEnv.appleTeamId;

  @EnviedField(varName: 'BUNDLE_ID')
  static final String bundleId = _ProdEnv.bundleId;
}
