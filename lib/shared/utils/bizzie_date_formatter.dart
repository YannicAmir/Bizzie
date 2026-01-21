import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BizzieDateFormatter {
  static String formatLastUpdated(String dateStr) {
    try {
      final now = DateTime.now();
      final date = DateTime.tryParse(dateStr);
      if (date == null) return "Unknown";

      final yesterday = now.subtract(const Duration(days: 1));
      final isYesterday =
          date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day;
      final isToday =
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      // TODO: Replace with actual market close time or generic time if available
      const timeSuffix = "at 4:00 PM EST";

      if (isToday) {
        return "Today $timeSuffix";
      } else if (isYesterday) {
        return "Yesterday $timeSuffix";
      } else {
        final formatter = DateFormat('EEE, MMM dd yyyy');
        return "${formatter.format(date)} $timeSuffix";
      }
    } catch (e, stack) {
      debugPrint('Error formatting date: $e\n$stack');
      return dateStr;
    }
  }

  static String formatYearOnly(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat('yyyy').format(date);
  }

  static String formatMonthYearShort(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat("MMM ''yy").format(date);
  }

  static String formatChartLabel(String dateStr, {required bool isAnnual}) {
    return isAnnual ? formatYearOnly(dateStr) : formatMonthYearShort(dateStr);
  }
}
