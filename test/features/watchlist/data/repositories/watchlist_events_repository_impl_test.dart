import 'package:bizzie/features/watchlist/constants/watchlist_constants.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_event_status_dto.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_events_local_datasource.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_events_remote_datasource.dart';
import 'package:bizzie/features/watchlist/data/repositories/watchlist_events_repository_impl.dart';
import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/domain/services/watchlist_event_evaluator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock
    implements IWatchlistEventsLocalDataSource {}

class MockRemoteDataSource extends Mock
    implements IWatchlistEventsRemoteDataSource {}

class MockEvaluator extends Mock implements WatchlistEventEvaluator {}

void main() {
  late WatchlistEventsRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockEvaluator mockEvaluator;

  setUpAll(() {
    registerFallbackValue(<String, WatchlistEventStatusDto>{});
  });

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockEvaluator = MockEvaluator();
    repository = WatchlistEventsRepositoryImpl(
      mockLocalDataSource,
      mockRemoteDataSource,
      mockEvaluator,
    );
  });

  final tTickers = ['AAPL', 'TSLA'];
  final tNow = DateTime.now();

  final tStatus = WatchlistEventStatus(
    badgeText: 'Earnings',
    badgeType: WatchlistBadgeType.neutral,
    eventDate: tNow.add(const Duration(days: 1)),
    lastUpdated: tNow,
  );

  final tStatusDto = WatchlistEventStatusDto.fromDomain(tStatus);

  group('WatchlistEventsRepositoryImpl', () {
    test('getWatchlistEvents_tickersEmpty_returnsEmptyMap', () async {
      // act
      final result = await repository.getWatchlistEvents([]);

      // assert
      expect(result, isA<Right>());
      expect(result.getOrElse(() => {}), isEmpty);
      verifyZeroInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('getWatchlistEvents_allCachedAndValid_returnsCachedData', () async {
      // arrange
      final cachedData = {
        'AAPL': tStatusDto.copyWith(lastUpdated: tNow),
        'TSLA': tStatusDto.copyWith(lastUpdated: tNow),
      };
      when(
        () => mockLocalDataSource.getCachedEvents(),
      ).thenAnswer((_) async => cachedData);

      // act
      final result = await repository.getWatchlistEvents(tTickers);

      // assert
      expect(result, isA<Right>());
      final data = result.getOrElse(() => throw Exception());
      expect(data.length, 2);
      expect(data['AAPL']!.badgeText, 'Earnings');
      verify(() => mockLocalDataSource.getCachedEvents()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
      'getWatchlistEvents_someMissing_fetchesMissingAndMergesAndCaches',
      () async {
        // arrange
        final cachedData = {'AAPL': tStatusDto.copyWith(lastUpdated: tNow)};
        final tslaStatus = WatchlistEventStatus(
          badgeText: 'Filing',
          badgeType: WatchlistBadgeType.warning,
          eventDate: tNow.add(const Duration(days: 5)),
          lastUpdated: tNow,
        );

        when(
          () => mockLocalDataSource.getCachedEvents(),
        ).thenAnswer((_) async => cachedData);
        when(
          () => mockRemoteDataSource.getUpcomingEarnings(['TSLA']),
        ).thenAnswer((_) async => []);
        when(
          () => mockRemoteDataSource.getSecFilings(['TSLA']),
        ).thenAnswer((_) async => []);
        when(
          () => mockEvaluator.evaluate(
            earnings: any(named: 'earnings'),
            filing: any(named: 'filing'),
          ),
        ).thenReturn(tslaStatus);
        when(
          () => mockLocalDataSource.cacheEvents(any()),
        ).thenAnswer((_) async => {});

        // act
        final result = await repository.getWatchlistEvents(tTickers);

        // assert
        expect(result, isA<Right>());
        final data = result.getOrElse(() => throw Exception());
        expect(data.length, 2);
        expect(data['TSLA']!.badgeText, 'Filing');
        verify(() => mockLocalDataSource.getCachedEvents()).called(1);
        verify(
          () => mockRemoteDataSource.getUpcomingEarnings(['TSLA']),
        ).called(1);
        verify(() => mockRemoteDataSource.getSecFilings(['TSLA'])).called(1);
        verify(() => mockLocalDataSource.cacheEvents(any())).called(1);
      },
    );

    test('getWatchlistEvents_expiredCache_refetchesAll', () async {
      // arrange
      final expiredDate = tNow.subtract(
        WatchlistConstants.eventCacheTtl + const Duration(minutes: 1),
      );
      final cachedData = {
        'AAPL': tStatusDto.copyWith(lastUpdated: expiredDate),
      };
      when(
        () => mockLocalDataSource.getCachedEvents(),
      ).thenAnswer((_) async => cachedData);
      when(
        () => mockRemoteDataSource.getUpcomingEarnings(tTickers),
      ).thenAnswer((_) async => []);
      when(
        () => mockRemoteDataSource.getSecFilings(tTickers),
      ).thenAnswer((_) async => []);
      when(
        () => mockEvaluator.evaluate(
          earnings: any(named: 'earnings'),
          filing: any(named: 'filing'),
        ),
      ).thenReturn(tStatus);
      when(
        () => mockLocalDataSource.cacheEvents(any()),
      ).thenAnswer((_) async => {});

      // act
      final result = await repository.getWatchlistEvents(tTickers);

      // assert
      expect(result, isA<Right>());
      verify(
        () => mockRemoteDataSource.getUpcomingEarnings(tTickers),
      ).called(1);
      verify(() => mockRemoteDataSource.getSecFilings(tTickers)).called(1);
    });

    test('getWatchlistEvents_criticalError_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedEvents(),
      ).thenThrow(Exception('DB Error'));

      // act
      final result = await repository.getWatchlistEvents(tTickers);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (failure) => expect(failure.message, contains('DB Error')),
        (_) => fail('Should have failed'),
      );
    });
  });
}
