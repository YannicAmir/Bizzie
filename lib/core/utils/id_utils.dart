import 'package:nanoid/nanoid.dart';

class IdUtils {
  IdUtils._();

  /// Generates a short, URL-friendly unique session ID (default 8 characters).
  static String generateSessionId([int length = 8]) => nanoid(length);
}
