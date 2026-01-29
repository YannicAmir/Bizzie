import 'package:bizzie/features/company_profile/shares/presentation/extensions/shares_presentation_helper.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('SharesPresentationHelper', () {
    final numberFormat = NumberFormat("#,##0.00");

    test('formatSummary_positiveGrowth_returnsCriticalBadge', () {
      // arrange
      const summary = SharesSummaryData(
        currentValue: 1000.0,
        growthPercentage: 5.0,
        absoluteDelta: 50.0,
        isPositive: true,
        referenceLabel: 'last year',
      );

      // act
      final result = SharesPresentationHelper.formatSummary(
        summary,
        numberFormat,
      );

      // assert
      expect(result.valueStr, '1,000.00');
      expect(result.badgeText, '+5.0%');
      expect(result.badgeStyle, AppBadgeStyle.critical);
      expect(result.subtitle, 'Increased by 50.00 since last year');
    });

    test('formatSummary_negativeGrowth_returnsGoodBadge', () {
      // arrange
      const summary = SharesSummaryData(
        currentValue: 900.0,
        growthPercentage: -10.0,
        absoluteDelta: 100.0,
        isPositive: false,
        referenceLabel: 'last year',
      );

      // act
      final result = SharesPresentationHelper.formatSummary(
        summary,
        numberFormat,
      );

      // assert
      expect(result.valueStr, '900.00');
      expect(result.badgeText, '-10.0%');
      expect(result.badgeStyle, AppBadgeStyle.good); // Negative growth = Good
      expect(result.subtitle, 'Decreased by 100.00 since last year');
    });

    test('formatSummary_zeroChange_returnsNoChangeSubtitle', () {
      // arrange
      const summary = SharesSummaryData(
        currentValue: 1000.0,
        growthPercentage: 0.0,
        absoluteDelta: 0.0,
        isPositive: false,
        referenceLabel: 'last year',
      );

      // act
      final result = SharesPresentationHelper.formatSummary(
        summary,
        numberFormat,
      );

      // assert
      expect(result.subtitle, 'No change since last year');
    });
  });
}
