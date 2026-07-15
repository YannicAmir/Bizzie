import 'package:bizzie/features/company_profile/pfcf_ratio/domain/models/pfcf_ratio.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/domain/services/pfcf_ratio_stats_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PfcfRatioStatsService service;

  setUp(() {
    service = PfcfRatioStatsService();
  });

  const tTicker = 'AAPL';

  PfcfRatio ratio(String date, double value) => PfcfRatio(
    symbol: tTicker,
    date: date,
    period: 'FY',
    priceToFreeCashFlowRatio: value,
  );

  group('PfcfRatioStatsService', () {
    test('compute_validRatios_computesGrowthAgainstReferencePoint', () {
      // arrange
      final ratios = [ratio('2018-10-01', 15.0), ratio('2023-09-30', 25.0)];

      // act
      final stats = service.compute(ratios);

      // assert
      expect(stats.dataPoints.length, 2);
      expect(stats.currentValue, 25.0);
      expect(stats.growthPercentage, ((25.0 - 15.0) / 15.0) * 100);
      expect(stats.absoluteDelta, 10.0);
      expect(stats.isPositive, true);
      expect(stats.referenceDate, '2018-10-01');
    });

    test('compute_zeroValues_filtersInvalidPoints', () {
      // arrange
      final ratios = [
        ratio('2018-10-01', 15.0),
        ratio('2023-09-30', 25.0),
        ratio('2024-01-01', 0.0),
      ];

      // act
      final stats = service.compute(ratios);

      // assert
      expect(stats.dataPoints.length, 2);
      expect(stats.currentValue, 25.0);
    });

    test('compute_unsortedRatios_sortsByDateAscending', () {
      // arrange
      final ratios = [ratio('2023-09-30', 25.0), ratio('2018-10-01', 15.0)];

      // act
      final stats = service.compute(ratios);

      // assert
      expect(stats.dataPoints.first.date, '2018-10-01');
      expect(stats.dataPoints.last.date, '2023-09-30');
      expect(stats.currentValue, 25.0);
    });

    test('compute_pointsOlderThanLookback_usesFirstPointWithinWindow', () {
      // arrange
      final ratios = [
        ratio('2010-09-30', 5.0),
        ratio('2021-09-30', 20.0),
        ratio('2024-09-30', 30.0),
      ];

      // act
      final stats = service.compute(ratios);

      // assert
      expect(stats.referenceDate, '2021-09-30');
      expect(stats.growthPercentage, ((30.0 - 20.0) / 20.0) * 100);
    });

    test('compute_negativeDelta_setsIsPositiveFalse', () {
      // arrange
      final ratios = [ratio('2022-09-30', 30.0), ratio('2024-09-30', 20.0)];

      // act
      final stats = service.compute(ratios);

      // assert
      expect(stats.isPositive, false);
      expect(stats.absoluteDelta, 10.0);
    });

    test('compute_emptyRatios_returnsEmptyStats', () {
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

    test('compute_allZeroValues_returnsEmptyStats', () {
      // arrange
      final ratios = [ratio('2018-10-01', 0.0), ratio('2023-09-30', 0.0)];

      // act
      final stats = service.compute(ratios);

      // assert
      expect(stats.dataPoints, isEmpty);
    });
  });
}
