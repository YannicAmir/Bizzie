import 'package:envied/envied.dart';

part 'qa_env.g.dart';

@Envied(path: '.env.qa', obfuscate: true)
abstract class QaEnv {
  @EnviedField(varName: 'FMP_API_KEY')
  static final String fmpApiKey = _QaEnv.fmpApiKey;

  @EnviedField(varName: 'REVENUECAT_PUBLIC_API_KEY_IOS')
  static final String revenueCatApiKeyIos = _QaEnv.revenueCatApiKeyIos;
}
