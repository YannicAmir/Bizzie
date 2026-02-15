import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:intl/intl.dart';

final _logger = BizzieLogger('BizzieDateFormatter');

class BizzieDateFormatter {
  static const String fullDateFormat = "MMM. dd, yyyy";
  static const String shortDateFormat = "MMM. dd, ''yy";
  static const String monthYearFormat = "MMM. yyyy";

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
    final dateFormatter = DateFormat(fullDateFormat);
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
    return DateFormat(shortDateFormat).format(date);
  }

  static String formatMonthYearFull(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat(fullDateFormat).format(date);
  }

  static String formatMonthYearOnly(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat(monthYearFormat).format(date);
  }

  static String formatChartLabel(String dateStr, {required bool isAnnual}) {
    return isAnnual ? formatYearOnly(dateStr) : formatMonthYearShort(dateStr);
  }

  static String formatReferenceLabel(String dateStr, {required bool isAnnual}) {
    return formatMonthYearFull(dateStr);
  }

  static String formatApiDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatApiDateFromStr(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return formatApiDate(date);
  }

  static String formatHumanFriendlyDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(date.year, date.month, date.day);
    final difference = eventDay.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 0 && difference <= 7) {
      return 'In $difference days';
    } else if (difference < 0) {
      return '${difference.abs()} days ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
}
