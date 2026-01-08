class StringUtils {
  static String sanitizeTopic(String input) {
    return input
        .trim()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '')
        .toLowerCase();
  }

  static String sanitizeTicker(String input) {
    return input
        .trim()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '')
        .toUpperCase();
  }
}
