import 'package:bizzie/features/company_profile/security/domain/extensions/historical_price_eod_extensions.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/shared/models/chart_data_point.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HistoricalPriceEodListExtensions - toChartDataPoints', () {
    final tPoint = HistoricalPriceEod(
      symbol: 'AAPL',
      date: '2023-01-01',
      price: 150.0,
      volume: 1000000,
    );
    final tList = [tPoint];

    test('toChartDataPoints_populatedList_returnsMappedDataPoints', () {
      // arrange
      // act
      final result = tList.toChartDataPoints();

      // assert
      expect(result, isA<List<ChartDataPoint>>());
      expect(result.length, 1);
      expect(result.first.label, '2023-01-01');
      expect(result.first.value, 150.0);
    });

    test('toChartDataPoints_emptyList_returnsEmptyList', () {
      // arrange
      final List<HistoricalPriceEod> emptyList = [];

      // act
      final result = emptyList.toChartDataPoints();

      // assert
      expect(result, isEmpty);
    });
  });
}
