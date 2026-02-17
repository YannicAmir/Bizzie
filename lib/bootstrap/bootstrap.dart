import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/config/flavor_config.dart';
import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/env/env_impl.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/security_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> bootstrap(
  Environment environment,
  FirebaseOptions firebaseOptions,
) async {
  FlavorConfig.init(environment.name);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  BizzieLogger.init(dev: !kReleaseMode);

  await Firebase.initializeApp(options: firebaseOptions);
  final AppEnv env = switch (environment) {
    Environment.dev => DevEnvImpl(),
    Environment.qa => QaEnvImpl(),
    Environment.prod => ProdEnvImpl(),
  };

  final configService = await ConfigService.init(env);

  getIt.registerSingleton<IConfigService>(configService);
  getIt.registerSingleton<SecurityService>(SecurityService(env, configService));

  await getIt<SecurityService>().init();

  await configureDependencies(environment.name);
  await getIt<IAuthRepository>().initialize();
  await getIt<ISubscriptionRepository>().initialize();

  getIt<StockSearchService>().initialize();

  final initialRoute = await getIt<INotificationService>().getInitialRoute();
  runApp(
    BizzieApp(environment: environment, initialNotificationRoute: initialRoute),
  );
}
