import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/enums/environment.dart';

import 'package:bizzie/di/injection.dart';

import 'package:bizzie/config/firebase/firebase_options_dev.dart'
    as dev_options;
import 'package:bizzie/config/firebase/firebase_options_qa.dart' as qa_options;
import 'package:bizzie/config/firebase/firebase_options_prod.dart'
    as prod_options;

Future<void> bootstrap(Environment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  BizzieLogger.init(dev: !kReleaseMode);

  FirebaseOptions firebaseOptions;
  switch (environment) {
    case Environment.dev:
      firebaseOptions = dev_options.DefaultFirebaseOptions.currentPlatform;
      break;
    case Environment.qa:
      firebaseOptions = qa_options.DefaultFirebaseOptions.currentPlatform;
      break;
    case Environment.prod:
      firebaseOptions = prod_options.DefaultFirebaseOptions.currentPlatform;
      break;
  }

  configureDependencies(environment.name);
  await Firebase.initializeApp(options: firebaseOptions);
  await GoogleSignIn.instance.initialize();

  runApp(const BizzieApp());
}
