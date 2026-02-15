import 'package:bizzie/features/watchlist/data/dtos/watchlist_api_dtos.dart';
import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/services/watchlist_event_evaluator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late WatchlistEventEvaluator evaluator;

  setUp(() {
    evaluator = WatchlistEventEvaluator();
  });

  group('WatchlistEventEvaluator', () {
    final tDate = DateTime(2023, 1, 1);

    test('should return Earnings event when valid earnings are present', () {
      final earnings = WatchlistEarningsDto(
        symbol: 'AAPL',
        date: tDate,
        expireAt: DateTime.now().add(const Duration(days: 1)),
      );

      final result = evaluator.evaluate(earnings: earnings, filing: null);

      expect(result, isNotNull);
      expect(result!.badgeText, 'Earnings');
      expect(result.badgeType, WatchlistBadgeType.neutral);
      expect(result.eventDate, tDate);
    });

    test('should return null when earnings are expired and no filing', () {
      final earnings = WatchlistEarningsDto(
        symbol: 'AAPL',
        date: tDate,
        expireAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      final result = evaluator.evaluate(earnings: earnings, filing: null);

      expect(result, isNull);
    });

    test('should return Filing event when earnings are missing/expired', () {
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '10-Q',
        isEarnings: false,
      );

      final result = evaluator.evaluate(earnings: null, filing: filing);

      expect(result, isNotNull);
      expect(result!.badgeText, '10-Q');
      expect(result.badgeType, WatchlistBadgeType.warning);
      expect(result.eventDate, tDate);
    });

    test('should prioritize valid earnings over filing', () {
      final earnings = WatchlistEarningsDto(
        symbol: 'AAPL',
        date: tDate,
        expireAt: DateTime.now().add(const Duration(days: 1)),
      );
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '10-Q',
        isEarnings: false,
      );

      final result = evaluator.evaluate(earnings: earnings, filing: filing);

      expect(result, isNotNull);
      expect(result!.badgeText, 'Earnings');
    });

    test('should prioritise 8-K topic if available', () {
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '8-K',
        topic: 'Merger',
        isEarnings: false,
      );

      final result = evaluator.evaluate(earnings: null, filing: filing);

      expect(result!.badgeText, 'Merger');
    });

    test('should default 8-K text if topic is empty', () {
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '8-K',
        topic: '',
        isEarnings: false,
      );

      final result = evaluator.evaluate(earnings: null, filing: filing);

      expect(result!.badgeText, '8-K');
    });
  });
}
