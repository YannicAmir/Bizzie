import 'package:intl/intl.dart';

class DividendFormatters {
  static String formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatDate(String date, {String format = 'MMM yyyy'}) {
    if (date.isEmpty) return 'TBD';
    try {
      return DateFormat(format).format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  static String formatGrowthRate(double growth) {
    final prefix = growth >= 0 ? '+' : '';
    return '$prefix${growth.toStringAsFixed(1)}%';
  }

  static String formatDisplayValue(String val) {
    if (val == 'N/A' || val.isEmpty) return 'TBD';

    if (val.startsWith(r'$') || val.startsWith('+') || val.startsWith('-')) {
      return val;
    }

    try {
      final parsed = DateTime.parse(val);
      return DateFormat('MMM d, yyyy').format(parsed);
    } catch (_) {
      return val;
    }
  }

  static String formatOptionalDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    return formatDisplayValue(date);
  }
}
