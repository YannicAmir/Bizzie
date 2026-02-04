import 'package:injectable/injectable.dart';
import 'app_env.dart';
import 'dev_env.dart';
import 'qa_env.dart';
import 'prod_env.dart';

@Environment('dev')
@Singleton(as: AppEnv)
class DevEnvImpl implements AppEnv {
  @override
  String get fmpApiKey => DevEnv.fmpApiKey;

  @override
  String get revenueCatApiKeyIos => DevEnv.revenueCatApiKeyIos;
}

@Environment('qa')
@Singleton(as: AppEnv)
class QaEnvImpl implements AppEnv {
  @override
  String get fmpApiKey => QaEnv.fmpApiKey;

  @override
  String get revenueCatApiKeyIos => QaEnv.revenueCatApiKeyIos;
}

@Environment('prod')
@Singleton(as: AppEnv)
class ProdEnvImpl implements AppEnv {
  @override
  String get fmpApiKey => ProdEnv.fmpApiKey;

  @override
  String get revenueCatApiKeyIos => ProdEnv.revenueCatApiKeyIos;
}
