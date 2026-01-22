import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BizzieDateFormatter {
  static String formatLastUpdated(String dateStr) {
    try {
      final now = DateTime.now();
      final date = DateTime.tryParse(dateStr);
      if (date == null) return "Unknown";

      final isToday =
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      if (isToday) {
        final fifteenMinutesAgo = now.subtract(const Duration(minutes: 15));
        final timeFormatter = DateFormat('h:mm a');
        return "Today at ${timeFormatter.format(fifteenMinutesAgo)} (15 min delay)";
      } else {
        final dateFormatter = DateFormat('MMM dd, yyyy');
        return "${dateFormatter.format(date)} at 4:00 PM EST";
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

  static String formatMonthYearFull(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat('MMM yyyy').format(date);
  }

  static String formatChartLabel(String dateStr, {required bool isAnnual}) {
    return isAnnual ? formatYearOnly(dateStr) : formatMonthYearShort(dateStr);
  }

  static String formatReferenceLabel(String dateStr, {required bool isAnnual}) {
    return isAnnual ? formatYearOnly(dateStr) : formatMonthYearFull(dateStr);
  }
}
