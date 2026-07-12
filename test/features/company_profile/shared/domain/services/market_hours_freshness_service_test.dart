import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/market_hours_freshness_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTimeProvider extends Mock implements ITimeProvider {}

// July 2026: Wed 8th, Thu 9th, Fri 10th, Sat 11th, Sun 12th, Mon 13th.
final tOpenWednesday = DateTime(2026, 7, 8, 10, 0);
final tWednesdayEvening = DateTime(2026, 7, 8, 18, 0);
final tSaturdayAfternoon = DateTime(2026, 7, 11, 16, 28);
final tSundayMidday = DateTime(2026, 7, 12, 12, 0);
final tMondayPreOpen = DateTime(2026, 7, 13, 8, 0);
final tMondayEvening = DateTime(2026, 7, 13, 18, 0);

// June 2026: Mon 1st follows Fri May 29th across the month boundary.
final tMonthBoundaryMondayPreOpen = DateTime(2026, 6, 1, 8, 0);

void main() {
  late MarketHoursFreshnessService service;
  late MockTimeProvider mockTimeProvider;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    mockTimeProvider = MockTimeProvider();
    service = MarketHoursFreshnessService(mockTimeProvider);

    when(() => mockTimeProvider.toEt(any())).thenAnswer(
      (invocation) => invocation.positionalArguments.first as DateTime,
    );
  });

  void stubNow(DateTime nowEt, {required bool marketOpen}) {
    when(() => mockTimeProvider.nowEt).thenReturn(nowEt);
    when(() => mockTimeProvider.isMarketOpen(nowEt)).thenReturn(marketOpen);
  }

  group('MarketHoursFreshnessService', () {
    group('isStale - null', () {
      test('isStale_nullLastUpdated_returnsTrue', () {
        // arrange
        stubNow(tOpenWednesday, marketOpen: true);

        // act
        final result = service.isStale(null);

        // assert
        expect(result, true);
      });
    });

    group('isStale - market open', () {
      test('isStale_marketOpen_withinTtl_returnsFalse', () {
        // arrange
        stubNow(tOpenWednesday, marketOpen: true);
        final lastUpdated = tOpenWednesday.subtract(
          const Duration(minutes: 14),
        );

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_marketOpen_ttlReached_returnsTrue', () {
        // arrange
        stubNow(tOpenWednesday, marketOpen: true);
        final lastUpdated = tOpenWednesday.subtract(
          const Duration(minutes: 15),
        );

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, true);
      });
    });

    group('isStale - market closed', () {
      test('isStale_saturday_dataRefreshedSameSaturday_returnsFalse', () {
        // arrange — regression: weekend refresh must stay fresh all weekend
        stubNow(tSaturdayAfternoon, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 11, 16, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_saturday_dataFromFridaySession_returnsFalse', () {
        // arrange
        stubNow(tSaturdayAfternoon, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 10, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_saturday_dataFromThursday_returnsTrue', () {
        // arrange
        stubNow(tSaturdayAfternoon, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 9, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, true);
      });

      test('isStale_mondayPreOpen_dataFromFridaySession_returnsFalse', () {
        // arrange — before Monday's open, Friday is still the active session
        stubNow(tMondayPreOpen, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 10, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_mondayAfterClose_dataFromFridaySession_returnsTrue', () {
        // arrange — Monday's session has completed; Friday data is outdated
        stubNow(tMondayEvening, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 10, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, true);
      });

      test('isStale_weekdayPreOpen_dataFromPreviousSession_returnsFalse', () {
        // arrange — Thu 07:00: Wednesday is still the last completed session
        stubNow(DateTime(2026, 7, 9, 7, 0), marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 8, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_weekdayAfterClose_dataFromSameDaySession_returnsFalse', () {
        // arrange — Wed 18:00: data from that day's session is still current
        stubNow(tWednesdayEvening, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 8, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_sunday_dataFromFridaySession_returnsFalse', () {
        // arrange — Sunday rolls back through Saturday to Friday's session
        stubNow(tSundayMidday, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 10, 15, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_saturday_dataFromFridayPreOpen_returnsTrue', () {
        // arrange — Fri 09:29 precedes the open, so it belongs to Thursday
        stubNow(tSaturdayAfternoon, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 10, 9, 29);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, true);
      });

      test('isStale_saturday_dataFromFridayAtOpen_returnsFalse', () {
        // arrange — Fri 09:30 exactly belongs to Friday's session
        stubNow(tSaturdayAfternoon, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 10, 9, 30);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test('isStale_mondayPreOpen_dataFromSaturday_returnsFalse', () {
        // arrange — Saturday-stamped data maps to Friday, same as Monday pre-open
        stubNow(tMondayPreOpen, marketOpen: false);
        final lastUpdated = DateTime(2026, 7, 11, 10, 0);

        // act
        final result = service.isStale(lastUpdated);

        // assert
        expect(result, false);
      });

      test(
        'isStale_mondayPreOpenAtMonthBoundary_dataFromPreviousFridaySession_returnsFalse',
        () {
          // arrange — Mon Jun 1 pre-open rolls back across the month boundary
          stubNow(tMonthBoundaryMondayPreOpen, marketOpen: false);
          final lastUpdated = DateTime(2026, 5, 29, 15, 0);

          // act
          final result = service.isStale(lastUpdated);

          // assert
          expect(result, false);
        },
      );
    });
  });
}
