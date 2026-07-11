import 'package:bizzie/features/company_profile/dividends/data/interfaces/i_dividends_firestore_datasource.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/dividends/data/datasources/dividends_remote_data_source.dart';
import 'package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart';
import 'package:bizzie/features/company_profile/dividends/data/repositories/dividend_repository_impl.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/error/failures.dart';

class MockDividendsRemoteDataSource extends Mock
    implements DividendsRemoteDataSource {}

class MockDividendsLocalDataSource extends Mock
    implements IDividendsFirestoreDataSource {}

void main() {
  late DividendRepositoryImpl repository;
  late MockDividendsRemoteDataSource mockRemoteDataSource;
  late MockDividendsLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockDividendsRemoteDataSource();
    mockLocalDataSource = MockDividendsLocalDataSource();
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

    test('getDividendInfo_success_returnsRightWithData', () async {
      // Arrange
      when(
        () => mockLocalDataSource.syncDividends(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async =>
            result.CacheSuccess(tDividendsList, CompanyProfileDataOrigin.api),
      );

      // Act
      final resultData = await repository.getDividendInfo(tTicker);

      // Assert
      expect(resultData.isRight(), true);
      resultData.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<DividendInfo>());
        expect(origin, CompanyProfileDataOrigin.api);
        expect(r.history.length, 1);
        expect(r.history.first.dividend, 0.23);
      });
    });

    test('getDividendInfo_failure_returnLeftFailure', () async {
      // Arrange
      when(
        () => mockLocalDataSource.syncDividends(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => const result.CacheFailure(Failure.server('error')),
      );

      // Act
      final resultData = await repository.getDividendInfo(tTicker);

      // Assert
      expect(resultData.isLeft(), true);
    });
  });
}
