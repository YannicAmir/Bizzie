import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double value, String currency, {String? locale}) {
    return NumberFormat.simpleCurrency(
      name: currency,
      locale: locale,
    ).format(value);
  }

  static String formatCompact(double value, String currency, {String? locale}) {
    return NumberFormat.compactSimpleCurrency(
      name: currency,
      locale: locale,
    ).format(value);
  }
}
