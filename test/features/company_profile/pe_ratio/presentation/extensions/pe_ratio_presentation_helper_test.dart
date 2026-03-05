import 'package:bizzie/features/company_profile/pe_ratio/presentation/extensions/pe_ratio_presentation_helper.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PeRatioPresentationHelper -', () {
    late List<FinancialDataPoint> mockDataPoints;
    final testDate = DateTime.utc(2023, 10, 24);

    setUp(() {
      mockDataPoints = [
        const FinancialDataPoint(
          date: '2019-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 10.0,
        ),
        const FinancialDataPoint(
          date: '2020-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 10.0,
        ),
        const FinancialDataPoint(
          date: '2021-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 10.0,
        ),
        const FinancialDataPoint(
          date: '2022-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 10.0,
        ),
        const FinancialDataPoint(
          date: '2023-10-24T00:00:00.000Z',
          period: 'Q3',
          value: 10.0,
        ),
      ];
    });

    test('formatSummary_positiveGrowth_returnsCorrectFormatting', () {
      // Arrange
      const currentValue = 15.5;
      const growthPercentage = 5.2;
      const absoluteDelta = 0.5;
      const isPositive = true;
      const referenceLabel = 'AAPL';

      // Act
      final result = PeRatioPresentationHelper.formatSummary(
        dataPoints: mockDataPoints,
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
        lastUpdated: testDate,
      );

      // Assert
      expect(result.valueStr, '15.50');
      expect(result.badgeText, '+5.2%');
      expect(result.badgeStyle, AppBadgeStyle.neutral);
      expect(
        result.subtitle,
        contains('Oct. 24, 2023'),
      ); // Replaced 10/24 with full month-year logic from BizzieDateFormatter
      expect(
        result.subtitle,
        contains('Increased'),
      ); // Replacing up arrow with Increased string from MetricSummarySubtitleHelper
      expect(result.subtitle, contains('0.50'));
      expect(result.subtitle, contains('AAPL'));
      expect(result.dynamicAvg?.label, '5Y Avg. P/E Ratio');
      expect(result.dynamicAvg?.value, '10.00');
    });

    test('formatSummary_negativeGrowth_returnsCorrectFormatting', () {
      // Arrange
      const currentValue = 12.0;
      const growthPercentage = -3.5;
      const absoluteDelta = -1.2;
      const isPositive = false;
      const referenceLabel = 'MSFT';

      // Act
      final result = PeRatioPresentationHelper.formatSummary(
        dataPoints: mockDataPoints,
        currentValue: currentValue,
        growthPercentage: growthPercentage,
        absoluteDelta: absoluteDelta,
        isPositive: isPositive,
        referenceLabel: referenceLabel,
      );

      // Assert
      expect(result.valueStr, '12.00');
      expect(result.badgeText, '-3.5%');
      expect(result.badgeStyle, AppBadgeStyle.neutral);
      expect(result.subtitle, contains('As of'));
      expect(
        result.subtitle,
        contains('Decreased'),
      ); // Replaced down arrow with Decreased
      expect(result.subtitle, contains('-1.20'));
      expect(result.subtitle, contains('MSFT'));
    });

    test('formatSummary_zeroGrowth_returnsCorrectFormatting', () {
      // Arrange
      const currentValue = 10.0;
      const growthPercentage = 0.0;
      const absoluteDelta = 0.0;
      const isPositive = false;
      const referenceLabel = 'GOOG';

      // Act
      final result = PeRatioPresentationHelper.formatSummary(
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
      final result = PeRatioPresentationHelper.formatSummary(
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
