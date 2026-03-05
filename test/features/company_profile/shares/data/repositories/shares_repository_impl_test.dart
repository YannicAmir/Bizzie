import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';
import 'package:bizzie/features/company_profile/shares/data/repositories/shares_repository_impl.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements FinancialStatementsFirestoreDataSource {}

class MockCompanyRepository extends Mock implements ICompanyRepository {}

void main() {
  late SharesRepositoryImpl repository;
  late MockFinancialRemoteDataSource mockFinancialRemoteDataSource;
  late MockFinancialLocalDataSource mockFinancialLocalDataSource;
  late MockCompanyRepository mockCompanyRepository;

  setUp(() {
    mockFinancialRemoteDataSource = MockFinancialRemoteDataSource();
    mockFinancialLocalDataSource = MockFinancialLocalDataSource();
    mockCompanyRepository = MockCompanyRepository();
    repository = SharesRepositoryImpl(
      mockCompanyRepository,
      mockFinancialRemoteDataSource,
      mockFinancialLocalDataSource,
    );

    registerFallbackValue(const GovernanceDto(symbol: '', nameAndPosition: ''));
    registerFallbackValue(const <ExecutiveDto>[]);
  });

  const tTicker = 'AAPL';

  group('SharesRepositoryImpl - ShareStats', () {
    final tStockQuote = StockQuote(
      symbol: tTicker,
      name: 'Apple Inc.',
      price: 155.0,
      change: 5.0,
      changesPercentage: 3.2,
      marketCap: 2500000000.0,
      pe: 25.0,
      sharesOutstanding: 16000000000.0,
    );

    final tLegacyIncome = [
      const LegacyIncomeStatementDto(
        date: '2023-09-30',
        symbol: tTicker,
        reportedCurrency: 'USD',
        period: 'FY',
        weightedAverageShsOutDil: 16000000000,
        cik: '0000320193',
        fillingDate: '2023-10-01',
        acceptedDate: '2023-10-01',
        calendarYear: '2023',
        link: 'https://sec.gov/10k',
        finalLink: 'https://sec.gov/10k',
      ),
    ];

    test('getShareStats_success_returnsShareStats', () async {
      // Arrange
      when(() => mockCompanyRepository.getQuote(tTicker)).thenAnswer(
        (_) async => Right((tStockQuote, CompanyProfileDataOrigin.api)),
      );

      when(
        () => mockFinancialLocalDataSource.syncLegacyIncomeStatements(
          tTicker,
          period: any(named: 'period'),
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer((invocation) async {
        final period = invocation.namedArguments[#period] as String;
        if (period == 'annual') {
          return cache.CacheSuccess(
            tLegacyIncome,
            CompanyProfileDataOrigin.cache,
          );
        } else {
          return const cache.CacheSuccess(
            <LegacyIncomeStatementDto>[],
            CompanyProfileDataOrigin.cache,
          );
        }
      });

      // Act
      final result = await repository.getShareStats(tTicker);

      // Assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<ShareStats>());
        expect(origin, CompanyProfileDataOrigin.api); // Result of merging
        expect(r.currentSharesOutstanding, 16000000000.0);
        expect(r.annualWeightedAverageShares.length, 1);
      });
    });
  });
}
