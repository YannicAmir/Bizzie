import 'package:envied/envied.dart';

part 'dev_env.g.dart';

@Envied(path: '.env.dev', obfuscate: true)
abstract class DevEnv {
  @EnviedField(varName: 'FMP_API_KEY')
  static final String fmpApiKey = _DevEnv.fmpApiKey;

  @EnviedField(varName: 'REVENUECAT_PUBLIC_API_KEY_IOS')
  static final String revenueCatApiKeyIos = _DevEnv.revenueCatApiKeyIos;
}
