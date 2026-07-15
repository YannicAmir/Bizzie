import 'package:bizzie/core/services/time_provider_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  late TimeProviderImpl timeProvider;
  late tz.Location eastern;

  setUpAll(() {
    tzdata.initializeTimeZones();
    eastern = tz.getLocation('America/New_York');
  });

  setUp(() {
    timeProvider = TimeProviderImpl();
  });

  group('TimeProviderImpl', () {
    group('isMarketOpen', () {
      // July 2026: Mon 13th, Sat 11th, Sun 12th.
      test('isMarketOpen_weekdayBeforeOpen_returnsFalse', () {
        // arrange
        final beforeOpen = tz.TZDateTime(eastern, 2026, 7, 13, 9, 29);

        // act
        final result = timeProvider.isMarketOpen(beforeOpen);

        // assert
        expect(result, false);
      });

      test('isMarketOpen_weekdayAtOpen_returnsTrue', () {
        // arrange
        final atOpen = tz.TZDateTime(eastern, 2026, 7, 13, 9, 30);

        // act
        final result = timeProvider.isMarketOpen(atOpen);

        // assert
        expect(result, true);
      });

      test('isMarketOpen_weekdayLastMinuteOfSession_returnsTrue', () {
        // arrange
        final beforeClose = tz.TZDateTime(eastern, 2026, 7, 13, 15, 59);

        // act
        final result = timeProvider.isMarketOpen(beforeClose);

        // assert
        expect(result, true);
      });

      test('isMarketOpen_weekdayAtClose_returnsFalse', () {
        // arrange
        final atClose = tz.TZDateTime(eastern, 2026, 7, 13, 16, 0);

        // act
        final result = timeProvider.isMarketOpen(atClose);

        // assert
        expect(result, false);
      });

      test('isMarketOpen_saturday_returnsFalse', () {
        // arrange
        final saturdayMidday = tz.TZDateTime(eastern, 2026, 7, 11, 12, 0);

        // act
        final result = timeProvider.isMarketOpen(saturdayMidday);

        // assert
        expect(result, false);
      });

      test('isMarketOpen_sunday_returnsFalse', () {
        // arrange
        final sundayMidday = tz.TZDateTime(eastern, 2026, 7, 12, 12, 0);

        // act
        final result = timeProvider.isMarketOpen(sundayMidday);

        // assert
        expect(result, false);
      });

      test('isMarketOpen_utcDuringSession_normalisesToEtAndReturnsTrue', () {
        // arrange — 18:00 UTC on Mon 13 July 2026 is 14:00 EDT (in session);
        // reading the UTC hour without conversion would report closed.
        final utcDuringSession = DateTime.utc(2026, 7, 13, 18, 0);

        // act
        final result = timeProvider.isMarketOpen(utcDuringSession);

        // assert
        expect(result, true);
      });

      test('isMarketOpen_utcBeforeOpenEt_normalisesToEtAndReturnsFalse', () {
        // arrange — 13:00 UTC on Mon 13 July 2026 is 9:00 EDT (before open);
        // reading the UTC hour without conversion would report open.
        final utcBeforeOpen = DateTime.utc(2026, 7, 13, 13, 0);

        // act
        final result = timeProvider.isMarketOpen(utcBeforeOpen);

        // assert
        expect(result, false);
      });

      test('isMarketOpen_etValueAndUtcEquivalent_returnSameResult', () {
        // arrange — 14:00 EDT on Mon 13 July 2026 (in session) and its exact
        // UTC equivalent; callers like MarketHoursFreshnessService pass
        // already-ET values, so the internal re-conversion must not skew
        // the result.
        final etDuringSession = tz.TZDateTime(eastern, 2026, 7, 13, 14, 0);
        final utcEquivalent = DateTime.utc(2026, 7, 13, 18, 0);

        // act
        final etResult = timeProvider.isMarketOpen(etDuringSession);
        final utcResult = timeProvider.isMarketOpen(utcEquivalent);

        // assert
        expect(etResult, true);
        expect(etResult, utcResult);
      });
    });

    group('toEt', () {
      test('toEt_summerUtc_convertsToEasternDaylightTime', () {
        // arrange — July is EDT (UTC-4)
        final utc = DateTime.utc(2026, 7, 11, 20, 28);

        // act
        final result = timeProvider.toEt(utc);

        // assert
        expect(result.hour, 16);
        expect(result.minute, 28);
        expect(result.day, 11);
      });

      test('toEt_winterUtc_convertsToEasternStandardTime', () {
        // arrange — January is EST (UTC-5)
        final utc = DateTime.utc(2026, 1, 15, 20, 0);

        // act
        final result = timeProvider.toEt(utc);

        // assert
        expect(result.hour, 15);
        expect(result.day, 15);
      });

      test('toEt_alreadyEasternValue_isIdempotent', () {
        // arrange — an already-ET value, as produced by nowEt
        final alreadyEt = tz.TZDateTime(eastern, 2026, 7, 13, 14, 0);

        // act
        final result = timeProvider.toEt(alreadyEt);

        // assert — same absolute instant and same wall-clock time
        expect(result.microsecondsSinceEpoch, alreadyEt.microsecondsSinceEpoch);
        expect(result.year, alreadyEt.year);
        expect(result.month, alreadyEt.month);
        expect(result.day, alreadyEt.day);
        expect(result.hour, alreadyEt.hour);
        expect(result.minute, alreadyEt.minute);
      });
    });
  });
}
