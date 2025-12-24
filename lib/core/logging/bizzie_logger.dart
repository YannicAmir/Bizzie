import 'dart:developer' as developer;
import 'package:logging/logging.dart';

/// Centralized logger for Bizzie application.
class BizzieLogger {
  factory BizzieLogger(String name) {
    if (_instances.containsKey(name)) return _instances[name]!;

    return BizzieLogger._(Logger(name));
  }

  BizzieLogger._(this._logger);

  static final BizzieLogger shared = BizzieLogger('BizzieLogger');
  static final Map<String, BizzieLogger> _instances = {};
  final Logger _logger;

  /// Initializes the logger.
  /// [dev] - strict boolean to determine if we are in a development environment.
  static void init({required bool dev}) {
    if (dev) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        developer.log(
          '${record.level.name}: ${record.message}',
          name: record.loggerName,
          error: record.error,
        );
      });
    } else {
      // In non-dev environments (QA, Prod), restrict logging to WARNING and above.
      // We might want to hook this up to a remote logging service later.
      Logger.root.level = Level.WARNING;
    }
  }

  /// Exposes the LogRecord stream for telemetry tools.
  static Stream<LogRecord> get logRecord => Logger.root.onRecord;

  /// Log an info message.
  void info(String message, [Object? error]) {
    _logger.info(message, error);
  }

  /// Log a warning message.
  void warning(String message, [Object? error]) {
    _logger.warning(message, error);
  }

  /// Log a severe message (error).
  void severe(String message, [Object? error, StackTrace? stack]) {
    _logger.severe(message, error, stack);
  }
}
