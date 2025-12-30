import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/enums/environment.dart';

import 'package:bizzie/di/injection.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> bootstrap(
  Environment environment,
  FirebaseOptions firebaseOptions,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  BizzieLogger.init(dev: !kReleaseMode);

  configureDependencies(environment.name);
  await Firebase.initializeApp(options: firebaseOptions);
  await GoogleSignIn.instance.initialize();

  // Fetch remote config at startup
  try {
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (e) {
    // Log error but allow app to continue with defaults
    debugPrint('Failed to fetch remote config: $e');
  }

  runApp(const BizzieApp());
}
