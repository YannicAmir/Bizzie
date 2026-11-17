import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';
import 'package:bizzie/features/reports/presentation/models/reports_feed_item.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

SecFiling _filing({DateTime? createdAt}) => SecFiling(
  id: 'id1',
  symbol: 'AAPL',
  companyName: 'Apple Inc.',
  filingDate: null,
  formType: '10-K',
  link: 'https://sec.gov',
  summary: 'Summary',
  createdAt: createdAt,
  analyzedAt: null,
);

WeeklyReport _weeklyReport({
  String ticker = 'AAPL',
  String id = '2026-05-27',
}) => WeeklyReport(ticker: ticker, id: id);

final _tToday = DateTime(2026, 5, 27);
final _tNoon = DateTime(2026, 5, 27, 12);

void main() {
  group('ReportsStateX.unreadCount', () {
    group('non-loaded states return zero', () {
      test('unreadCount_initialState_returnsZero', () {
        const state = ReportsState.initial();
        expect(state.unreadCount, 0);
      });

      test('unreadCount_loadingState_returnsZero', () {
        const state = ReportsState.loading();
        expect(state.unreadCount, 0);
      });

      test('unreadCount_failureState_returnsZero', () {
        final state = ReportsState.failure(Failure.server('error'));
        expect(state.unreadCount, 0);
      });
    });

    group('loaded state — filing count', () {
      test('unreadCount_noFilings_returnsZero', () {
        final state = ReportsState.loaded(const ReportsFeed(), today: _tToday);
        expect(state.unreadCount, 0);
      });

      test('unreadCount_todayFilingNullLastViewed_returnsOne', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: _tNoon)]),
          today: _tToday,
        );

        // act & assert
        expect(state.unreadCount, 1);
      });

      test('unreadCount_todayFilingAfterLastViewed_returnsOne', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: _tNoon)]),
          today: _tToday,
          lastViewedReports: _tNoon.subtract(const Duration(hours: 1)),
        );

        // act & assert
        expect(state.unreadCount, 1);
      });

      test('unreadCount_todayFilingBeforeLastViewed_returnsZero', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: _tNoon)]),
          today: _tToday,
          lastViewedReports: _tNoon.add(const Duration(hours: 1)),
        );

        // act & assert
        expect(state.unreadCount, 0);
      });

      test('unreadCount_yesterdayFiling_returnsZero', () {
        // arrange
        final yesterday = _tNoon.subtract(const Duration(days: 1));
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: yesterday)]),
          today: _tToday,
        );

        // act & assert
        expect(state.unreadCount, 0);
      });

      test('unreadCount_nullCreatedAtFiling_returnsZero', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: null)]),
          today: _tToday,
        );

        // act & assert
        expect(state.unreadCount, 0);
      });

      test('unreadCount_multipleTodayFilings_countsAll', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(
            filings: [
              _filing(createdAt: _tNoon),
              _filing(createdAt: _tNoon),
            ],
          ),
          today: _tToday,
        );

        // act & assert
        expect(state.unreadCount, 2);
      });

      test('unreadCount_mixedTodayAndPastFilings_countsOnlyToday', () {
        // arrange
        final yesterday = _tNoon.subtract(const Duration(days: 1));
        final state = ReportsState.loaded(
          ReportsFeed(
            filings: [
              _filing(createdAt: _tNoon),
              _filing(createdAt: yesterday),
              _filing(createdAt: null),
            ],
          ),
          today: _tToday,
        );

        // act & assert
        expect(state.unreadCount, 1);
      });

      test('unreadCount_stateDayRolledOver_excludesPreviousDayFilings', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: _tNoon)]),
          today: _tToday.add(const Duration(days: 1)),
        );

        // act & assert
        expect(state.unreadCount, 0);
      });
    });

    group('loaded state — weekly report count', () {
      test('unreadCount_unseenWeeklyReport_returnsOne', () {
        // arrange
        final state = ReportsState.loaded(
          const ReportsFeed(),
          today: _tToday,
          todaysWeeklyReports: [_weeklyReport()],
        );

        // act & assert
        expect(state.unreadCount, 1);
      });

      test('unreadCount_seenWeeklyReport_returnsZero', () {
        // arrange
        final report = _weeklyReport(ticker: 'AAPL', id: '2026-05-27');
        final state = ReportsState.loaded(
          const ReportsFeed(),
          today: _tToday,
          seenWeeklyReportIds: {report.seenKey},
          todaysWeeklyReports: [report],
        );

        // act & assert
        expect(state.unreadCount, 0);
      });

      test('unreadCount_partiallySeenWeeklyReports_countsOnlyUnseen', () {
        // arrange
        final seen = _weeklyReport(ticker: 'AAPL', id: '2026-05-27');
        final unseen = _weeklyReport(ticker: 'MSFT', id: '2026-05-27');
        final state = ReportsState.loaded(
          const ReportsFeed(),
          today: _tToday,
          seenWeeklyReportIds: {seen.seenKey},
          todaysWeeklyReports: [seen, unseen],
        );

        // act & assert
        expect(state.unreadCount, 1);
      });
    });

    group('loaded state — combined count', () {
      test('unreadCount_todayFilingAndUnseenWeekly_returnsCombinedCount', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: _tNoon)]),
          today: _tToday,
          todaysWeeklyReports: [_weeklyReport()],
        );

        // act & assert
        expect(state.unreadCount, 2);
      });

      test('unreadCount_allSeen_returnsZero', () {
        // arrange
        final report = _weeklyReport();
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: _tNoon)]),
          today: _tToday,
          lastViewedReports: _tNoon.add(const Duration(hours: 1)),
          seenWeeklyReportIds: {report.seenKey},
          todaysWeeklyReports: [report],
        );

        // act & assert
        expect(state.unreadCount, 0);
      });
    });
  });

  group('ReportsLoadedX.feedItems', () {
    test('feedItems_noRecentItems_returnsEmpty', () {
      // arrange
      final sut = ReportsLoaded(const ReportsFeed(), today: _tToday);

      // act
      final result = sut.feedItems;

      // assert
      expect(result, isEmpty);
    });

    test('feedItems_mixedItems_returnsNewestFirst', () {
      // arrange
      final tMorning = FilingViewModel(
        filing: _filing(createdAt: DateTime(2026, 5, 27, 9)),
      );
      final tEvening = FilingViewModel(
        filing: _filing(createdAt: DateTime(2026, 5, 27, 18)),
      );
      final tEarlier = FilingViewModel(
        filing: _filing(createdAt: DateTime(2026, 3, 2, 12)),
      );
      final tWeekly = WeeklyReport(
        ticker: 'AAPL',
        id: '2026-05-27',
        createdAt: DateTime(2026, 5, 27, 12),
      );
      final sut = ReportsLoaded(
        const ReportsFeed(),
        today: _tToday,
        recentFilings: [tEarlier, tMorning, tEvening],
        recentWeeklyReports: [tWeekly],
      );

      // act
      final result = sut.feedItems;

      // assert
      expect(result, [
        ReportsFeedItem.filing(tEvening),
        ReportsFeedItem.weekly(tWeekly),
        ReportsFeedItem.filing(tMorning),
        ReportsFeedItem.filing(tEarlier),
      ]);
    });

    test('feedItems_weeklyReportWithUnparseableId_isExcluded', () {
      // arrange
      final sut = ReportsLoaded(
        const ReportsFeed(),
        today: _tToday,
        recentWeeklyReports: [_weeklyReport(id: 'not-a-date')],
      );

      // act
      final result = sut.feedItems;

      // assert
      expect(result, isEmpty);
    });

    test('feedItems_weeklyReportWithoutCreatedAt_sortsByReportDate', () {
      // arrange
      final tNewer = FilingViewModel(
        filing: _filing(createdAt: DateTime(2026, 5, 28, 9)),
      );
      final tOlder = FilingViewModel(
        filing: _filing(createdAt: DateTime(2026, 5, 26, 9)),
      );
      final tWeekly = _weeklyReport(id: '2026-05-27');
      final sut = ReportsLoaded(
        const ReportsFeed(),
        today: _tToday,
        recentFilings: [tOlder, tNewer],
        recentWeeklyReports: [tWeekly],
      );

      // act
      final result = sut.feedItems;

      // assert
      expect(result, [
        ReportsFeedItem.filing(tNewer),
        ReportsFeedItem.weekly(tWeekly),
        ReportsFeedItem.filing(tOlder),
      ]);
    });
  });
}
