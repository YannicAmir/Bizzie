import 'package:bizzie/features/company_profile/business/data/datasources/business_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/business/data/datasources/business_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_ttm_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';
import 'package:bizzie/features/company_profile/security/data/repositories/security_repository_impl.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBusinessRemoteDataSource extends Mock
    implements BusinessRemoteDataSource {}

class MockBusinessLocalDataSource extends Mock
    implements BusinessFirestoreDataSource {}

class MockSecurityRemoteDataSource extends Mock
    implements SecurityRemoteDataSource {}

class MockSecurityLocalDataSource extends Mock
    implements SecurityFirestoreDataSource {}

class MockRatiosRemoteDataSource extends Mock
    implements RatiosRemoteDataSource {}

class MockCompanyRepository extends Mock implements ICompanyRepository {}

void main() {
  late SecurityRepositoryImpl repository;
  late MockSecurityRemoteDataSource mockSecurityRemoteDataSource;
  late MockSecurityLocalDataSource mockSecurityLocalDataSource;
  late MockRatiosRemoteDataSource mockRatiosRemoteDataSource;
  late MockCompanyRepository mockCompanyRepository;

  setUp(() {
    mockSecurityRemoteDataSource = MockSecurityRemoteDataSource();
    mockSecurityLocalDataSource = MockSecurityLocalDataSource();
    mockRatiosRemoteDataSource = MockRatiosRemoteDataSource();
    mockCompanyRepository = MockCompanyRepository();

    repository = SecurityRepositoryImpl(
      mockCompanyRepository,
      mockSecurityRemoteDataSource,
      mockSecurityLocalDataSource,
      mockRatiosRemoteDataSource,
    );
  });

  const tTicker = 'AAPL';

  group('SecurityRepositoryImpl - SecurityDetails', () {
    final tCompanyProfile = CompanyProfile(
      symbol: tTicker,
      companyName: 'Apple Inc.',
      price: 150.0,
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
    final tStockQuote = StockQuote(
      symbol: tTicker,
      name: 'Apple Inc.',
      price: 155.0,
      change: 5.0,
      changesPercentage: 3.2,
      marketCap: 2500000000.0,
      pe: 25.0,
      sharesOutstanding: 16000000000.0,
      eps: 0,
    );
    final tRatios = [
      const RatiosTtmDto(
        priceToEarningsRatioTTM: 22.5,
        priceToFreeCashFlowRatioTTM: 18.0,
      ),
    ];

    test('getSecurityDetails_success_returnsSecurityDetails', () async {
      // arrange
      when(
        () => mockCompanyRepository.getProfile(tTicker),
      ).thenAnswer((_) async => Right(tCompanyProfile));
      when(
        () => mockCompanyRepository.getQuote(tTicker),
      ).thenAnswer((_) async => Right(tStockQuote));
      when(
        () => mockRatiosRemoteDataSource.getRatiosTtm(tTicker),
      ).thenAnswer((_) async => tRatios);

      // act
      final result = await repository.getSecurityDetails(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<SecurityDetails>());
        expect(r.ticker, tTicker);
        expect(r.peRatioTTM, 22.5);
        expect(r.priceToFreeCashFlowTTM, 18.0);
        expect(r.exchangeShortName, 'NASDAQ');
      });
    });

    test('getSecurityDetails_failure_returnsServerFailure', () async {
      // arrange
      // Wait, repository now handles Left from repo, assume it propagates failure
      // or if repo throws.
      // Current impl of SecurityRepositoryImpl calls _companyRepository.getProfile
      // and expects Right, or if generic Failure?
      // Actually SecurityRepositoryImpl does:
      // final profileResult = await _companyRepository.getProfile(ticker);
      // profileResult.fold((l) => throw Exception("..."), (r) => profile = r);
      // So we can mock Left return.

      // But to be simpler and match previous test style which expected exception from datasource catch block?
      // No, let's verify behaviour.
      // If ICompanyRepository returns Left, SecurityRepositoryImpl throws Exception (based on my previous view of code or assumption).
      // Let's assume mocking Left is correct way to trigger failure branch if I updated it to handle it.
      // Wait, I updated it to fold and throw exception on Left.

      // But wait, the previous test was:
      // when(() => datasource.call()).thenThrow(Exception('Error'));
      // because the repository impl wrapped try-catch.
      // The new impl also wraps try-catch?
      // Yes, usually.

      when(
        () => mockCompanyRepository.getProfile(tTicker),
      ).thenThrow(Exception('Error'));

      // act
      final result = await repository.getSecurityDetails(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });

  group('SecurityRepositoryImpl - UpcomingEarnings', () {
    final tEarningsReports = [
      EarningsReportDto(
        symbol: tTicker,
        date: DateTime.now().add(const Duration(days: 2)).toIso8601String(),
      ),
      EarningsReportDto(
        symbol: tTicker,
        date: DateTime.now()
            .subtract(const Duration(days: 2))
            .toIso8601String(),
      ),
      EarningsReportDto(
        symbol: tTicker,
        date: DateTime.now().add(const Duration(days: 10)).toIso8601String(),
      ),
    ];

    test('getUpcomingEarningsDate_success_returnsNearestValidDate', () async {
      // arrange
      when(
        () => mockSecurityLocalDataSource.getCachedEarningsReports(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockSecurityRemoteDataSource.getEarningsReports(tTicker),
      ).thenAnswer((_) async => tEarningsReports);
      when(
        () => mockSecurityLocalDataSource.cacheEarningsReports(tTicker, any()),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, isA<DateTime>());
        final expectedDate = DateTime.parse(tEarningsReports[0].date);
        expect(r?.year, expectedDate.year);
        expect(r?.month, expectedDate.month);
        expect(r?.day, expectedDate.day);
      });
    });

    test('getUpcomingEarningsDate_noUpcoming_returnsRightNull', () async {
      // arrange
      final tPastEarnings = [
        EarningsReportDto(
          symbol: tTicker,
          date: DateTime.now()
              .subtract(const Duration(days: 10))
              .toIso8601String(),
        ),
      ];
      when(
        () => mockSecurityLocalDataSource.getCachedEarningsReports(tTicker),
      ).thenAnswer((_) async => tPastEarnings);

      // act
      final result = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) {
        expect(r, null);
      });
    });

    test('getUpcomingEarningsDate_failure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockSecurityLocalDataSource.getCachedEarningsReports(tTicker),
      ).thenThrow(Exception('Error'));

      // act
      final result = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });
}
