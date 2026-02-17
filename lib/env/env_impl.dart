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

  @override
  String get appleTeamId => DevEnv.appleTeamId;

  @override
  String get bundleId => DevEnv.bundleId;

  @override
  Duration get minimumFetchInterval => Duration.zero;
}

@Environment('qa')
@Singleton(as: AppEnv)
class QaEnvImpl implements AppEnv {
  @override
  String get fmpApiKey => QaEnv.fmpApiKey;
  @override
  String get revenueCatApiKeyIos => QaEnv.revenueCatApiKeyIos;
  @override
  String get appleTeamId => QaEnv.appleTeamId;
  @override
  String get bundleId => QaEnv.bundleId;
  @override
  Duration get minimumFetchInterval => const Duration(seconds: 10);
}

@Environment('prod')
@Singleton(as: AppEnv)
class ProdEnvImpl implements AppEnv {
  @override
  String get fmpApiKey => ProdEnv.fmpApiKey;
  @override
  String get revenueCatApiKeyIos => ProdEnv.revenueCatApiKeyIos;
  @override
  String get appleTeamId => ProdEnv.appleTeamId;
  @override
  String get bundleId => ProdEnv.bundleId;
  @override
  Duration get minimumFetchInterval => const Duration(hours: 1);
}
