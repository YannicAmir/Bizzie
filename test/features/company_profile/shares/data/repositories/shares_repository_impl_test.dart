import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/shares/data/repositories/shares_repository_impl.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements IFinancialStatementsFirestoreDataSource {}

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
  });

  const tTicker = 'AAPL';

  group('SharesRepositoryImpl - ShareStats', () {
    final tCompanyProfile = CompanyProfile(
      symbol: tTicker,
      companyName: 'Apple Inc.',
      price: 155.0,
      marketCap: 2480000000000.0,
      beta: 1.2,
      industry: 'Consumer Electronics',
      sector: 'Technology',
      description: 'Tech giant',
      image: 'https://example.com/image.png',
      exchangeShortName: 'NASDAQ',
      country: 'US',
      ipoDate: '1980-12-12',
      website: 'https://apple.com',
      currency: 'USD',
      isEtf: false,
      isFund: false,
      isActivelyTrading: true,
      address: '',
      city: '',
      state: '',
      zip: '',
      fullTimeEmployees: '',
      ceo: '',
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
      when(() => mockCompanyRepository.getProfile(tTicker)).thenAnswer(
        (_) async => Right((tCompanyProfile, CompanyProfileDataOrigin.api)),
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
        expect(r.currentSharesOutstanding, 2480000000000.0 / 155.0);
        expect(r.annualWeightedAverageShares.length, 1);
      });
    });
  });
}
