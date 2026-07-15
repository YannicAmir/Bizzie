import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/data/interfaces/i_segments_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/segments/data/interfaces/i_segments_remote_datasource.dart';
import 'package:bizzie/features/company_profile/segments/data/repositories/segments_repository_impl.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSegmentsRemoteDataSource extends Mock
    implements ISegmentsRemoteDataSource {}

class MockSegmentsFirestoreDataSource extends Mock
    implements ISegmentsFirestoreDataSource {}

class MockExchangeRateRepository extends Mock
    implements IExchangeRateRepository {}

const tTicker = 'AAPL';

const tAnnualDto2023 = RevenueSegmentationDto(
  symbol: tTicker,
  fiscalYear: 2023,
  period: 'FY',
  reportedCurrency: 'EUR',
  date: '2023-12-31',
  data: {'iPhone': 100.0},
);

const tAnnualDto2022 = RevenueSegmentationDto(
  symbol: tTicker,
  fiscalYear: 2022,
  period: 'FY',
  reportedCurrency: 'EUR',
  date: '2022-12-31',
  data: {'iPhone': 80.0},
);

const tQuarterDto = RevenueSegmentationDto(
  symbol: tTicker,
  fiscalYear: 2024,
  period: 'Q1',
  reportedCurrency: 'EUR',
  date: '2024-03-31',
  data: {'iPhone': 50.0},
);

const tNoDateDto = RevenueSegmentationDto(
  symbol: tTicker,
  fiscalYear: 2023,
  period: 'FY',
  reportedCurrency: 'EUR',
  data: {'iPhone': 10.0},
);

const tConversion = (multiplier: 2.0, targetCurrency: 'USD');

const tAnnualSegment2023 = RevenueSegment(
  date: '2023-12-31',
  fiscalYear: 2023,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {'iPhone': 200.0},
);

const tAnnualSegment2022 = RevenueSegment(
  date: '2022-12-31',
  fiscalYear: 2022,
  period: 'FY',
  reportedCurrency: 'USD',
  data: {'iPhone': 160.0},
);

const tQuarterSegment = RevenueSegment(
  date: '2024-03-31',
  fiscalYear: 2024,
  period: 'Q1',
  reportedCurrency: 'USD',
  data: {'iPhone': 100.0},
);

const tSyncFailure = Failure.cache('sync failed');
const tExchangeFailure = Failure.server('exchange rate unavailable');

