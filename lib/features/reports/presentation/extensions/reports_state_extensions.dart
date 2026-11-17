import 'package:bizzie/core/utils/date_utils.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/models/reports_feed_item.dart';
import 'package:collection/collection.dart';

extension ReportsStateX on ReportsState {
  int get unreadCount {
    return maybeMap(
      loaded: (loaded) {
        bool isFilingUnread(DateTime? createdAt) {
          if (createdAt == null) return false;
          if (!BizzieDateUtils.isSameDay(createdAt, loaded.today)) {
            return false;
          }
          final lastViewed = loaded.lastViewedReports;
          return lastViewed == null || createdAt.isAfter(lastViewed);
        }

        final filingCount = loaded.feed.filings
            .where((filing) => isFilingUnread(filing.createdAt))
            .length;

        final weeklyCount = loaded.todaysWeeklyReports
            .where(
              (report) => !loaded.seenWeeklyReportIds.contains(report.seenKey),
            )
            .length;

        return filingCount + weeklyCount;
      },
      orElse: () => 0,
    );
  }
}

extension ReportsLoadedX on ReportsLoaded {
  List<ReportsFeedItem> get feedItems =>
      [
            ...recentFilings.map(ReportsFeedItem.filing),
            ...recentWeeklyReports.map(ReportsFeedItem.weekly),
          ]
          .where((item) => item.isDated)
          .sorted(
            (newer, older) => BizzieDateUtils.compareNewestFirst(
              newer.sortDate,
              older.sortDate,
            ),
          );
}
