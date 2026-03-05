import 'package:intl/intl.dart';

extension UpcomingEarningsDateX on DateTime {
  int calendarDaysAway([DateTime? now]) {
    final reference = now ?? DateTime.now();
    final start = DateTime.utc(reference.year, reference.month, reference.day);
    final end = DateTime.utc(year, month, day);
    return end.difference(start).inDays;
  }

  String get daysAwayLabel => getDaysAwayLabel();

  String getDaysAwayLabel([DateTime? now]) {
    final difference = calendarDaysAway(now);

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    return '$difference days away';
  }

  String get formattedEarningsDate {
    return DateFormat('EEE. MMM. dd, yyyy').format(this);
  }
}
