import 'package:intl/intl.dart';

class ReportsDateFormatter {
  static String getRelativeDateLabel(DateTime? date) {
    if (date == null) return 'TBD';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final inputDate = DateTime(date.year, date.month, date.day);
    final difference = inputDate.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';

    final dayOfWeek = DateFormat('E').format(date);
    return '$dayOfWeek., in $difference days';
  }

  static String formatReportDate(DateTime? date) {
    if (date == null) return 'Date Unknown';
    return DateFormat('MMM d, yyyy').format(date);
  }
}
