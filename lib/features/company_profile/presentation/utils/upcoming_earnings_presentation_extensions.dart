import 'package:intl/intl.dart';

extension UpcomingEarningsDateX on DateTime {
  /// Returns a formatted string like "6 days away"
  String get daysAwayLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final earningsDay = DateTime(year, month, day);
    final difference = earningsDay.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    return '$difference days away';
  }

  /// Returns a formatted string like "Fri. Jan. 30, 2026"
  String get formattedEarningsDate {
    return DateFormat('EEE. MMM. dd, yyyy').format(this);
  }
}
