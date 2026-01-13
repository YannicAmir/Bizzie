import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';

extension ReportsStateExtension on ReportsState {
  int get unreadCount {
    return maybeMap(
      loaded: (s) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        return s.feed.filings.where((f) {
          if (f.createdAt == null) return false;
          final filingDate = f.createdAt!;
          final isToday =
              filingDate.year == today.year &&
              filingDate.month == today.month &&
              filingDate.day == today.day;

          if (!isToday) return false;

          if (s.lastViewedReports == null) return true;
          return filingDate.isAfter(s.lastViewedReports!);
        }).length;
      },
      orElse: () => 0,
    );
  }
}
