import 'package:intl/intl.dart';

class CurrencyFormatter {
  static const int _fixedFractionDigits = 2;

  static String format(double value, String? currency, {String? locale}) {
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

  static String formatCompactFixed(
    double value,
    String? currency, {
    String? locale,
  }) {
    final format = NumberFormat.compactSimpleCurrency(
      name: currency,
      locale: locale,
    );
    format.maximumFractionDigits = _fixedFractionDigits;
    format.minimumFractionDigits = _fixedFractionDigits;
    return format.format(value);
  }
}
