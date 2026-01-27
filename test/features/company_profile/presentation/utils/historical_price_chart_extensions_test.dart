import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/presentation/utils/historical_price_chart_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HistoricalPriceListX', () {
    const tTicker = 'AAPL';
    final tHistory = List.generate(
      200,
      (i) => HistoricalPriceEod(
        symbol: tTicker,
        date: DateTime(
          2023,
          1,
          1,
        ).add(Duration(days: i)).toIso8601String().split('T')[0],
        price: 100.0 + i,
        volume: 1000.0,
      ),
    );

    test('filterByTimeFrame_d5_returnsLast5Points', () {
      final filtered = tHistory.filterByTimeFrame(ChartTimeFrame.d5);
      expect(filtered.length, 5);
      expect(filtered.last.date, tHistory.last.date);
    });

    test('filterByTimeFrame_m1_filtersCorrectDateRange', () {
      final filtered = tHistory.filterByTimeFrame(ChartTimeFrame.m1);
      final lastDate = DateTime.parse(tHistory.last.date);
      for (final p in filtered) {
        final d = DateTime.parse(p.date);
        expect(d.isAfter(lastDate.subtract(const Duration(days: 30))), true);
      }
    });

    test('downsample_limitsPointsWhilePreservingLast', () {
      final sampled = tHistory.downsample(limit: 150);
      expect(sampled.length, lessThanOrEqualTo(151));
      expect(sampled.last, tHistory.last);
      expect(sampled.first, tHistory.first);
    });

    test('downsample_smallList_returnsCopy', () {
      final small = tHistory.sublist(0, 10);
      final sampled = small.downsample(limit: 150);
      expect(sampled.length, 10);
      expect(sampled, equals(small));
    });

    test('minPrice_and_maxPrice_calculateCorrectly', () {
      final prices = [
        const HistoricalPriceEod(
          symbol: 'A',
          date: '2023-01-01',
          price: 100,
          volume: 0,
        ),
        const HistoricalPriceEod(
          symbol: 'A',
          date: '2023-01-02',
          price: 200,
          volume: 0,
        ),
      ];
      expect(prices.minPrice, 99.0);
      expect(prices.maxPrice, 202.0);
    });

    test('handlesEmptyList', () {
      final List<HistoricalPriceEod> empty = [];
      expect(empty.filterByTimeFrame(ChartTimeFrame.d5), []);
      expect(empty.downsample(), []);
      expect(empty.minPrice, 0);
      expect(empty.maxPrice, 0);
    });
  });
}
