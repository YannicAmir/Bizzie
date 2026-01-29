import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

class DividendFormatters {
  static String formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatDate(String date) {
    if (date.isEmpty) return 'TBD';
    return BizzieDateFormatter.formatMonthYearOnly(date);
  }

  static String formatGrowthRate(double growth) {
    final prefix = growth >= 0 ? '+' : '';
    return '$prefix${growth.toStringAsFixed(1)}%';
  }

  static String formatDisplayValue(String val) {
    if (val == 'N/A' || val.isEmpty || val == 'TBD') return 'TBD';

    if (val.startsWith(r'$') || val.startsWith('+') || val.startsWith('-')) {
      return val;
    }

    return BizzieDateFormatter.formatMonthYearFull(val);
  }

  static String formatOptionalDate(String? date) {
    if (date == null || date.isEmpty || date == 'N/A') return 'TBD';
    return formatDisplayValue(date);
  }
}
