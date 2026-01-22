class MarketHoursHelper {
  static bool isMarketOpen() {
    final estNow = _toEasternTime(DateTime.now());

    if (estNow.weekday == DateTime.saturday ||
        estNow.weekday == DateTime.sunday) {
      return false;
    }

    final hour = estNow.hour;
    final minute = estNow.minute;

    if (hour < 9 || (hour == 9 && minute < 30)) return false;

    if (hour >= 16) return false;

    return true;
  }

  static bool isDataStale(DateTime? lastUpdated) {
    if (lastUpdated == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    if (isMarketOpen()) {
      return difference.inMinutes >= 15;
    } else {
      return !_isSameTradingDay(lastUpdated, now);
    }
  }

  static DateTime _toEasternTime(DateTime utc) {
    final utcTime = utc.toUtc();
    final offset = _isDst(utcTime) ? -4 : -5;
    return utcTime.add(Duration(hours: offset));
  }

  static bool _isDst(DateTime utc) {
    final month = utc.month;

    if (month < 3 || month > 11) return false;
    if (month > 3 && month < 11) return true;

    if (month == 3) {
      final secondSunday = _getNthWeekdayOfMonth(
        utc.year,
        3,
        DateTime.sunday,
        2,
      );
      return utc.day > secondSunday ||
          (utc.day == secondSunday && utc.hour >= 7);
    }

    final firstSunday = _getNthWeekdayOfMonth(utc.year, 11, DateTime.sunday, 1);
    return utc.day < firstSunday || (utc.day == firstSunday && utc.hour < 6);
  }

  static int _getNthWeekdayOfMonth(int year, int month, int weekday, int n) {
    var date = DateTime.utc(year, month, 1);
    var count = 0;
    while (count < n) {
      if (date.weekday == weekday) count++;
      if (count < n) date = date.add(const Duration(days: 1));
    }
    return date.day;
  }

  static bool _isSameTradingDay(DateTime date1, DateTime date2) {
    final estNow = _toEasternTime(date2);
    final estDate1 = _toEasternTime(date1);
    DateTime effectiveDate = estNow;
    if (estNow.hour < 9 || (estNow.hour == 9 && estNow.minute < 30)) {
      effectiveDate = estNow.subtract(const Duration(days: 1));
    }

    while (_isWeekend(effectiveDate)) {
      effectiveDate = effectiveDate.subtract(const Duration(days: 1));
    }

    final normalizedDate1 = DateTime(
      estDate1.year,
      estDate1.month,
      estDate1.day,
    );
    final normalizedDate2 = DateTime(
      effectiveDate.year,
      effectiveDate.month,
      effectiveDate.day,
    );

    return normalizedDate1 == normalizedDate2;
  }

  static bool _isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }
}
