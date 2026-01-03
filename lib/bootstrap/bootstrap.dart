import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/enums/environment.dart';

import 'package:bizzie/di/injection.dart';

Future<void> bootstrap(
  Environment environment,
  FirebaseOptions firebaseOptions,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  BizzieLogger.init(dev: !kReleaseMode);

  await Firebase.initializeApp(options: firebaseOptions);
  await configureDependencies(environment.name);
  await GoogleSignIn.instance.initialize();

  try {
    await ConfigService.init();
  } catch (e) {
    debugPrint('Failed to initialize ConfigService: $e');
  }

  runApp(const BizzieApp());
}
