import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_local_datasource.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_remote_datasource.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistRemoteDataSource extends Mock
    implements IWatchlistRemoteDataSource {}

class MockWatchlistLocalDataSource extends Mock
    implements IWatchlistLocalDataSource {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

void main() {
  late WatchlistRepositoryImpl repository;
  late MockWatchlistRemoteDataSource mockRemoteDataSource;
  late MockWatchlistLocalDataSource mockLocalDataSource;
  late MockFirebaseMessaging mockFirebaseMessaging;

  setUp(() {
    mockRemoteDataSource = MockWatchlistRemoteDataSource();
    mockLocalDataSource = MockWatchlistLocalDataSource();
    mockFirebaseMessaging = MockFirebaseMessaging();
    repository = WatchlistRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockFirebaseMessaging,
    );

    registerFallbackValue(
      WatchlistItemDto(
        ticker: 'T',
        companyName: 'T',
        createdAt: DateTime.now(),
      ),
    );
  });

  const tCompany = Company(ticker: 'AAPL', name: 'Apple');
  const tUid = 'testUid';

  group('addToWatchlist', () {
    test('addToWatchlist_success_updatesRemoteAndLocalAndTopic', () async {
      // arrange
      when(
        () => mockRemoteDataSource.addWatchlistItem(any(), tUid),
      ).thenAnswer((_) async {});
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockLocalDataSource.getSubscribedTickers(),
      ).thenReturn(['GOOG']);
      when(
        () => mockLocalDataSource.cacheSubscribedTickers(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.addToWatchlist(tCompany, tUid);

      // assert
      expect(result, const Right(null));
      verify(
        () => mockRemoteDataSource.addWatchlistItem(any(), tUid),
      ).called(1);
      verify(() => mockFirebaseMessaging.subscribeToTopic('AAPL')).called(1);
      verify(
        () => mockLocalDataSource.cacheSubscribedTickers(['GOOG', 'AAPL']),
      ).called(1);
    });

    test('addToWatchlist_companyWithLogo_persistsLogoUrlInDto', () async {
      // arrange
      const tCompanyWithLogo = Company(
        ticker: 'AAPL',
        name: 'Apple',
        logoUrl: 'https://images.financialmodelingprep.com/symbol/AAPL.png',
      );
      when(
        () => mockRemoteDataSource.addWatchlistItem(any(), tUid),
      ).thenAnswer((_) async {});
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenAnswer((_) async {});
      when(() => mockLocalDataSource.getSubscribedTickers()).thenReturn([]);
      when(
        () => mockLocalDataSource.cacheSubscribedTickers(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.addToWatchlist(tCompanyWithLogo, tUid);

      // assert
      expect(result, const Right(null));
      final dto =
          verify(
                () => mockRemoteDataSource.addWatchlistItem(captureAny(), tUid),
              ).captured.single
              as WatchlistItemDto;
      expect(
        dto.logoUrl,
        'https://images.financialmodelingprep.com/symbol/AAPL.png',
      );
    });

    test('addToWatchlist_remoteFailure_returnsServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.addWatchlistItem(any(), any()),
      ).thenThrow(Exception('Remote Error'));

      // act
      final result = await repository.addToWatchlist(tCompany, tUid);

      // assert
      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return Left'),
      );
    });

    test('addToWatchlist_notificationFailure_logsWarningAndProceeds', () async {
      // arrange
      when(
        () => mockRemoteDataSource.addWatchlistItem(any(), tUid),
      ).thenAnswer((_) async {});
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenThrow(Exception('Topic Subscription Failed'));
      when(
        () => mockLocalDataSource.getSubscribedTickers(),
      ).thenReturn(['GOOG']);
      when(
        () => mockLocalDataSource.cacheSubscribedTickers(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.addToWatchlist(tCompany, tUid);

      // assert
      expect(result, const Right(null));
      verify(
        () => mockRemoteDataSource.addWatchlistItem(any(), tUid),
      ).called(1);
      verify(() => mockFirebaseMessaging.subscribeToTopic('AAPL')).called(1);
      verify(
        () => mockLocalDataSource.cacheSubscribedTickers(['GOOG', 'AAPL']),
      ).called(1);
    });
  });

  group('removeFromWatchlist', () {
    test('removeFromWatchlist_success_updatesRemoteAndLocalAndTopic', () async {
      // arrange
      when(
        () => mockRemoteDataSource.removeWatchlistItem('AAPL', tUid),
      ).thenAnswer((_) async {});
      when(
        () => mockFirebaseMessaging.unsubscribeFromTopic(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockLocalDataSource.getSubscribedTickers(),
      ).thenReturn(['AAPL', 'GOOG']);
      when(
        () => mockLocalDataSource.cacheSubscribedTickers(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.removeFromWatchlist('AAPL', tUid);

      // assert
      expect(result, const Right(null));
      verify(
        () => mockRemoteDataSource.removeWatchlistItem('AAPL', tUid),
      ).called(1);
      verify(
        () => mockFirebaseMessaging.unsubscribeFromTopic('AAPL'),
      ).called(1);
      verify(
        () => mockLocalDataSource.cacheSubscribedTickers(['GOOG']),
      ).called(1);
    });

    test(
      'removeFromWatchlist_notificationFailure_logsWarningAndProceeds',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.removeWatchlistItem('AAPL', tUid),
        ).thenAnswer((_) async {});
        when(
          () => mockFirebaseMessaging.unsubscribeFromTopic(any()),
        ).thenThrow(Exception('Topic Unsubscription Failed'));
        when(
          () => mockLocalDataSource.getSubscribedTickers(),
        ).thenReturn(['AAPL', 'GOOG']);
        when(
          () => mockLocalDataSource.cacheSubscribedTickers(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.removeFromWatchlist('AAPL', tUid);

        // assert
        expect(result, const Right(null));
        verify(
          () => mockRemoteDataSource.removeWatchlistItem('AAPL', tUid),
        ).called(1);
        verify(
          () => mockFirebaseMessaging.unsubscribeFromTopic('AAPL'),
        ).called(1);
        verify(
          () => mockLocalDataSource.cacheSubscribedTickers(['GOOG']),
        ).called(1);
      },
    );

    test('removeFromWatchlist_remoteFailure_returnsServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.removeWatchlistItem(any(), any()),
      ).thenThrow(Exception('Remote Error'));

      // act
      final result = await repository.removeFromWatchlist('AAPL', tUid);

      // assert
      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return Left'),
      );
    });
  });

  group('syncSubscriptions', () {
    test('syncSubscriptions_success_syncsTopicsAndCache', () async {
      // arrange
      final remoteTickers = ['AAPL', 'MSFT'];
      final localTickers = ['AAPL', 'GOOG'];

      when(
        () => mockLocalDataSource.getSubscribedTickers(),
      ).thenReturn(localTickers);
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockFirebaseMessaging.unsubscribeFromTopic(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockLocalDataSource.cacheSubscribedTickers(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.syncSubscriptions(remoteTickers);

      // assert
      expect(result, const Right(null));
      verify(() => mockFirebaseMessaging.subscribeToTopic('MSFT')).called(1);
      verify(
        () => mockFirebaseMessaging.unsubscribeFromTopic('GOOG'),
      ).called(1);
      verify(
        () => mockLocalDataSource.cacheSubscribedTickers(remoteTickers),
      ).called(1);
    });

    test('syncSubscriptions_cacheFailure_returnsServerFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getSubscribedTickers(),
      ).thenThrow(Exception('Cache Error'));

      // act
      final result = await repository.syncSubscriptions([]);

      // assert
      expect(result, isA<Left<Failure, void>>());
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return Left'),
      );
    });
  });

  group('getWatchlistStream', () {
    test('getWatchlistStream_success_emitsCompanies', () async {
      // arrange
      final tDto = WatchlistItemDto(
        ticker: 'AAPL',
        companyName: 'Apple',
        createdAt: DateTime.now(),
      );
      when(
        () => mockRemoteDataSource.getWatchlistStream(tUid),
      ).thenAnswer((_) => Stream.value([tDto]));

      // act
      final resultStream = repository.getWatchlistStream(tUid);

      // assert
      expect(
        resultStream,
        emitsInOrder([
          predicate<Either<Failure, List<Company>>>((result) {
            return result.fold(
              (l) => false,
              (r) =>
                  r.length == 1 &&
                  r.first == const Company(ticker: 'AAPL', name: 'Apple'),
            );
          }),
        ]),
      );
    });

    test('getWatchlistStream_remoteStreamError_emitsServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getWatchlistStream(tUid),
      ).thenAnswer((_) => Stream.error(Exception('Stream Error')));

      // act
      final resultStream = repository.getWatchlistStream(tUid);

      // assert
      expect(
        resultStream,
        emits(
          predicate<Either<Failure, List<Company>>>((result) {
            return result.fold((l) => l is ServerFailure, (r) => false);
          }),
        ),
      );
    });
  });
}
