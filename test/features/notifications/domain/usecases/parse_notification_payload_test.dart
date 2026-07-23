import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';
import 'package:bizzie/features/notifications/domain/usecases/parse_notification_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ParseNotificationPayload sut;

  setUp(() {
    sut = ParseNotificationPayload();
  });

  group('ParseNotificationPayload', () {
    group('stock_news', () {
      test(
        'call_validStockNewsPayload_returnsStockNewsIntent',
        () {
          // arrange
          final params = {
            'type': 'stock_news',
            'ticker': 'AAPL',
            'newsId': 'AAPL_a1b2c3d4',
          };

          // act
          final result = sut(params);

          // assert
          expect(
            result,
            const NotificationIntent.stockNews(
              ticker: 'AAPL',
              newsId: 'AAPL_a1b2c3d4',
            ),
          );
        },
      );

      test(
        'call_stockNewsPayloadMissingNewsId_returnsNull',
        () {
          // arrange
          final params = {'type': 'stock_news', 'ticker': 'AAPL'};

          // act
          final result = sut(params);

          // assert
          expect(result, isNull);
        },
      );

      test(
        'call_stockNewsPayloadMissingTicker_returnsNull',
        () {
          // arrange
          final params = {
            'type': 'stock_news',
            'newsId': 'AAPL_a1b2c3d4',
          };

          // act
          final result = sut(params);

          // assert
          expect(result, isNull);
        },
      );

      test(
        'call_stockNewsPayloadEmptyNewsId_returnsNull',
        () {
          // arrange
          final params = {
            'type': 'stock_news',
            'ticker': 'AAPL',
            'newsId': '',
          };

          // act
          final result = sut(params);

          // assert
          expect(result, isNull);
        },
      );
    });
  });
}
