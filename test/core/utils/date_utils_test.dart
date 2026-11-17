import 'package:bizzie/core/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BizzieDateUtils', () {
    group('compareNewestFirst', () {
      final tEarlier = DateTime(2026, 5, 27, 9);
      final tLater = DateTime(2026, 5, 27, 18);

      test('compareNewestFirst_firstIsLater_returnsNegative', () {
        // act
        final result = BizzieDateUtils.compareNewestFirst(tLater, tEarlier);

        // assert
        expect(result, isNegative);
      });

      test('compareNewestFirst_firstIsEarlier_returnsPositive', () {
        // act
        final result = BizzieDateUtils.compareNewestFirst(tEarlier, tLater);

        // assert
        expect(result, isPositive);
      });

      test('compareNewestFirst_equalDates_returnsZero', () {
        // act
        final result = BizzieDateUtils.compareNewestFirst(tLater, tLater);

        // assert
        expect(result, 0);
      });

      test('compareNewestFirst_firstIsNull_sortsFirstLast', () {
        // act
        final result = BizzieDateUtils.compareNewestFirst(null, tEarlier);

        // assert
        expect(result, isPositive);
      });

      test('compareNewestFirst_secondIsNull_sortsSecondLast', () {
        // act
        final result = BizzieDateUtils.compareNewestFirst(tEarlier, null);

        // assert
        expect(result, isNegative);
      });

      test('compareNewestFirst_bothNull_returnsZero', () {
        // act
        final result = BizzieDateUtils.compareNewestFirst(null, null);

        // assert
        expect(result, 0);
      });

      test(
        'compareNewestFirst_sortingMixedList_ordersNewestFirstNullsLast',
        () {
          // arrange
          final dates = [tEarlier, null, tLater];

          // act
          dates.sort(BizzieDateUtils.compareNewestFirst);

          // assert
          expect(dates, [tLater, tEarlier, null]);
        },
      );
    });

    group('isSameDay', () {
      final tMorning = DateTime(2026, 5, 27, 0, 0, 1);
      final tNight = DateTime(2026, 5, 27, 23, 59, 59);

      test('isSameDay_differentTimesSameDate_returnsTrue', () {
        // act
        final result = BizzieDateUtils.isSameDay(tMorning, tNight);

        // assert
        expect(result, isTrue);
      });

      test('isSameDay_adjacentDays_returnsFalse', () {
        // act
        final result = BizzieDateUtils.isSameDay(
          tNight,
          DateTime(2026, 5, 28, 0, 0, 1),
        );

        // assert
        expect(result, isFalse);
      });

      test('isSameDay_sameDayDifferentMonth_returnsFalse', () {
        // act
        final result = BizzieDateUtils.isSameDay(
          tMorning,
          DateTime(2026, 6, 27),
        );

        // assert
        expect(result, isFalse);
      });

      test('isSameDay_sameDayDifferentYear_returnsFalse', () {
        // act
        final result = BizzieDateUtils.isSameDay(
          tMorning,
          DateTime(2025, 5, 27),
        );

        // assert
        expect(result, isFalse);
      });
    });
  });
}
