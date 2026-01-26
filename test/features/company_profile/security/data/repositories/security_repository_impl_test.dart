import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/ratios_ttm_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/security/data/repositories/security_repository_impl.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
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

    registerFallbackValue(const ProfileDto(symbol: ''));
    registerFallbackValue(const QuoteDto(symbol: '', name: ''));
  });

  const tTicker = 'AAPL';

  group('SecurityRepositoryImpl - SecurityDetails', () {
    final tProfile = ProfileDto(
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
    final tRatios = [
      const RatiosTtmDto(
        priceToEarningsRatioTTM: 22.5,
        priceToFreeCashFlowRatioTTM: 18.0,
      ),
    ];

    test('getSecurityDetails_success_returnsSecurityDetails', () async {
      // arrange
      when(
        () => mockLocalDataSource.getCachedProfile(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getProfile(tTicker),
      ).thenAnswer((_) async => [tProfile]);
      when(
        () => mockLocalDataSource.cacheProfile(tTicker, any()),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockLocalDataSource.getCachedQuote(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getQuote(tTicker),
      ).thenAnswer((_) async => [tQuote]);
      when(
        () => mockLocalDataSource.cacheQuote(tTicker, any()),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockRemoteDataSource.getRatiosTtm(tTicker),
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
      when(
        () => mockLocalDataSource.getCachedProfile(tTicker),
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
        () => mockLocalDataSource.getCachedEarningsReports(tTicker),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getEarningsReports(tTicker),
      ).thenAnswer((_) async => tEarningsReports);
      when(
        () => mockLocalDataSource.cacheEarningsReports(tTicker, any()),
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
        () => mockLocalDataSource.getCachedEarningsReports(tTicker),
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
        () => mockLocalDataSource.getCachedEarningsReports(tTicker),
      ).thenThrow(Exception('Error'));

      // act
      final result = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(result.isLeft(), true);
    });
  });
}
