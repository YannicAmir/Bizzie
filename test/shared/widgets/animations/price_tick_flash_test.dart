import 'package:bizzie/shared/models/price_tick.dart';
import 'package:bizzie/shared/widgets/animations/price_tick_flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const tUpColor = Color(0xFF006644);
const tDownColor = Color(0xFFE7000B);
const tBaseColor = Color(0xFF0F172B);
const tStyle = TextStyle(color: tBaseColor);
const tFlashDuration = Duration(milliseconds: 1200);

void main() {
  late PriceTick lastTick;

  Widget host(double price, String text, {bool disableAnimations = false}) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: disableAnimations),
        child: Scaffold(
          body: PriceTickFlash(
            price: price,
            text: text,
            builder: (context, tick) {
              lastTick = tick;
              return PriceTickText(tick: tick, style: tStyle);
            },
          ),
        ),
      ),
    );
  }

  TextSpan changedSpan(WidgetTester tester) {
    final richText = tester.widget<RichText>(
      find.descendant(
        of: find.byType(PriceTickText),
        matching: find.byType(RichText),
      ),
    );
    final priceSpan = (richText.text as TextSpan).children!.single as TextSpan;
    return priceSpan.children!.single as TextSpan;
  }

  group('PriceTickFlash', () {
    testWidgets('build_initialPrice_doesNotFlash', (tester) async {
      // arrange
      // act
      await tester.pumpWidget(host(38.23, r'$38.23'));

      // assert
      expect(lastTick.isFlashing, isFalse);
      expect(lastTick.unchangedText, r'$38.23');
      expect(lastTick.changedText, isEmpty);
    });

    testWidgets('update_priceRises_flashesChangedDigitsWithUpColor', (
      tester,
    ) async {
      // arrange
      await tester.pumpWidget(host(38.23, r'$38.23'));

      // act
      await tester.pumpWidget(host(38.32, r'$38.32'));

      // assert
      expect(lastTick.isFlashing, isTrue);
      expect(lastTick.flashColor, tUpColor);
      expect(lastTick.intensity, 1);
      expect(lastTick.unchangedText, r'$38.');
      expect(lastTick.changedText, '32');
      expect(changedSpan(tester).style?.color, tUpColor);
    });

    testWidgets('update_priceFalls_flashesChangedDigitsWithDownColor', (
      tester,
    ) async {
      // arrange
      await tester.pumpWidget(host(38.32, r'$38.32'));

      // act
      await tester.pumpWidget(host(38.23, r'$38.23'));

      // assert
      expect(lastTick.flashColor, tDownColor);
      expect(lastTick.changedText, '23');
      expect(changedSpan(tester).style?.color, tDownColor);
    });

    testWidgets('update_afterFlashDuration_settlesToBaseColor', (tester) async {
      // arrange
      await tester.pumpWidget(host(38.23, r'$38.23'));
      await tester.pumpWidget(host(38.32, r'$38.32'));

      // act
      await tester.pump(tFlashDuration);

      // assert
      expect(lastTick.isFlashing, isFalse);
      expect(lastTick.intensity, 0);
      expect(changedSpan(tester).style?.color, tBaseColor);
    });

    testWidgets('update_reduceMotionEnabled_doesNotFlash', (tester) async {
      // arrange
      await tester.pumpWidget(host(38.23, r'$38.23', disableAnimations: true));

      // act
      await tester.pumpWidget(host(38.32, r'$38.32', disableAnimations: true));

      // assert
      expect(lastTick.isFlashing, isFalse);
      expect(changedSpan(tester).style?.color, tBaseColor);
    });

    testWidgets('update_priceChangesButTextUnchanged_doesNotFlash', (
      tester,
    ) async {
      // arrange
      await tester.pumpWidget(host(38.231, r'$38.23'));

      // act
      await tester.pumpWidget(host(38.234, r'$38.23'));

      // assert
      expect(lastTick.isFlashing, isFalse);
      expect(lastTick.changedText, isEmpty);
    });
  });
}
