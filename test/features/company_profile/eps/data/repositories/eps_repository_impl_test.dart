import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/eps/data/repositories/eps_repository_impl.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements FinancialStatementsFirestoreDataSource {}

void main() {
  late EpsRepositoryImpl repository;
  late MockFinancialRemoteDataSource mockRemoteDataSource;
  late MockFinancialLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockFinancialRemoteDataSource();
    mockLocalDataSource = MockFinancialLocalDataSource();
    repository = EpsRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const tTicker = 'AAPL';

  group('EpsRepositoryImpl', () {
    final tIncomeStatementDto = IncomeStatementDto(
      date: '2023-01-01',
      period: 'FY',
      epsDiluted: 10.0,
      reportedCurrency: 'USD',
      symbol: 'AAPL',
      cik: '0000320193',
      filingDate: '2023-01-01',
      acceptedDate: '2023-01-01',
      fiscalYear: '2022',
    );
    final List<IncomeStatementDto> tIncomeStatements = [tIncomeStatementDto];

    test('getEpsStats_cacheInformationResult_returnsRightWithData', () async {
      // Arrange
      when(
        () => mockLocalDataSource.syncIncomeStatements(
          tTicker,
          period: any(named: 'period'),
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => cache.CacheSuccess(
          tIncomeStatements,
          CompanyProfileDataOrigin.cache,
        ),
      );

      // Act
      final result = await repository.getEpsStats(tTicker);

      // Assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<EpsStats>());
        expect(origin, CompanyProfileDataOrigin.cache);
        expect(r.annualEps.length, 1);
        expect(r.annualEps.first.value, 10.0);
      });
    });

    test('getEpsStats_serverExample_returnLeftFailure', () async {
      // Arrange
      when(
        () => mockLocalDataSource.syncIncomeStatements(
          tTicker,
          period: any(named: 'period'),
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => const cache.CacheFailure(Failure.server('Server Error')),
      );

      // Act
      final result = await repository.getEpsStats(tTicker);

      // Assert
      expect(result.isLeft(), true);
    });
  });
}
