import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:intl/intl.dart';

final _logger = BizzieLogger('BizzieDateFormatter');

class BizzieDateFormatter {
  static String formatLastUpdated(String dateStr) {
    try {
      final now = DateTime.now();
      final date = DateTime.tryParse(dateStr);
      if (date == null) return "Unknown";

      if (_isToday(date, now)) {
        return _formatToday(now, now.timeZoneName);
      } else {
        return _formatHistoricalDate(date);
      }
    } catch (e, stack) {
      _logger.severe('Error formatting date: $e', e, stack);
      return dateStr;
    }
  }

  static bool _isToday(DateTime date, DateTime now) {
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static String _formatToday(DateTime now, String timeZone) {
    final nowUtc = now.toUtc();
    final etTime = nowUtc.subtract(const Duration(hours: 5));

    if (_isAfterMarketCloseBuffer(etTime)) {
      return _formatMarketCloseBuffer(etTime);
    }

    final fifteenMinutesAgo = now.subtract(const Duration(minutes: 15));
    final timeFormatter = DateFormat('h:mm a');
    return "Today at ${timeFormatter.format(fifteenMinutesAgo)} $timeZone (15 min delay)";
  }

  static bool _isAfterMarketCloseBuffer(DateTime etTime) {
    return etTime.hour > 16 || (etTime.hour == 16 && etTime.minute >= 15);
  }

  static String _formatMarketCloseBuffer(DateTime etTime) {
    final marketCloseUtc = DateTime.utc(
      etTime.year,
      etTime.month,
      etTime.day,
      21,
    );
    final marketCloseLocal = marketCloseUtc.toLocal();
    final timeFormatter = DateFormat('h:mm a');
    return "Today at ${timeFormatter.format(marketCloseLocal)} ${marketCloseLocal.timeZoneName}";
  }

  static String _formatHistoricalDate(DateTime date) {
    final dateFormatter = DateFormat('MMM dd, yyyy');
    final marketCloseUtc = DateTime.utc(date.year, date.month, date.day, 21);
    final marketCloseLocal = marketCloseUtc.toLocal();
    final timeFormatter = DateFormat('h:mm a');
    return "${dateFormatter.format(date)} at ${timeFormatter.format(marketCloseLocal)} ${marketCloseLocal.timeZoneName}";
  }

  static String formatYearOnly(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat('yyyy').format(date);
  }

  static String formatMonthYearShort(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat("MMM dd, ''yy").format(date);
  }

  static String formatMonthYearFull(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatChartLabel(String dateStr, {required bool isAnnual}) {
    return isAnnual ? formatYearOnly(dateStr) : formatMonthYearShort(dateStr);
  }

  static String formatReferenceLabel(String dateStr, {required bool isAnnual}) {
    return formatMonthYearFull(dateStr);
  }
}
