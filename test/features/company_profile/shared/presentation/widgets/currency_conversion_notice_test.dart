import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_conversion_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildSut({required String? original, required String displayed}) {
    return MaterialApp(
      home: Scaffold(
        body: CurrencyConversionNotice(
          originalCurrency: original,
          displayedCurrency: displayed,
        ),
      ),
    );
  }

  group('CurrencyConversionNotice', () {
    testWidgets('build_currenciesDiffer_showsDisclaimer', (tester) async {
      // arrange
      final sut = buildSut(original: 'TWD', displayed: 'USD');

      // act
      await tester.pumpWidget(sut);

      // assert
      expect(
        find.text('Original currency TWD, converted to USD'),
        findsOneWidget,
      );
    });

    testWidgets('build_currenciesDiffer_addsSubSectionSpacingAroundText', (
      tester,
    ) async {
      // arrange
      final sut = buildSut(original: 'TWD', displayed: 'USD');

      // act
      await tester.pumpWidget(sut);

      // assert
      final notice = tester.getRect(find.byType(CurrencyConversionNotice));
      final text = tester.getRect(find.byType(Text));
      expect(text.top - notice.top, 8);
      expect(notice.bottom - text.bottom, 8);
    });

    testWidgets('build_currenciesMatch_keepsMainSectionSpacing', (
      tester,
    ) async {
      // arrange
      final sut = buildSut(original: 'USD', displayed: 'USD');

      // act
      await tester.pumpWidget(sut);

      // assert
      final notice = tester.getRect(find.byType(CurrencyConversionNotice));
      expect(notice.height, 24);
    });

    testWidgets('build_currenciesMatch_showsNothing', (tester) async {
      // arrange
      final sut = buildSut(original: 'USD', displayed: 'USD');

      // act
      await tester.pumpWidget(sut);

      // assert
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('build_originalCurrencyNull_showsNothing', (tester) async {
      // arrange
      final sut = buildSut(original: null, displayed: 'USD');

      // act
      await tester.pumpWidget(sut);

      // assert
      expect(find.byType(Text), findsNothing);
    });
  });
}
