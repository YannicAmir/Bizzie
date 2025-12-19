import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bizzie/app/app.dart';
import 'package:bizzie/core/enums/environment.dart';

Future<void> bootstrap(Environment environment) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(const App());
}
