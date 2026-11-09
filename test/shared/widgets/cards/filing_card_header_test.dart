import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const tFormType = '8-K';

void main() {
  Widget host(FilingCardHeader header) =>
      MaterialApp(home: Scaffold(body: header));

  group('FilingCardHeader', () {
    testWidgets('build_withTopic_showsMutedBadgeBesideFormBadge', (
      tester,
    ) async {
      // arrange
      const sut = FilingCardHeader(
        ticker: 'AXP',
        companyName: 'American Express Company',
        formType: tFormType,
        topic: 'Earnings',
      );

      // act
      await tester.pumpWidget(host(sut));

      // assert
      final badges = tester.widgetList<AppBadge>(find.byType(AppBadge));
      expect(badges.map((badge) => (badge.text, badge.style, badge.isLarge)), [
        (tFormType, AppBadgeStyle.neutral, true),
        ('Earnings', AppBadgeStyle.muted, true),
      ]);
    });

    testWidgets('build_withoutTopic_showsFormBadgeOnly', (tester) async {
      // arrange
      const sut = FilingCardHeader(
        ticker: 'AXP',
        companyName: 'American Express Company',
        formType: '10-K',
      );

      // act
      await tester.pumpWidget(host(sut));

      // assert
      expect(find.byType(AppBadge), findsOneWidget);
    });

    testWidgets('build_topicTooLongForRow_truncatesOnOneLineBeforeDate', (
      tester,
    ) async {
      // arrange
      const tTopic = 'Terminated Agreement';
      const tDate = 'Dec 31, 2026';
      tester.view.physicalSize = const Size(480, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final sut = FilingCardHeader(
        ticker: 'GOOGL',
        companyName: 'Alphabet Inc.',
        formType: tFormType,
        topic: tTopic,
        filingDate: DateTime(2026, 12, 31),
      );

      // act
      await tester.pumpWidget(host(sut));

      // assert
      final topicText = tester.widget<Text>(find.text(tTopic));
      final topicParagraph = tester.renderObject<RenderParagraph>(
        find.text(tTopic),
      );
      expect(tester.takeException(), isNull);
      expect(topicText.maxLines, 1);
      expect(topicText.overflow, TextOverflow.ellipsis);
      expect(topicParagraph.didExceedMaxLines, isTrue);
      expect(
        tester.getTopRight(find.byType(AppBadge).last).dx,
        lessThan(tester.getTopLeft(find.text(tDate)).dx),
      );
    });

    testWidgets('build_shortTopic_badgeHugsTextAndDateStaysRightAligned', (
      tester,
    ) async {
      // arrange
      const tDate = 'Dec 31, 2026';
      tester.view.physicalSize = const Size(800, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final sut = FilingCardHeader(
        ticker: 'AXP',
        companyName: 'American Express Company',
        formType: tFormType,
        topic: 'M&A',
        filingDate: DateTime(2026, 12, 31),
      );

      // act
      await tester.pumpWidget(host(sut));

      // assert
      final badgeWidth = tester.getSize(find.byType(AppBadge).last).width;
      final textWidth = tester.getSize(find.text('M&A')).width;
      expect(badgeWidth, lessThan(textWidth + 21));
      expect(tester.getTopRight(find.text(tDate)).dx, 800 - 16);
    });
  });
}
