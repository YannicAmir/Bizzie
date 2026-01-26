import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/dividends/data/repositories/dividend_repository_impl.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late DividendRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = DividendRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  const tTicker = 'AAPL';

  group('DividendRepositoryImpl', () {
    final tDividendDto = DividendDto(
      date: '2023-01-01',
      dividend: 0.23,
      adjDividend: 0.23,
      recordDate: '2023-01-02',
      paymentDate: '2023-01-15',
      declarationDate: '2022-12-15',
    );
    final List<DividendDto> tDividendsList = [tDividendDto];

    test(
      'getDividendInfo_cacheInformationResult_returnsRightWithData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedDividends(tTicker),
        ).thenAnswer((_) async => tDividendsList);

        // act
        final result = await repository.getDividendInfo(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r, isA<DividendInfo>());
          expect(r.history.length, 1);
          expect(r.history.first.dividend, 0.23);
        });
        verify(() => mockLocalDataSource.getCachedDividends(tTicker)).called(1);
        verifyZeroInteractions(mockRemoteDataSource);
      },
    );

    test(
      'getDividendInfo_cacheMiss_fetchesFromRemoteAndCaches_returnsRightWithData',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedDividends(tTicker),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getDividends(tTicker),
        ).thenAnswer((_) async => tDividendsList);
        when(
          () => mockLocalDataSource.cacheDividends(tTicker, tDividendsList),
        ).thenAnswer((_) async => Future.value());

        // act
        final result = await repository.getDividendInfo(tTicker);

        // assert
        expect(result.isRight(), true);
        verify(() => mockLocalDataSource.getCachedDividends(tTicker)).called(1);
        verify(() => mockRemoteDataSource.getDividends(tTicker)).called(1);
        verify(
          () => mockLocalDataSource.cacheDividends(tTicker, tDividendsList),
        ).called(1);
      },
    );

    test('getDividendInfo_serverExample_returnLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedDividends(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getDividends(tTicker),
      ).thenThrow(Exception('Server Error'));

      // act
      final result = await repository.getDividendInfo(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });
}
