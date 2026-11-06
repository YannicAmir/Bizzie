import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:bizzie/shared/widgets/cards/sec_filing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const tLabel = 'Summarize';
const tFiling = SecFiling(
  id: 'f',
  symbol: 'AAPL',
  companyName: 'Apple Inc.',
  filingDate: null,
  formType: '10-K',
  link: '',
  summary: 'Summary',
  createdAt: null,
  analyzedAt: null,
);

void main() {
  Widget host(SecFilingCard card) => MaterialApp(home: Scaffold(body: card));

  group('SecFilingCard', () {
    testWidgets('build_noCompanyCallback_headerIsNotTappable', (tester) async {
      // arrange
      const sut = SecFilingCard(
        filing: tFiling,
        summaryButtonLabel: tLabel,
        isSummaryLocked: false,
      );

      // act
      await tester.pumpWidget(host(sut));

      // assert
      final header = tester.widget<FilingCardHeader>(
        find.byType(FilingCardHeader),
      );
      expect(header.onCompanyTapped, isNull);
    });

    testWidgets('tapViewReport_emptyLink_notifiesCallback', (tester) async {
      // arrange
      var tapped = false;
      final sut = SecFilingCard(
        filing: tFiling,
        summaryButtonLabel: tLabel,
        isSummaryLocked: false,
        onViewReportTapped: () => tapped = true,
      );
      await tester.pumpWidget(host(sut));

      // act
      await tester.tap(find.text('View Full Report'));

      // assert
      expect(tapped, isTrue);
    });

    testWidgets('tapSummary_locked_callsLockedCallbackOnly', (tester) async {
      // arrange
      var lockedTaps = 0;
      var requests = 0;
      final sut = SecFilingCard(
        filing: tFiling,
        summaryButtonLabel: tLabel,
        isSummaryLocked: true,
        onLockedSummaryTapped: () => lockedTaps++,
        onSummaryRequested: (_) => requests++,
      );
      await tester.pumpWidget(host(sut));

      // act
      await tester.tap(find.text(tLabel));
      await tester.pumpAndSettle();

      // assert
      expect(lockedTaps, 1);
      expect(requests, 0);
      expect(find.text('Analysis in Progress'), findsNothing);
    });

    testWidgets('tapSummary_unlockedWithoutReport_showsInProgressModal', (
      tester,
    ) async {
      // arrange
      bool? isReady;
      final sut = SecFilingCard(
        filing: tFiling,
        summaryButtonLabel: tLabel,
        isSummaryLocked: false,
        onSummaryRequested: (ready) => isReady = ready,
      );
      await tester.pumpWidget(host(sut));

      // act
      await tester.tap(find.text(tLabel));
      await tester.pumpAndSettle();

      // assert
      expect(isReady, isFalse);
      expect(find.text('Analysis in Progress'), findsOneWidget);
    });

    testWidgets('build_nonEarningsEightK_hidesSummaryButton', (tester) async {
      // arrange
      final sut = SecFilingCard(
        filing: tFiling.copyWith(formType: '8-K'),
        summaryButtonLabel: tLabel,
        isSummaryLocked: false,
      );

      // act
      await tester.pumpWidget(host(sut));

      // assert
      expect(find.text(tLabel), findsNothing);
    });
  });
}
