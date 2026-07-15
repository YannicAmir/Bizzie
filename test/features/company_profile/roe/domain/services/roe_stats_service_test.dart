import 'package:bizzie/features/company_profile/roe/domain/models/roe.dart';
import 'package:bizzie/features/company_profile/roe/domain/services/roe_stats_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RoeStatsService service;

  setUp(() {
    service = RoeStatsService();
  });

  const tTicker = 'AAPL';

  Roe roe(String date, double value) =>
      Roe(symbol: tTicker, date: date, period: 'FY', returnOnEquity: value);

  group('RoeStatsService', () {
    test('compute_validMetrics_computesGrowthAgainstReferencePoint', () {
      // arrange
      final metrics = [roe('2018-10-01', 0.35), roe('2023-09-30', 0.45)];

      // act
      final stats = service.compute(metrics);

      // assert
      expect(stats.dataPoints.length, 2);
      expect(stats.currentValue, 0.45);
      expect(stats.growthPercentage, ((0.45 - 0.35) / 0.35) * 100);
      expect(stats.absoluteDelta, closeTo(0.1, 1e-9));
      expect(stats.isPositive, true);
      expect(stats.referenceDate, '2018-10-01');
    });

    test('compute_unsortedMetrics_sortsByDateAscending', () {
      // arrange
      final metrics = [roe('2023-09-30', 0.45), roe('2018-10-01', 0.35)];

      // act
      final stats = service.compute(metrics);

      // assert
      expect(stats.dataPoints.first.date, '2018-10-01');
      expect(stats.dataPoints.last.date, '2023-09-30');
      expect(stats.currentValue, 0.45);
    });

    test('compute_pointsOlderThanLookback_usesFirstPointWithinWindow', () {
      // arrange
      final metrics = [
        roe('2010-09-30', 0.10),
        roe('2021-09-30', 0.20),
        roe('2024-09-30', 0.30),
      ];

      // act
      final stats = service.compute(metrics);

      // assert
      expect(stats.referenceDate, '2021-09-30');
      expect(stats.growthPercentage, closeTo(((0.30 - 0.20) / 0.20) * 100, 1e-9));
    });

    test('compute_negativeDelta_setsIsPositiveFalse', () {
      // arrange
      final metrics = [roe('2022-09-30', 0.45), roe('2024-09-30', 0.30)];

      // act
      final stats = service.compute(metrics);

      // assert
      expect(stats.isPositive, false);
      expect(stats.absoluteDelta, closeTo(0.15, 1e-9));
    });

    test('compute_nearZeroReferenceValue_returnsZeroGrowth', () {
      // arrange
      final metrics = [roe('2022-09-30', 0.0), roe('2024-09-30', 0.30)];

      // act
      final stats = service.compute(metrics);

      // assert
      expect(stats.growthPercentage, 0.0);
      expect(stats.currentValue, 0.30);
    });

    test('compute_emptyMetrics_returnsEmptyStats', () {
      // act
      final stats = service.compute(const []);

      // assert
      expect(stats.dataPoints, isEmpty);
      expect(stats.currentValue, 0);
      expect(stats.growthPercentage, 0);
      expect(stats.absoluteDelta, 0);
      expect(stats.isPositive, false);
      expect(stats.referenceDate, '');
    });
  });
}
