import 'package:bizzie/features/company_profile/roe/presentation/extensions/roe_presentation_helper.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RoePresentationHelper', () {
    test('formatSummary_positiveGrowth_returnsCorrectFormat', () {
      // arrange
      const currentValue = 0.15123;
      const growthPercentage = 5.234;
      const absoluteDelta = 0.05234;
      const isPositive = true;
      const referenceLabel = 'last year';

      // act
      final result = RoePresentationHelper.formatSummary(
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
      );

      // assert
      expect(result.valueStr, '15.12%');
      expect(result.badgeText, '+5.2%');
      expect(result.badgeStyle, AppBadgeStyle.good);
      expect(result.subtitle, 'Increased by 5.23% since last year');
    });

    test('formatSummary_negativeGrowth_returnsCorrectFormat', () {
      // arrange
      const currentValue = 0.10;
      const growthPercentage = -2.1;
      const absoluteDelta = 0.021;
      const isPositive = false;
      const referenceLabel = 'last quarter';

      // act
      final result = RoePresentationHelper.formatSummary(
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
      );

      // assert
      expect(result.valueStr, '10.00%');
      expect(result.badgeText, '-2.1%');
      expect(result.badgeStyle, AppBadgeStyle.critical);
      expect(result.subtitle, 'Decreased by 2.10% since last quarter');
    });

    test('formatSummary_zeroChange_returnsNoChangeSubtitle', () {
      // arrange
      const currentValue = 0.10;
      const growthPercentage = 0.0;
      const absoluteDelta = 0.0;
      const isPositive = false;
      const referenceLabel = 'last year';

      // act
      final result = RoePresentationHelper.formatSummary(
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
      );

      // assert
      expect(result.subtitle, 'No change since last year');
    });

    test('chartFormatter_formatsPercentagesCorrectly', () {
      // arrange
      final formatter = RoePresentationHelper.chartFormatter;
      const value = 12.345;

      // act
      final result = formatter.format(value);

      // assert
      expect(result, '12.35%');
    });
  });
}
