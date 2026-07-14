import 'dart:async';
import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/config/flavor_config.dart';
import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart' as tz;

final _logger = BizzieLogger('Bootstrap');

Future<void> bootstrap(
  Environment environment,
  FirebaseOptions firebaseOptions,
) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  FlavorConfig.init(environment.name);
  GoogleFonts.config.allowRuntimeFetching = false;
  tz.initializeTimeZones();
  BizzieLogger.init(dev: !kReleaseMode);

  FlutterError.onError = (details) {
    _logger.severe(
      'Flutter Framework Error: ${details.exceptionAsString()}',
      details.exception,
      details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    _logger.severe('Uncaught Async/Platform Error', error, stack);
    return true;
  };

  await Firebase.initializeApp(options: firebaseOptions);

  await configureDependencies(environment.name);

  await getIt<IAuthRepository>().initialize();
  await getIt<ISubscriptionRepository>().initialize();
  getIt<StockSearchService>().initialize();

  final initialPayload = await getIt<INotificationService>()
      .getInitialPayload();
  runApp(
    BizzieApp(
      environment: environment,
      initialNotificationPayload: initialPayload,
    ),
  );
}
