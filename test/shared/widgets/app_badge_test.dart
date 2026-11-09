import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const tText = '+1.24%';

void main() {
  Widget host(AppBadge badge) => MaterialApp(
    theme: AppTheme.lightTheme,
    home: Scaffold(body: badge),
  );

  Color? backgroundOf(WidgetTester tester) {
    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(AppBadge),
        matching: find.byType(Container),
      ),
    );
    return (container.decoration as BoxDecoration?)?.color;
  }

  Color? textColorOf(WidgetTester tester) =>
      tester.widget<Text>(find.text(tText)).style?.color;

  group('AppBadge', () {
    testWidgets('build_goodSolid_showsWhiteTextOnSolidGood', (tester) async {
      // arrange
      const sut = AppBadge(text: tText, style: AppBadgeStyle.goodSolid);

      // act
      await tester.pumpWidget(host(sut));

      // assert
      expect(backgroundOf(tester), AppColors.goodText);
      expect(textColorOf(tester), AppColors.white);
    });

    testWidgets('build_criticalSolid_showsWhiteTextOnSolidCritical', (
      tester,
    ) async {
      // arrange
      const sut = AppBadge(text: tText, style: AppBadgeStyle.criticalSolid);

      // act
      await tester.pumpWidget(host(sut));

      // assert
      expect(backgroundOf(tester), AppColors.criticalText);
      expect(textColorOf(tester), AppColors.white);
    });
  });
}
