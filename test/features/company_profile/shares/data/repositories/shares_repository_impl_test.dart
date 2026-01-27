import 'package:bizzie/features/company_profile/business/data/datasources/business_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/business/data/datasources/business_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/shares/data/repositories/shares_repository_impl.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBusinessRemoteDataSource extends Mock
    implements BusinessRemoteDataSource {}

class MockBusinessLocalDataSource extends Mock
    implements BusinessFirestoreDataSource {}

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements FinancialStatementsFirestoreDataSource {}

void main() {
  late SharesRepositoryImpl repository;
  late MockBusinessRemoteDataSource mockBusinessRemoteDataSource;
  late MockBusinessLocalDataSource mockBusinessLocalDataSource;
  late MockFinancialRemoteDataSource mockFinancialRemoteDataSource;
  late MockFinancialLocalDataSource mockFinancialLocalDataSource;

  setUp(() {
    mockBusinessRemoteDataSource = MockBusinessRemoteDataSource();
    mockBusinessLocalDataSource = MockBusinessLocalDataSource();
    mockFinancialRemoteDataSource = MockFinancialRemoteDataSource();
    mockFinancialLocalDataSource = MockFinancialLocalDataSource();
    repository = SharesRepositoryImpl(
      mockBusinessRemoteDataSource,
      mockBusinessLocalDataSource,
      mockFinancialRemoteDataSource,
      mockFinancialLocalDataSource,
    );

    registerFallbackValue(const GovernanceDto(symbol: '', nameAndPosition: ''));
    registerFallbackValue(const <ExecutiveDto>[]);
  });

  const tTicker = 'AAPL';

  group('SharesRepositoryImpl - ShareStats', () {
    final tQuote = QuoteDto(
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
      // arrange
      when(
        () => mockBusinessLocalDataSource.getCachedQuote(tTicker),
      ).thenAnswer((_) async => tQuote);
      when(
        () => mockFinancialLocalDataSource.getCachedLegacyIncomeStatements(
          tTicker,
          period: 'annual',
        ),
      ).thenAnswer((_) async => tLegacyIncome);
      when(
        () => mockFinancialLocalDataSource.getCachedLegacyIncomeStatements(
          tTicker,
          period: 'quarter',
        ),
      ).thenAnswer((_) async => <LegacyIncomeStatementDto>[]);

      // act
      final result = await repository.getShareStats(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<ShareStats>());
        expect(r.currentSharesOutstanding, 16000000000.0);
        expect(r.annualWeightedAverageShares.length, 1);
      });
    });
  });
}
