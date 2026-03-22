import 'package:bizzie/features/company_profile/business/data/repositories/business_repository_impl.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';

import 'package:bizzie/features/company_profile/business/data/datasources/business_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/fmp_sec_filing_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;

class MockBusinessLocalDataSource extends Mock
    implements BusinessFirestoreDataSource {}

class MockFinancialRemoteDataSource extends Mock
    implements FinancialStatementsRemoteDataSource {}

class MockFinancialLocalDataSource extends Mock
    implements FinancialStatementsFirestoreDataSource {}

class MockCompanyRepository extends Mock implements ICompanyRepository {}

void main() {
  late BusinessRepositoryImpl repository;
  late MockBusinessLocalDataSource mockLocalDataSource;
  late MockFinancialRemoteDataSource mockFinancialRemoteDataSource;
  late MockFinancialLocalDataSource mockFinancialLocalDataSource;
  late MockCompanyRepository mockCompanyRepository;

  setUp(() {
    mockLocalDataSource = MockBusinessLocalDataSource();
    mockFinancialRemoteDataSource = MockFinancialRemoteDataSource();
    mockFinancialLocalDataSource = MockFinancialLocalDataSource();
    mockCompanyRepository = MockCompanyRepository();
    repository = BusinessRepositoryImpl(
      mockCompanyRepository,
      mockLocalDataSource,
      mockFinancialRemoteDataSource,
      mockFinancialLocalDataSource,
    );
  });

  const tTicker = 'AAPL';
  final tCompanyProfile = CompanyProfile(
    symbol: tTicker,
    companyName: 'Apple Inc.',
    price: 150.0,
    beta: 1.2,
    industry: 'Consumer Electronics',
    sector: 'Technology',
    description: 'Tech giant',
    image: 'https://example.com/image.png',
    address: '1 Infinite Loop',
    city: 'Cupertino',
    state: 'CA',
    zip: '95014',
    website: 'https://apple.com',
    fullTimeEmployees: '100000',
    ceo: 'Tim Cook',
    isEtf: false,
    isActivelyTrading: true,
  );

  group('BusinessRepositoryImpl - BusinessProfile', () {
    final tLegacyIncome = [
      const LegacyIncomeStatementDto(
        date: '2023-09-30',
        symbol: tTicker,
        reportedCurrency: 'USD',
        period: 'FY',
        finalLink: 'https://sec.gov/10k',
        cik: '0000320193',
        fillingDate: '2023-10-01',
        acceptedDate: '2023-10-01',
        calendarYear: '2023',
        link: 'https://sec.gov/10k',
      ),
    ];

    test('getBusinessProfile_success_returnsBusinessProfile', () async {
      final tFilings = [
        const FmpSecFilingDto(
          symbol: tTicker,
          filingDate: '2023-01-01',
          acceptedDate: '2023-01-01',
          formType: '10-K',
          link: 'https://sec.gov/10k',
          finalLink: 'https://sec.gov/10k',
        ),
        const FmpSecFilingDto(
          symbol: tTicker,
          filingDate: '2023-01-02',
          acceptedDate: '2023-01-02',
          formType: 'DEF 14A',
          link: 'https://sec.gov/def14a',
          finalLink: 'https://sec.gov/def14a',
        ),
      ];
      // Arrange
      when(() => mockCompanyRepository.getProfile(tTicker)).thenAnswer(
        (_) async => Right((tCompanyProfile, CompanyProfileDataOrigin.api)),
      );

      when(
        () => mockFinancialRemoteDataSource.getSecFilings(tTicker),
      ).thenAnswer((_) async => tFilings);

      when(
        () => mockLocalDataSource.getCachedProxyUrl(tTicker),
      ).thenAnswer((_) async => (null, CompanyProfileDataOrigin.cache));

      when(
        () => mockLocalDataSource.cacheProxyUrl(tTicker, any()),
      ).thenAnswer((_) async => Future.value());

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
      final result = await repository.getBusinessProfile(tTicker);

      // Assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        final profile = r.$1;
        final origin = r.$2;
        expect(profile, isA<BusinessProfile>());
        expect(profile.ceo, 'Tim Cook');
        expect(profile.def14aUrl, 'https://sec.gov/def14a');
        expect(profile.annualFilings.length, 1);
        expect(origin, CompanyProfileDataOrigin.api);
      });
    });
  });
}
