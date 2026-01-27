import 'package:bizzie/features/company_profile/business/data/repositories/business_repository_impl.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';

import 'package:bizzie/features/company_profile/business/data/datasources/business_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/business/data/datasources/business_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/fmp_sec_filing_dto.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/profile_dtos.dart';
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
  late BusinessRepositoryImpl repository;
  late MockBusinessRemoteDataSource mockRemoteDataSource;
  late MockBusinessLocalDataSource mockLocalDataSource;
  late MockFinancialRemoteDataSource mockFinancialRemoteDataSource;
  late MockFinancialLocalDataSource mockFinancialLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockBusinessRemoteDataSource();
    mockLocalDataSource = MockBusinessLocalDataSource();
    mockFinancialRemoteDataSource = MockFinancialRemoteDataSource();
    mockFinancialLocalDataSource = MockFinancialLocalDataSource();
    repository = BusinessRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockFinancialRemoteDataSource,
      mockFinancialLocalDataSource,
    );

    registerFallbackValue(const GovernanceDto(symbol: '', nameAndPosition: ''));
    registerFallbackValue(const <ExecutiveDto>[]);
  });

  const tTicker = 'AAPL';
  final tProfile = ProfileDto(
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
    final tExecutives = [
      const ExecutiveDto(name: 'Tim Cook', title: 'CEO', pay: 1000000.0),
    ];
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
      // arrange
      when(
        () => mockLocalDataSource.getCachedProfile(tTicker),
      ).thenAnswer((_) async => tProfile);
      when(
        () => mockLocalDataSource.getCachedProxyUrl(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockLocalDataSource.getCachedGovernance(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockLocalDataSource.getCachedExecutives(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockFinancialRemoteDataSource.getSecFilings(tTicker),
      ).thenAnswer((_) async => tFilings);
      when(() => mockRemoteDataSource.getGovernance(tTicker)).thenAnswer(
        (_) async => [
          const GovernanceDto(symbol: tTicker, nameAndPosition: 'CEO'),
        ],
      );
      when(
        () => mockRemoteDataSource.getExecutives(tTicker),
      ).thenAnswer((_) async => tExecutives);
      when(
        () => mockLocalDataSource.cacheGovernance(tTicker, any(), any()),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockLocalDataSource.cacheProxyUrl(tTicker, any()),
      ).thenAnswer((_) async => Future.value());

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
      final result = await repository.getBusinessProfile(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<BusinessProfile>());
        expect(r.ceo, 'Tim Cook');
        expect(r.def14aUrl, 'https://sec.gov/def14a');
        expect(r.annualFilings.length, 1);
      });
    });
  });
}
