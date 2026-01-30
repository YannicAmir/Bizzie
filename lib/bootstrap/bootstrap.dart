import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/enums/environment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:bizzie/di/injection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final _logger = BizzieLogger('Bootstrap');

Future<void> bootstrap(
  Environment environment,
  FirebaseOptions firebaseOptions,
) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  BizzieLogger.init(dev: !kReleaseMode);

  await Firebase.initializeApp(options: firebaseOptions);
  await configureDependencies(environment.name);
  await getIt<IAuthRepository>().initialize();
  await getIt<ISubscriptionRepository>().initialize();

  try {
    await ConfigService.init();
  } catch (e) {
    _logger.severe('Failed to initialize ConfigService', e);
  }

  getIt<StockSearchService>().initialize();

  final initialRoute = await getIt<INotificationService>().getInitialRoute();
  runApp(BizzieApp(initialNotificationRoute: initialRoute));
}
