import "package:firebase_core/firebase_core.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bizzie/app/bizzie_app.dart';
import 'package:bizzie/core/enums/environment.dart';

import 'package:bizzie/di/injection.dart';

Future<void> bootstrap(Environment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(environment.name);
  await Firebase.initializeApp();
  await GoogleSignIn.instance.initialize();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(const BizzieApp());
}
