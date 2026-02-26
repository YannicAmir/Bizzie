import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/net_income/data/repositories/net_income_repository_impl.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements FinancialStatementsFirestoreDataSource {}

void main() {
  late NetIncomeRepositoryImpl repository;
  late MockFinancialRemoteDataSource mockRemoteDataSource;
  late MockFinancialLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockFinancialRemoteDataSource();
    mockLocalDataSource = MockFinancialLocalDataSource();
    repository = NetIncomeRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  const tTicker = 'AAPL';

  group('NetIncomeRepositoryImpl', () {
    final tIncomeStatementDto = IncomeStatementDto(
      date: '2023-01-01',
      period: 'FY',
      netIncome: 100.0,
      reportedCurrency: 'USD',
      symbol: 'AAPL',
      cik: '0000320193',
      filingDate: '2023-01-01',
      acceptedDate: '2023-01-01',
      fiscalYear: '2022',
    );
    final List<IncomeStatementDto> tIncomeStatements = [tIncomeStatementDto];

    test(
      'getNetIncomeStats_cacheInformationResult_returnsRightWithData',
      () async {
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
        final result = await repository.getNetIncomeStats(tTicker);

        // Assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (tuple) {
          final r = tuple.$1;
          final origin = tuple.$2;
          expect(r, isA<NetIncomeStats>());
          expect(origin, CompanyProfileDataOrigin.cache);
          expect(r.annualNetIncome.length, 1);
          expect(r.annualNetIncome.first.value, 100.0);
        });
      },
    );

    test('getNetIncomeStats_serverExample_returnLeftFailure', () async {
      // Arrange
      when(
        () => mockLocalDataSource.getCachedIncomeStatements(
          tTicker,
          period: any(named: 'period'),
        ),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getIncomeStatements(
          tTicker,
          period: any(named: 'period'),
        ),
      ).thenThrow(Exception('Server Error'));

      // Act
      final result = await repository.getNetIncomeStats(tTicker);

      // Assert
      expect(result.isLeft(), true);
    });
  });
}
