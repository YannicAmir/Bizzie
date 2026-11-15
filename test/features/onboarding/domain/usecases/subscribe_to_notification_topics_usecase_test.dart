import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/notification_topics_params.dart';
import 'package:bizzie/features/onboarding/domain/usecases/subscribe_to_notification_topics_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

const tParams = NotificationTopicsParams(
  sectorName: 'Information Technology',
  tickers: ['AAPL', 'MSFT'],
);

void main() {
  late SubscribeToNotificationTopicsUseCase sut;
  late MockNotificationRepository mockNotificationRepository;

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    sut = SubscribeToNotificationTopicsUseCase(mockNotificationRepository);
  });

  group('SubscribeToNotificationTopicsUseCase', () {
    test(
      'call_subscriptionsSucceed_subscribesSectorThenTickersAndReturnsRight',
      () async {
        // arrange
        when(
          () => mockNotificationRepository.subscribeToSectorTopic(any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockNotificationRepository.subscribeToTickerTopic(any()),
        ).thenAnswer((_) async => const Right(null));

        // act
        final result = await sut(tParams);

        // assert
        expect(result, const Right(null));
        verifyInOrder([
          () => mockNotificationRepository.subscribeToSectorTopic(
            'Information Technology',
          ),
          () => mockNotificationRepository.subscribeToTickerTopic('AAPL'),
          () => mockNotificationRepository.subscribeToTickerTopic('MSFT'),
        ]);
        verifyNoMoreInteractions(mockNotificationRepository);
      },
    );

    test('call_noSector_subscribesTickersOnly', () async {
      // arrange
      when(
        () => mockNotificationRepository.subscribeToTickerTopic(any()),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await sut(
        const NotificationTopicsParams(tickers: ['MSFT']),
      );

      // assert
      expect(result, const Right(null));
      verify(
        () => mockNotificationRepository.subscribeToTickerTopic('MSFT'),
      ).called(1);
      verifyNoMoreInteractions(mockNotificationRepository);
    });

    test('call_sectorSubscriptionFails_returnsLeftAndSkipsTickers', () async {
      // arrange
      when(
        () => mockNotificationRepository.subscribeToSectorTopic(any()),
      ).thenAnswer((_) async => const Left(Failure.server('fcm down')));

      // act
      final result = await sut(tParams);

      // assert
      expect(result, const Left(Failure.server('fcm down')));
      verifyNever(
        () => mockNotificationRepository.subscribeToTickerTopic(any()),
      );
    });

    test('call_tickerSubscriptionFails_returnsLeftAndStops', () async {
      // arrange
      when(
        () => mockNotificationRepository.subscribeToSectorTopic(any()),
      ).thenAnswer((_) async => const Right(null));
      when(
        () => mockNotificationRepository.subscribeToTickerTopic('AAPL'),
      ).thenAnswer((_) async => const Left(Failure.server('fcm down')));

      // act
      final result = await sut(tParams);

      // assert
      expect(result, const Left(Failure.server('fcm down')));
      verifyNever(
        () => mockNotificationRepository.subscribeToTickerTopic('MSFT'),
      );
    });
  });
}
