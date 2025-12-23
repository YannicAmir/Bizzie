import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Centralized logger for Bizzie application.
/// strictly controls output based on the environment.
class BizzieLogger {
  static final Logger _logger = Logger('Bizzie');

  /// Initializes the logger.
  /// Should be called in bootstrap.dart.
  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print(
          '[Bizzie] [${record.level.name}] ${record.time}: ${record.message}',
        );
        if (record.error != null) {
          print('Error: ${record.error}');
        }
        if (record.stackTrace != null) {
          print('Stack: ${record.stackTrace}');
        }
      }
    });
  }

  /// Log an info message.
  static void info(String message, [Object? error]) {
    if (!kDebugMode) return;
    _logger.info(message, error);
  }

  /// Log a warning message.
  static void warning(String message, [Object? error]) {
    if (!kDebugMode) return;
    _logger.warning(message, error);
  }

  /// Log a severe message (error).
  static void severe(String message, [Object? error, StackTrace? stack]) {
    if (!kDebugMode) return;
    _logger.severe(message, error, stack);
  }
}
