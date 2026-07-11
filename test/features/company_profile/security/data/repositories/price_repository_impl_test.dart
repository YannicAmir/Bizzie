import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/data/interfaces/i_security_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_eod_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/company_profile/security/data/repositories/price_repository_impl.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/models/price_history.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityRemoteDataSource extends Mock
    implements SecurityRemoteDataSource {}

class MockSecurityLocalDataSource extends Mock
    implements ISecurityFirestoreDataSource {}

void main() {
  late PriceRepositoryImpl repository;
  late MockSecurityRemoteDataSource mockRemoteDataSource;
  late MockSecurityLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSecurityRemoteDataSource();
    mockLocalDataSource = MockSecurityLocalDataSource();
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

    test('getPriceHistory_success_returnsData', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncPrices(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async =>
            cache.CacheSuccess(tPriceList, CompanyProfileDataOrigin.api),
      );

      // act
      final resultData = await repository.getPriceHistory(tTicker);

      // assert
      expect(resultData.isRight(), true);
      resultData.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<PriceHistory>());
        expect(origin, CompanyProfileDataOrigin.api);
        expect(r.history.length, 1);
      });
    });

    test('getPriceHistory_failure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncPrices(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => const cache.CacheFailure(Failure.server('error')),
      );

      // act
      final resultData = await repository.getPriceHistory(tTicker);

      // assert
      expect(resultData.isLeft(), true);
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

    test('getHistoricalEodPrices_success_returnsData', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncHistoricalEodPrices(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => cache.CacheSuccess(tEodList, CompanyProfileDataOrigin.api),
      );

      // act
      final resultData = await repository.getHistoricalEodPrices(tTicker);

      // assert
      expect(resultData.isRight(), true);
      resultData.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<List<HistoricalPriceEod>>());
        expect(origin, CompanyProfileDataOrigin.api);
        expect(r.first.price, 155.0);
      });
    });

    test('getHistoricalEodPrices_failure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.syncHistoricalEodPrices(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => const cache.CacheFailure(Failure.server('error')),
      );

      // act
      final resultData = await repository.getHistoricalEodPrices(tTicker);

      // assert
      expect(resultData.isLeft(), true);
    });
  });
}
