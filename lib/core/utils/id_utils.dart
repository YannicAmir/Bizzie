import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class IdUtils {
  IdUtils._();

  /// Generates a UUID v4 (randomly generated, cryptographically strong).
  static String generateSessionId() => _uuid.v4();
}
