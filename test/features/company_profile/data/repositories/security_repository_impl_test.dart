import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/fmp_sec_filing_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/ratios_ttm_dto.dart';
import 'package:bizzie/features/company_profile/data/repositories/security_repository_impl.dart';
import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CompanyRemoteDataSource {}

class MockLocalDataSource extends Mock implements CompanyFirestoreDataSource {}

void main() {
  late SecurityRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = SecurityRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
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

  group('SecurityRepositoryImpl - SecurityDetails', () {
    test('getSecurityDetails_success_returnsSecurityDetails', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedProfile(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getProfile(tTicker),
      ).thenAnswer((_) async => [tProfile]);
      when(
        () => mockLocalDataSource.cacheProfile(tTicker, tProfile),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockLocalDataSource.getCachedQuote(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getQuote(tTicker),
      ).thenAnswer((_) async => [tQuote]);
      when(
        () => mockLocalDataSource.cacheQuote(tTicker, tQuote),
      ).thenAnswer((_) async => Future.value());

      when(() => mockRemoteDataSource.getRatiosTtm(tTicker)).thenAnswer(
        (_) async => [
          const RatiosTtmDto(
            symbol: tTicker,
            priceToEarningsRatioTTM: 26.0,
            priceToFreeCashFlowRatioTTM: 20.0,
          ),
        ],
      );

      // act
      final result = await repository.getSecurityDetails(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<SecurityDetails>());
        expect(r.ticker, tTicker);
        expect(r.peRatioTTM, 26.0);
        expect(r.priceToFreeCashFlowTTM, 20.0);
      });
    });

    test(
      'getSecurityDetails_ratiosFetchFails_stillReturnsDetailsWithQuotePe',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedProfile(tTicker),
        ).thenAnswer((_) async => tProfile);
        when(
          () => mockLocalDataSource.getCachedQuote(tTicker),
        ).thenAnswer((_) async => tQuote);
        when(
          () => mockRemoteDataSource.getRatiosTtm(tTicker),
        ).thenThrow(Exception('API error'));

        // act
        final result = await repository.getSecurityDetails(tTicker);

        // assert
        expect(result.isRight(), true);
        result.fold((l) => fail('Should return right'), (r) {
          expect(r.peRatioTTM, 25.0); // Fallback to quote.pe
        });
      },
    );

    test('getSecurityDetails_profileNotFound_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedProfile(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getProfile(tTicker),
      ).thenAnswer((_) async => []);

      // act
      final result = await repository.getSecurityDetails(tTicker);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should return left'),
      );
    });
  });

  group('SecurityRepositoryImpl - BusinessProfile', () {
    final tExecutives = [
      const ExecutiveDto(name: 'Tim Cook', title: 'CEO', pay: 1000000.0),
    ];
    final tFilings = [
      const FmpSecFilingDto(
        symbol: tTicker,
        filingDate: '2023-11-01',
        formType: 'DEF 14A',
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
        () => mockLocalDataSource.getCachedGovernance(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockLocalDataSource.getCachedExecutives(tTicker),
      ).thenAnswer((_) async => null);
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
        () => mockLocalDataSource.getCachedProxyUrl(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getSecFilings(tTicker),
      ).thenAnswer((_) async => tFilings);
      when(
        () => mockLocalDataSource.cacheProxyUrl(tTicker, any()),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockLocalDataSource.getCachedLegacyIncomeStatements(
          tTicker,
          period: 'annual',
        ),
      ).thenAnswer((_) async => tLegacyIncome);
      when(
        () => mockLocalDataSource.getCachedLegacyIncomeStatements(
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

  group('SecurityRepositoryImpl - ShareStats', () {
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
        () => mockLocalDataSource.getCachedQuote(tTicker),
      ).thenAnswer((_) async => tQuote);
      when(
        () => mockLocalDataSource.getCachedLegacyIncomeStatements(
          tTicker,
          period: 'annual',
        ),
      ).thenAnswer((_) async => tLegacyIncome);
      when(
        () => mockLocalDataSource.getCachedLegacyIncomeStatements(
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
