import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/extensions/pfcf_ratio_presentation_helper.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PfcfRatioPresentationHelper -', () {
    late List<FinancialDataPoint> mockDataPoints;
    final testDate = DateTime.utc(2023, 10, 24);

    setUp(() {
      mockDataPoints = [
        const FinancialDataPoint(
          date: '2019-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 18.0,
        ),
        const FinancialDataPoint(
          date: '2020-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 18.0,
        ),
        const FinancialDataPoint(
          date: '2021-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 18.0,
        ),
        const FinancialDataPoint(
          date: '2022-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 18.0,
        ),
        const FinancialDataPoint(
          date: '2023-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 18.0,
        ),
      ];
    });

    test('formatSummary_positiveGrowth_returnsCorrectFormatting', () {
      // Arrange
      const currentValue = 20.5;
      const growthPercentage = 4.0;
      const absoluteDelta = 0.8;
      const isPositive = true;
      const referenceLabel = 'AAPL';

      // Act
      final result = PfcfRatioPresentationHelper.formatSummary(
        dataPoints: mockDataPoints,
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
        lastUpdated: testDate,
      );

      // Assert
      expect(result.valueStr, '20.50');
      expect(result.badgeText, '+4.0%');
      expect(result.badgeStyle, AppBadgeStyle.neutral);
      expect(
        result.subtitle,
        contains('Oct. 24, 2023'),
      ); // Replaced 10/24 with full month-year logic from BizzieDateFormatter
      expect(
        result.subtitle,
        contains('Increased'),
      ); // Replacing up arrow with Increased string from MetricSummarySubtitleHelper
      expect(result.subtitle, contains('0.80'));
      expect(result.subtitle, contains('AAPL'));
      expect(result.dynamicAvg?.label, '5Y Avg. P/FCF Ratio');
      expect(result.dynamicAvg?.value, '18.00');
    });

    test('formatSummary_negativeGrowth_returnsCorrectFormatting', () {
      // Arrange
      const currentValue = 18.2;
      const growthPercentage = -2.1;
      const absoluteDelta = -0.5;
      const isPositive = false;
      const referenceLabel = 'MSFT';

      // Act
      final result = PfcfRatioPresentationHelper.formatSummary(
        dataPoints: mockDataPoints,
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
      );

      // Assert
      expect(result.valueStr, '18.20');
      expect(result.badgeText, '-2.1%');
      expect(result.badgeStyle, AppBadgeStyle.neutral);
      expect(result.subtitle, contains('As of'));
      expect(
        result.subtitle,
        contains('Decreased'),
      ); // Replaced down arrow with Decreased
      expect(result.subtitle, contains('-0.50'));
      expect(result.subtitle, contains('MSFT'));
    });

    test('formatSummary_zeroGrowth_returnsCorrectFormatting', () {
      // Arrange
      const currentValue = 15.0;
      const growthPercentage = 0.0;
      const absoluteDelta = 0.0;
      const isPositive = false;
      const referenceLabel = 'GOOG';

      // Act
      final result = PfcfRatioPresentationHelper.formatSummary(
        dataPoints: mockDataPoints,
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
      );

      // Assert
      expect(result.badgeText, '0.0%');
      expect(result.subtitle, contains('No change'));
    });

    test('formatSummary_emptyData_handlesGracefully', () {
      // Act
      final result = PfcfRatioPresentationHelper.formatSummary(
        dataPoints: const [],
        currentValue: 10.0,
        growthPercentage: 0.0,
        absoluteDelta: 0.0,
        isPositive: true,
        referenceLabel: 'TEST',
      );

      // Assert
      expect(result.dynamicAvg, isNull);
    });
  });
}
