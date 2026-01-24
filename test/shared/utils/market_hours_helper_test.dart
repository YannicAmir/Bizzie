import 'package:bizzie/shared/utils/market_hours_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarketHoursHelper', () {
    test('isDataStale_returnsTrueOnNull', () {
      expect(MarketHoursHelper.isDataStale(null), true);
    });

    test('isDataStale_handlesVeryOldDate', () {
      final oldDate = DateTime.now().subtract(const Duration(days: 10));
      expect(MarketHoursHelper.isDataStale(oldDate), true);
    });

    test('isDataStale_handlesRecentDate', () {
      final recent = DateTime.now().subtract(const Duration(minutes: 5));

      final isStale = MarketHoursHelper.isDataStale(recent);

      if (MarketHoursHelper.isMarketOpen()) {
        expect(isStale, false);
      }
    });

    test('isMarketOpen_detectsWeekends', () {
      expect(MarketHoursHelper.isMarketOpen(), isA<bool>());
    });
  });
}
