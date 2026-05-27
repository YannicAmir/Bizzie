import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';

extension ReportsStateExtension on ReportsState {
  int unreadCount(Set<String> seenWeeklyReportIds) {
    return maybeMap(
      loaded: (s) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        bool isFilingUnread(DateTime? createdAt) {
          if (createdAt == null) return false;
          final isToday =
              createdAt.year == today.year &&
              createdAt.month == today.month &&
              createdAt.day == today.day;
          if (!isToday) return false;
          if (s.lastViewedReports == null) return true;
          return createdAt.isAfter(s.lastViewedReports!);
        }

        final filingCount =
            s.feed.filings.where((f) => isFilingUnread(f.createdAt)).length;

        final weeklyCount = s.todaysWeeklyReports
            .where((r) => !seenWeeklyReportIds.contains(r.seenKey))
            .length;

        return filingCount + weeklyCount;
      },
      orElse: () => 0,
    );
  }
}
