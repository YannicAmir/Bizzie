import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/shared/widgets/cards/weekly_report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _report = WeeklyReport(
  id: '2026-01-09',
  ticker: 'AXP',
  companyName: 'American Express Company',
  messageShortSummary: 'Short summary',
);

void main() {
  Widget host(WeeklyReportCard card) => MaterialApp(home: Scaffold(body: card));

  group('WeeklyReportCard', () {
    testWidgets('build_report_showsSummaryAndFilingType', (tester) async {
      // act
      await tester.pumpWidget(
        host(const WeeklyReportCard(report: _report, isLocked: false)),
      );

      // assert
      expect(find.text('Short summary'), findsOneWidget);
      expect(find.text(WeeklyReportCard.filingType), findsOneWidget);
    });

    testWidgets('tap_locked_callsLockedCallbackOnly', (tester) async {
      // arrange
      var lockedTaps = 0;
      var opened = 0;
      await tester.pumpWidget(
        host(
          WeeklyReportCard(
            report: _report,
            isLocked: true,
            onLockedTapped: () => lockedTaps++,
            onReportOpened: () => opened++,
          ),
        ),
      );

      // act
      await tester.tap(find.text('View Full Report'));

      // assert
      expect(lockedTaps, 1);
      expect(opened, 0);
    });

    testWidgets('tap_unlocked_callsOpenedCallbackOnly', (tester) async {
      // arrange
      var lockedTaps = 0;
      var opened = 0;
      await tester.pumpWidget(
        host(
          WeeklyReportCard(
            report: _report,
            isLocked: false,
            onLockedTapped: () => lockedTaps++,
            onReportOpened: () => opened++,
          ),
        ),
      );

      // act
      await tester.tap(find.text('View Full Report'));

      // assert
      expect(opened, 1);
      expect(lockedTaps, 0);
    });
  });
}
