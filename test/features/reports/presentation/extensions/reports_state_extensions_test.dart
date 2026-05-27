import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';
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

WeeklyReport _weeklyReport({String ticker = 'AAPL', String id = '2026-05-27'}) =>
    WeeklyReport(ticker: ticker, id: id);

void main() {
  group('ReportsStateExtension.unreadCount', () {
    group('non-loaded states return zero', () {
      test('unreadCount_initialState_returnsZero', () {
        const state = ReportsState.initial();
        expect(state.unreadCount({}), 0);
      });

      test('unreadCount_loadingState_returnsZero', () {
        const state = ReportsState.loading();
        expect(state.unreadCount({}), 0);
      });

      test('unreadCount_failureState_returnsZero', () {
        final state = ReportsState.failure(Failure.server('error'));
        expect(state.unreadCount({}), 0);
      });
    });

    group('loaded state — filing count', () {
      test('unreadCount_noFilings_returnsZero', () {
        const state = ReportsState.loaded(ReportsFeed());
        expect(state.unreadCount({}), 0);
      });

      test('unreadCount_todayFilingNullLastViewed_returnsOne', () {
        // arrange
        final now = DateTime.now();
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: now)]),
        );

        // act & assert
        expect(state.unreadCount({}), 1);
      });

      test('unreadCount_todayFilingAfterLastViewed_returnsOne', () {
        // arrange
        final now = DateTime.now();
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: now)]),
          lastViewedReports: now.subtract(const Duration(hours: 1)),
        );

        // act & assert
        expect(state.unreadCount({}), 1);
      });

      test('unreadCount_todayFilingBeforeLastViewed_returnsZero', () {
        // arrange
        final now = DateTime.now();
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: now)]),
          lastViewedReports: now.add(const Duration(hours: 1)),
        );

        // act & assert
        expect(state.unreadCount({}), 0);
      });

      test('unreadCount_yesterdayFiling_returnsZero', () {
        // arrange
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: yesterday)]),
        );

        // act & assert
        expect(state.unreadCount({}), 0);
      });

      test('unreadCount_nullCreatedAtFiling_returnsZero', () {
        // arrange
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: null)]),
        );

        // act & assert
        expect(state.unreadCount({}), 0);
      });

      test('unreadCount_multipleTodayFilings_countsAll', () {
        // arrange
        final now = DateTime.now();
        final state = ReportsState.loaded(
          ReportsFeed(
            filings: [
              _filing(createdAt: now),
              _filing(createdAt: now),
            ],
          ),
        );

        // act & assert
        expect(state.unreadCount({}), 2);
      });

      test('unreadCount_mixedTodayAndPastFilings_countsOnlyToday', () {
        // arrange
        final now = DateTime.now();
        final yesterday = now.subtract(const Duration(days: 1));
        final state = ReportsState.loaded(
          ReportsFeed(
            filings: [
              _filing(createdAt: now),
              _filing(createdAt: yesterday),
              _filing(createdAt: null),
            ],
          ),
        );

        // act & assert
        expect(state.unreadCount({}), 1);
      });
    });

    group('loaded state — weekly report count', () {
      test('unreadCount_unseenWeeklyReport_returnsOne', () {
        // arrange
        final state = ReportsState.loaded(
          const ReportsFeed(),
          todaysWeeklyReports: [_weeklyReport()],
        );

        // act & assert
        expect(state.unreadCount({}), 1);
      });

      test('unreadCount_seenWeeklyReport_returnsZero', () {
        // arrange
        final report = _weeklyReport(ticker: 'AAPL', id: '2026-05-27');
        final state = ReportsState.loaded(
          const ReportsFeed(),
          todaysWeeklyReports: [report],
        );

        // act & assert
        expect(state.unreadCount({report.seenKey}), 0);
      });

      test('unreadCount_partiallySeenWeeklyReports_countsOnlyUnseen', () {
        // arrange
        final seen = _weeklyReport(ticker: 'AAPL', id: '2026-05-27');
        final unseen = _weeklyReport(ticker: 'MSFT', id: '2026-05-27');
        final state = ReportsState.loaded(
          const ReportsFeed(),
          todaysWeeklyReports: [seen, unseen],
        );

        // act & assert
        expect(state.unreadCount({seen.seenKey}), 1);
      });
    });

    group('loaded state — combined count', () {
      test('unreadCount_todayFilingAndUnseenWeekly_returnsCombinedCount', () {
        // arrange
        final now = DateTime.now();
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: now)]),
          todaysWeeklyReports: [_weeklyReport()],
        );

        // act & assert
        expect(state.unreadCount({}), 2);
      });

      test('unreadCount_allSeen_returnsZero', () {
        // arrange
        final now = DateTime.now();
        final report = _weeklyReport();
        final state = ReportsState.loaded(
          ReportsFeed(filings: [_filing(createdAt: now)]),
          lastViewedReports: now.add(const Duration(hours: 1)),
          todaysWeeklyReports: [report],
        );

        // act & assert
        expect(state.unreadCount({report.seenKey}), 0);
      });
    });
  });
}
