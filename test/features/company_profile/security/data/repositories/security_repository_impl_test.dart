import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_ttm_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/features/company_profile/security/data/repositories/security_repository_impl.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:bizzie/core/error/failures.dart';

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
    final tRatios = [
      const RatiosTtmDto(
        priceToEarningsRatioTTM: 22.5,
        priceToFreeCashFlowRatioTTM: 18.0,
      ),
    ];

    test('getSecurityDetails_success_returnsSecurityDetails', () async {
      // arrange
      when(() => mockCompanyRepository.getProfile(tTicker)).thenAnswer(
        (_) async => Right((tCompanyProfile, CompanyProfileDataOrigin.api)),
      );
      when(
        () => mockRatiosRemoteDataSource.getRatiosTtm(tTicker),
      ).thenAnswer((_) async => tRatios);

      // act
      final result = await repository.getSecurityDetails(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<SecurityDetails>());
        expect(origin, CompanyProfileDataOrigin.api);
        expect(r.ticker, tTicker);
        expect(r.peRatioTTM, 22.5);
        expect(r.priceToFreeCashFlowTTM, 18.0);
        expect(r.exchangeShortName, 'NASDAQ');
      });
    });

    test('getSecurityDetails_failure_returnsServerFailure', () async {
      // arrange
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
        () => mockSecurityLocalDataSource.syncEarningsReports(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async =>
            cache.CacheSuccess(tEarningsReports, CompanyProfileDataOrigin.api),
      );

      // act
      final resultData = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(resultData.isRight(), true);
      resultData.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, isA<DateTime>());
        expect(origin, CompanyProfileDataOrigin.api);
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
        () => mockSecurityLocalDataSource.syncEarningsReports(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async =>
            cache.CacheSuccess(tPastEarnings, CompanyProfileDataOrigin.cache),
      );

      // act
      final result = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (tuple) {
        final r = tuple.$1;
        final origin = tuple.$2;
        expect(r, null);
        expect(origin, CompanyProfileDataOrigin.cache); // Cached data
      });
    });

    test('getUpcomingEarningsDate_failure_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockSecurityLocalDataSource.syncEarningsReports(
          tTicker,
          remoteFetcher: any(named: 'remoteFetcher'),
        ),
      ).thenAnswer(
        (_) async => const cache.CacheFailure(Failure.server('error')),
      );

      // act
      final resultData = await repository.getUpcomingEarningsDate(tTicker);

      // assert
      expect(resultData.isLeft(), true);
    });
  });
}
