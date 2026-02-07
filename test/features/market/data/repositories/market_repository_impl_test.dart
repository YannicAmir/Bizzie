import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market/data/datasources/market_local_datasource.dart';
import 'package:bizzie/features/market/data/datasources/market_remote_datasource.dart';
import 'package:bizzie/features/market/data/dtos/market_data_snapshot.dart';
import 'package:bizzie/features/market/data/dtos/sector_pe_dto.dart';
import 'package:bizzie/features/market/data/dtos/sector_performance_dto.dart';
import 'package:bizzie/features/market/data/repositories/market_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketRemoteDataSource extends Mock
    implements MarketRemoteDataSource {}

class MockMarketLocalDataSource extends Mock implements MarketLocalDataSource {}

void main() {
  late MarketRepositoryImpl repository;
  late MockMarketRemoteDataSource mockRemoteDataSource;
  late MockMarketLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(
      MarketDataSnapshot(
        date: '2026-02-07',
        peList: [],
        performanceList: [],
        cacheTimestamp: 0,
      ),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockMarketRemoteDataSource();
    mockLocalDataSource = MockMarketLocalDataSource();
    repository = MarketRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  const tSectorPeDto = SectorPeDto(
    date: '2026-02-07',
    sector: 'Technology',
    exchange: 'NASDAQ',
    pe: 25.5,
  );

  const tSectorPerformanceDto = SectorPerformanceDto(
    date: '2026-02-07',
    sector: 'Technology',
    exchange: 'NASDAQ',
    averageChange: 1.5,
  );

  final tMarketDataSnapshot = MarketDataSnapshot(
    date: '2026-02-07',
    peList: [tSectorPeDto],
    performanceList: [tSectorPerformanceDto],
    cacheTimestamp: DateTime.now().millisecondsSinceEpoch,
  );

  group('getSectorPeList', () {
    test(
      'getSectorPeList_freshCache_returnsCachedDataAndNoRemoteCall',
      () async {
        // arrange
        final freshSnapshot = tMarketDataSnapshot.copyWith(
          cacheTimestamp: DateTime.now().millisecondsSinceEpoch,
        );
        when(
          () => mockLocalDataSource.getLastKnownMarketData(),
        ).thenAnswer((_) async => freshSnapshot);

        // act
        final result = await repository.getSectorPeList();

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Should return data'), (data) {
          expect(data.length, 1);
          expect(data.first.pe, 25.5);
        });
        verify(() => mockLocalDataSource.getLastKnownMarketData()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'getSectorPeList_staleCache_returnsCachedDataAndRefreshesInBackground',
      () async {
        // arrange
        final staleTimestamp = DateTime.now()
            .subtract(const Duration(hours: 13))
            .millisecondsSinceEpoch;
        final staleSnapshot = tMarketDataSnapshot.copyWith(
          cacheTimestamp: staleTimestamp,
        );

        when(
          () => mockLocalDataSource.getLastKnownMarketData(),
        ).thenAnswer((_) async => staleSnapshot);
        when(
          () => mockRemoteDataSource.getMarketDataSnapshot(),
        ).thenAnswer((_) async => tMarketDataSnapshot);
        when(
          () => mockLocalDataSource.cacheMarketData(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.getSectorPeList();

        // assert
        expect(result.isRight(), true);
        verify(() => mockLocalDataSource.getLastKnownMarketData()).called(1);
        // Background refresh should be triggered
        verify(() => mockRemoteDataSource.getMarketDataSnapshot()).called(1);
      },
    );

    test('getSectorPeList_cacheMiss_fetchesFromRemoteAndCaches', () async {
      // arrange
      when(
        () => mockLocalDataSource.getLastKnownMarketData(),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getMarketDataSnapshot(),
      ).thenAnswer((_) async => tMarketDataSnapshot);
      when(
        () => mockLocalDataSource.cacheMarketData(any()),
      ).thenAnswer((_) async {});

      // act
      final result = await repository.getSectorPeList();

      // assert
      expect(result.isRight(), true);
      verify(() => mockLocalDataSource.getLastKnownMarketData()).called(1);
      verify(() => mockRemoteDataSource.getMarketDataSnapshot()).called(1);
      verify(
        () => mockLocalDataSource.cacheMarketData(tMarketDataSnapshot),
      ).called(1);
    });

    test(
      'getSectorPeList_remoteFailureWithNoCache_returnsServerFailure',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getLastKnownMarketData(),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getMarketDataSnapshot(),
        ).thenThrow(Exception('API Error'));

        // act
        final result = await repository.getSectorPeList();

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );

    test(
      'getSectorPeList_remoteFailureWithStaleCache_returnsStaleCacheAsFallback',
      () async {
        // arrange
        final staleTimestamp = DateTime.now()
            .subtract(const Duration(hours: 13))
            .millisecondsSinceEpoch;
        final staleSnapshot = tMarketDataSnapshot.copyWith(
          cacheTimestamp: staleTimestamp,
          date: '2026-02-06',
          peList: [tSectorPeDto.copyWith(date: '2026-02-06')],
        );

        // First call to _getSnapshot finds stale data
        when(
          () => mockLocalDataSource.getLastKnownMarketData(),
        ).thenAnswer((_) async => staleSnapshot);
        // Refresh fails
        when(
          () => mockRemoteDataSource.getMarketDataSnapshot(),
        ).thenThrow(Exception('API Error'));

        // act
        final result = await repository.getSectorPeList();

        // assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should return stale data instead of failure'),
          (data) => expect(data.first.date, '2026-02-06'),
        );
      },
    );
  });

  group('getSectorPerformanceList', () {
    test('getSectorPerformanceList_success_returnsConsistentData', () async {
      // arrange
      when(
        () => mockLocalDataSource.getLastKnownMarketData(),
      ).thenAnswer((_) async => tMarketDataSnapshot);

      // act
      final result = await repository.getSectorPerformanceList();

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Should return data'), (data) {
        expect(data.length, 1);
        expect(data.first.averageChange, 1.5);
      });
    });

    test('getSectorPerformanceList_failure_returnsServerFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getLastKnownMarketData(),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getMarketDataSnapshot(),
      ).thenThrow(Exception('API Error'));

      // act
      final result = await repository.getSectorPerformanceList();

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should return failure'),
      );
    });
  });
}
