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

      final timeZone = now.timeZoneName;

      if (isToday) {
        final nowUtc = now.toUtc();
        final etTime = nowUtc.subtract(const Duration(hours: 5));

        final isAfterMarketCloseBuffer =
            etTime.hour > 16 || (etTime.hour == 16 && etTime.minute >= 15);

        final timeFormatter = DateFormat('h:mm a');

        if (isAfterMarketCloseBuffer) {
          final marketCloseUtc = DateTime.utc(
            etTime.year,
            etTime.month,
            etTime.day,
            21,
          );
          final marketCloseLocal = marketCloseUtc.toLocal();
          return "Today at ${timeFormatter.format(marketCloseLocal)} ${marketCloseLocal.timeZoneName}";
        }

        final fifteenMinutesAgo = now.subtract(const Duration(minutes: 15));
        return "Today at ${timeFormatter.format(fifteenMinutesAgo)} $timeZone (15 min delay)";
      } else {
        final dateFormatter = DateFormat('MMM dd, yyyy');
        final marketCloseUtc = DateTime.utc(
          date.year,
          date.month,
          date.day,
          21,
        );
        final marketCloseLocal = marketCloseUtc.toLocal();
        final timeFormatter = DateFormat('h:mm a');
        return "${dateFormatter.format(date)} at ${timeFormatter.format(marketCloseLocal)} ${marketCloseLocal.timeZoneName}";
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
