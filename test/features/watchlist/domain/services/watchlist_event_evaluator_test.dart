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
      // arrange
      final earnings = WatchlistEarningsDto(
        symbol: 'AAPL',
        date: tDate,
        expireAt: DateTime.now().add(const Duration(days: 1)),
      );

      // act
      final result = evaluator.evaluate(earnings: earnings, filing: null);

      // assert
      expect(result, isNotNull);
      expect(result!.badgeText, 'Earnings');
      expect(result.badgeType, WatchlistBadgeType.neutral);
      expect(result.eventDate, tDate);
    });

    test('should return null when earnings are expired and no filing', () {
      // arrange
      final earnings = WatchlistEarningsDto(
        symbol: 'AAPL',
        date: tDate,
        expireAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      // act
      final result = evaluator.evaluate(earnings: earnings, filing: null);

      // assert
      expect(result, isNull);
    });

    test('should return Filing event when earnings are missing/expired', () {
      // arrange
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '10-Q',
        isEarnings: false,
      );

      // act
      final result = evaluator.evaluate(earnings: null, filing: filing);

      // assert
      expect(result, isNotNull);
      expect(result!.badgeText, '10-Q');
      expect(result.badgeType, WatchlistBadgeType.warning);
      expect(result.eventDate, tDate);
    });

    test('should prioritize valid earnings over filing', () {
      // arrange
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

      // act
      final result = evaluator.evaluate(earnings: earnings, filing: filing);

      // assert
      expect(result, isNotNull);
      expect(result!.badgeText, 'Earnings');
    });

    test('should prioritise 8-K topic if available', () {
      // arrange
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '8-K',
        topic: 'Merger',
        isEarnings: false,
      );

      // act
      final result = evaluator.evaluate(earnings: null, filing: filing);

      // assert
      expect(result!.badgeText, 'Merger');
    });

    test('should default 8-K text if topic is empty', () {
      // arrange
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '8-K',
        topic: '',
        isEarnings: false,
      );

      // act
      final result = evaluator.evaluate(earnings: null, filing: filing);

      // assert
      expect(result!.badgeText, '8-K');
    });

    test('should return null when both inputs are null', () {
      // act
      final result = evaluator.evaluate(earnings: null, filing: null);

      // assert
      expect(result, isNull);
    });

    test('should handle unconventional 8-K casing if necessary', () {
      // arrange
      final filing = WatchlistFilingDto(
        symbol: 'AAPL',
        filingDate: tDate,
        formType: '8-k',
        topic: 'Merger',
        isEarnings: false,
      );

      // act
      final result = evaluator.evaluate(earnings: null, filing: filing);

      // assert
      expect(result!.badgeText, '8-K');
    });
  });
}
