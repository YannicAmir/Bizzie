import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/extensions/watchlist_event_status_extensions.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistEventStatusAnalyticsExtensions', () {
    group('analyticsEventText', () {
      test(
        'watchlistEventStatus_analyticsEventTextWithShortText_returnsOriginalText',
        () {
          // arrange
          final status = WatchlistEventStatus(
            badgeText: 'Earnings',
            badgeType: WatchlistBadgeType.neutral,
            eventDate: DateTime.now(),
            lastUpdated: DateTime.now(),
          );

          // act
          final result = status.analyticsEventText;

          // assert
          expect(result, 'Earnings');
        },
      );

      test(
        'watchlistEventStatus_analyticsEventTextWithExactly24Chars_returnsOriginalText',
        () {
          // arrange
          const text = '123456789012345678901234';
          final status = WatchlistEventStatus(
            badgeText: text,
            badgeType: WatchlistBadgeType.neutral,
            eventDate: DateTime.now(),
            lastUpdated: DateTime.now(),
          );

          // act
          final result = status.analyticsEventText;

          // assert
          expect(result, text);
          expect(result.length, 24);
        },
      );

      test(
        'watchlistEventStatus_analyticsEventTextWithOver24Chars_returnsTruncatedText',
        () {
          // arrange
          const text =
              'This is a very long earnings event name that exceeds 24 chars';
          final status = WatchlistEventStatus(
            badgeText: text,
            badgeType: WatchlistBadgeType.neutral,
            eventDate: DateTime.now(),
            lastUpdated: DateTime.now(),
          );

          // act
          final result = status.analyticsEventText;

          // assert
          expect(result, 'This is a very long e...');
          expect(result.length, 24);
        },
      );
    });

    group('isUpcoming', () {
      test('watchlistEventStatus_isUpcomingWithPastDate_returnsFalse', () {
        // arrange
        final pastDate = DateTime.now().subtract(const Duration(days: 1));
        final status = WatchlistEventStatus(
          badgeText: 'Past Event',
          badgeType: WatchlistBadgeType.neutral,
          eventDate: pastDate,
          lastUpdated: DateTime.now(),
        );

        // act
        final result = status.isUpcoming;

        // assert
        expect(result, false);
      });

      test('watchlistEventStatus_isUpcomingWithTodayDate_returnsTrue', () {
        // arrange
        final today = DateTime.now();
        final status = WatchlistEventStatus(
          badgeText: 'Today Event',
          badgeType: WatchlistBadgeType.neutral,
          eventDate: today,
          lastUpdated: DateTime.now(),
        );

        // act
        final result = status.isUpcoming;

        // assert
        expect(result, true);
      });

      test('watchlistEventStatus_isUpcomingWithFutureDate_returnsTrue', () {
        // arrange
        final futureDate = DateTime.now().add(const Duration(days: 7));
        final status = WatchlistEventStatus(
          badgeText: 'Future Event',
          badgeType: WatchlistBadgeType.neutral,
          eventDate: futureDate,
          lastUpdated: DateTime.now(),
        );

        // act
        final result = status.isUpcoming;

        // assert
        expect(result, true);
      });
    });
  });
}
