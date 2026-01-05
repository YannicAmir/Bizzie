import 'dart:developer' as developer;
import 'package:logging/logging.dart';

class BizzieLogger {
  factory BizzieLogger(String name) {
    if (_instances.containsKey(name)) return _instances[name]!;

    return BizzieLogger._(Logger(name));
  }

  BizzieLogger._(this._logger);

  static final BizzieLogger shared = BizzieLogger('BizzieLogger');
  static final Map<String, BizzieLogger> _instances = {};
  final Logger _logger;

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

  static Stream<LogRecord> get logRecord => Logger.root.onRecord;

  void info(String message, [Object? error]) {
    _logger.info(message, error);
  }

  void warning(String message, [Object? error]) {
    _logger.warning(message, error);
  }

  void severe(String message, [Object? error, StackTrace? stack]) {
    _logger.severe(message, error, stack);
  }
}