void main() {
  late SegmentsRepositoryImpl repository;
  late MockSegmentsRemoteDataSource mockRemoteDataSource;
  late MockSegmentsFirestoreDataSource mockLocalDataSource;
  late MockExchangeRateRepository mockExchangeRateRepository;

  setUpAll(() {
    registerFallbackValue(SegmentPeriod.annual);
  });

  setUp(() {
    mockRemoteDataSource = MockSegmentsRemoteDataSource();
    mockLocalDataSource = MockSegmentsFirestoreDataSource();
    mockExchangeRateRepository = MockExchangeRateRepository();
    repository = SegmentsRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockExchangeRateRepository,
    );
  });

  void stubProductSync(
    SegmentPeriod period,
    cache.CacheResult<List<RevenueSegmentationDto>> result,
  ) {
    when(
      () => mockLocalDataSource.syncProductSegmentation(
        tTicker,
        period: period,
        remoteFetcher: any(named: 'remoteFetcher'),
      ),
    ).thenAnswer((_) async => result);
  }

  void stubGeographicSync(
    SegmentPeriod period,
    cache.CacheResult<List<RevenueSegmentationDto>> result,
  ) {
    when(
      () => mockLocalDataSource.syncGeographicSegmentation(
        tTicker,
        period: period,
        remoteFetcher: any(named: 'remoteFetcher'),
      ),
    ).thenAnswer((_) async => result);
  }

  void stubExchangeRate(
    Either<
      Failure,
      (({double multiplier, String targetCurrency}), CompanyProfileDataOrigin)
    >
    result,
  ) {
    when(
      () => mockExchangeRateRepository.getMultiplier(
        reportedCurrency: any(named: 'reportedCurrency'),
        ticker: any(named: 'ticker'),
      ),
    ).thenAnswer((_) async => result);
  }

  group('SegmentsRepositoryImpl', () {
    group('getProductSegments', () {
      test(
        'getProductSegments_bothPeriodsSucceed_returnsRightWithConvertedSortedSegments',
        () async {
          // arrange
          stubProductSync(
            SegmentPeriod.annual,
            const cache.CacheSuccess(
              [tAnnualDto2022, tAnnualDto2023, tNoDateDto],
              CompanyProfileDataOrigin.api,
            ),
          );
          stubProductSync(
            SegmentPeriod.quarter,
            const cache.CacheSuccess(
              [tQuarterDto],
              CompanyProfileDataOrigin.cache,
            ),
          );
          stubExchangeRate(
            right((tConversion, CompanyProfileDataOrigin.cache)),
          );

          // act
          final result = await repository.getProductSegments(tTicker);

          // assert
          expect(
            result,
            right((
              const RevenueProductSegments(
                symbol: tTicker,
                reportedCurrency: 'USD',
                annual: [tAnnualSegment2023, tAnnualSegment2022],
                quarterly: [tQuarterSegment],
              ),
              CompanyProfileDataOrigin.api,
            )),
          );
          verify(
            () => mockExchangeRateRepository.getMultiplier(
              reportedCurrency: 'EUR',
              ticker: tTicker,
            ),
          ).called(1);
        },
      );

      test(
        'getProductSegments_bothPeriodsNotFound_returnsRightWithEmptySegmentsAndCacheOrigin',
        () async {
          // arrange
          stubProductSync(SegmentPeriod.annual, const cache.CacheNotFound());
          stubProductSync(SegmentPeriod.quarter, const cache.CacheNotFound());
          stubExchangeRate(
            right((tConversion, CompanyProfileDataOrigin.cache)),
          );

          // act
          final result = await repository.getProductSegments(tTicker);

          // assert
          expect(
            result,
            right((
              const RevenueProductSegments(
                symbol: tTicker,
                reportedCurrency: 'USD',
                annual: [],
                quarterly: [],
              ),
              CompanyProfileDataOrigin.cache,
            )),
          );
          verify(
            () => mockExchangeRateRepository.getMultiplier(
              reportedCurrency: null,
              ticker: tTicker,
            ),
          ).called(1);
        },
      );

      test(
        'getProductSegments_originsIncludeDbWithoutApi_returnsDbOrigin',
        () async {
          // arrange
          stubProductSync(
            SegmentPeriod.annual,
            const cache.CacheSuccess(
              [tAnnualDto2023],
              CompanyProfileDataOrigin.cache,
            ),
          );
          stubProductSync(
            SegmentPeriod.quarter,
            const cache.CacheSuccess(
              [tQuarterDto],
              CompanyProfileDataOrigin.db,
            ),
          );
          stubExchangeRate(
            right((tConversion, CompanyProfileDataOrigin.cache)),
          );

          // act
          final result = await repository.getProductSegments(tTicker);

          // assert
          expect(
            result,
            right((
              const RevenueProductSegments(
                symbol: tTicker,
                reportedCurrency: 'USD',
                annual: [tAnnualSegment2023],
                quarterly: [tQuarterSegment],
              ),
              CompanyProfileDataOrigin.db,
            )),
          );
        },
      );

      test('getProductSegments_annualSyncFails_returnsLeftFailure', () async {
        // arrange
        stubProductSync(SegmentPeriod.annual, const cache.CacheFailure(tSyncFailure));

        // act
        final result = await repository.getProductSegments(tTicker);

        // assert
        expect(result, left(tSyncFailure));
      });

      test(
        'getProductSegments_exchangeRateFails_returnsLeftFailure',
        () async {
          // arrange
          stubProductSync(
            SegmentPeriod.annual,
            const cache.CacheSuccess(
              [tAnnualDto2023],
              CompanyProfileDataOrigin.api,
            ),
          );
          stubProductSync(
            SegmentPeriod.quarter,
            const cache.CacheSuccess(
              [tQuarterDto],
              CompanyProfileDataOrigin.api,
            ),
          );
          stubExchangeRate(left(tExchangeFailure));

          // act
          final result = await repository.getProductSegments(tTicker);

          // assert
          expect(result, left(tExchangeFailure));
        },
      );

      test(
        'getProductSegments_localDataSourceThrows_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.syncProductSegmentation(
              tTicker,
              period: any(named: 'period'),
              remoteFetcher: any(named: 'remoteFetcher'),
            ),
          ).thenThrow(Exception('boom'));

          // act
          final result = await repository.getProductSegments(tTicker);

          // assert
          expect(result, left(const Failure.server('Exception: boom')));
        },
      );
    });

    group('getGeographicSegments', () {
      test(
        'getGeographicSegments_bothPeriodsSucceed_returnsRightWithConvertedSegments',
        () async {
          // arrange
          stubGeographicSync(
            SegmentPeriod.annual,
            const cache.CacheSuccess(
              [tAnnualDto2022, tAnnualDto2023, tNoDateDto],
              CompanyProfileDataOrigin.api,
            ),
          );
          stubGeographicSync(
            SegmentPeriod.quarter,
            const cache.CacheSuccess(
              [tQuarterDto],
              CompanyProfileDataOrigin.cache,
            ),
          );
          stubExchangeRate(
            right((tConversion, CompanyProfileDataOrigin.cache)),
          );

          // act
          final result = await repository.getGeographicSegments(tTicker);

          // assert
          expect(
            result,
            right((
              const RevenueGeographicSegments(
                symbol: tTicker,
                reportedCurrency: 'USD',
                annual: [tAnnualSegment2023, tAnnualSegment2022],
                quarterly: [tQuarterSegment],
              ),
              CompanyProfileDataOrigin.api,
            )),
          );
        },
      );

      test(
        'getGeographicSegments_quarterlySyncFails_returnsLeftFailure',
        () async {
          // arrange
          stubGeographicSync(
            SegmentPeriod.annual,
            const cache.CacheSuccess(
              [tAnnualDto2023],
              CompanyProfileDataOrigin.api,
            ),
          );
          stubGeographicSync(
            SegmentPeriod.quarter,
            const cache.CacheFailure(tSyncFailure),
          );

          // act
          final result = await repository.getGeographicSegments(tTicker);

          // assert
          expect(result, left(tSyncFailure));
        },
      );

      test(
        'getGeographicSegments_localDataSourceThrows_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.syncGeographicSegmentation(
              tTicker,
              period: any(named: 'period'),
              remoteFetcher: any(named: 'remoteFetcher'),
            ),
          ).thenThrow(Exception('boom'));

          // act
          final result = await repository.getGeographicSegments(tTicker);

          // assert
          expect(result, left(const Failure.server('Exception: boom')));
        },
      );
    });
  });
}
