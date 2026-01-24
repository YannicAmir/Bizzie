import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/historical_price_eod_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/data/repositories/price_repository_impl.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/domain/models/price_history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late PriceRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = PriceRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const tTicker = 'AAPL';

  group('PriceRepositoryImpl - PriceHistory', () {
    final tPriceDto = HistoricalPriceDto(
      date: '2023-01-01',
      price: 150.0,
      close: 150.0,
      volume: 1000000,
    );
    final tPriceList = [tPriceDto];

    test('getPriceHistory_cacheHit_returnsLocalData', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedPrices(tTicker),
      ).thenAnswer((_) async => tPriceList);

      // act
      final result = await repository.getPriceHistory(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<PriceHistory>());
        expect(r.symbol, tTicker);
        expect(r.history.length, 1);
        expect(r.history.first.close, 150.0);
      });
      verify(() => mockLocalDataSource.getCachedPrices(tTicker)).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
      'getPriceHistory_cacheMiss_fetchesRemoteAndCaches_returnsData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedPrices(tTicker),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getHistoricalPrice(tTicker),
        ).thenAnswer((_) async => tPriceList);
        when(
          () => mockLocalDataSource.cachePrices(tTicker, tPriceList),
        ).thenAnswer((_) async => Future.value());

        // act
        final result = await repository.getPriceHistory(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r, isA<PriceHistory>());
          expect(r.history.length, 1);
        });
        verify(() => mockLocalDataSource.getCachedPrices(tTicker)).called(1);
        verify(
          () => mockRemoteDataSource.getHistoricalPrice(tTicker),
        ).called(1);
        verify(
          () => mockLocalDataSource.cachePrices(tTicker, tPriceList),
        ).called(1);
      },
    );

    test('getPriceHistory_serverFailure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedPrices(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getHistoricalPrice(tTicker),
      ).thenThrow(Exception('Server Error'));

      // act
      final result = await repository.getPriceHistory(tTicker);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return left'),
      );
    });
  });

  group('PriceRepositoryImpl - HistoricalEodPrices', () {
    final tEodDto = HistoricalPriceEodDto(
      symbol: tTicker,
      date: '2023-01-01',
      price: 155.0,
      volume: 2000000,
    );
    final tEodList = [tEodDto];

    test('getHistoricalEodPrices_cacheHit_returnsLocalData', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedHistoricalEodPrices(tTicker),
      ).thenAnswer((_) async => tEodList);

      // act
      final result = await repository.getHistoricalEodPrices(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<List<HistoricalPriceEod>>());
        expect(r.length, 1);
        expect(r.first.price, 155.0);
      });
      verify(
        () => mockLocalDataSource.getCachedHistoricalEodPrices(tTicker),
      ).called(1);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
      'getHistoricalEodPrices_cacheMiss_fetchesRemoteAndCaches_returnsData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedHistoricalEodPrices(tTicker),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getHistoricalEodPrices(tTicker),
        ).thenAnswer((_) async => tEodList);
        when(
          () => mockLocalDataSource.cacheHistoricalEodPrices(tTicker, tEodList),
        ).thenAnswer((_) async => Future.value());

        // act
        final result = await repository.getHistoricalEodPrices(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r, isA<List<HistoricalPriceEod>>());
          expect(r.first.price, 155.0);
        });
        verify(
          () => mockLocalDataSource.getCachedHistoricalEodPrices(tTicker),
        ).called(1);
        verify(
          () => mockRemoteDataSource.getHistoricalEodPrices(tTicker),
        ).called(1);
        verify(
          () => mockLocalDataSource.cacheHistoricalEodPrices(tTicker, tEodList),
        ).called(1);
      },
    );

    test('getHistoricalEodPrices_serverFailure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedHistoricalEodPrices(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getHistoricalEodPrices(tTicker),
      ).thenThrow(Exception('Server Error'));

      // act
      final result = await repository.getHistoricalEodPrices(tTicker);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return left'),
      );
    });
  });
}
