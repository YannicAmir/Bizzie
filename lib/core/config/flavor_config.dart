import 'package:bizzie/core/enums/environment.dart';
import 'package:meta/meta.dart';

class FlavorConfig {
  static Environment? _environment;

  static void init(String env) {
    _environment = Environment.values.firstWhere(
      (e) => e.name == env,
      orElse: () => Environment.dev,
    );
  }

  static bool get isProd => _environment == Environment.prod;
  static bool get isDev => _environment == Environment.dev;
  static bool get isQa => _environment == Environment.qa;

  @visibleForTesting
  static void reset() {
    _environment = null;
  }
}
