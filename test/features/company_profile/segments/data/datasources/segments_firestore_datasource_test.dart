import 'package:bizzie/core/data/models/cache_result.dart' as cache;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/features/company_profile/segments/data/datasources/segments_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTimeProvider extends Mock implements ITimeProvider {}

const tTicker = 'AAPL';

const tDto = RevenueSegmentationDto(
  symbol: tTicker,
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: 'USD',
  date: '2025-09-27',
  data: {'iPhone': 209586000000.0},
);

// UTC-constructed weekday afternoon so the smart-cache arithmetic is
// timezone-independent (2026-07-08 is a Wednesday).
final tNowEt = DateTime.utc(2026, 7, 8, 14, 0);

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late MockTimeProvider mockTimeProvider;
  late SegmentsFirestoreDataSourceImpl dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockTimeProvider = MockTimeProvider();
    when(() => mockTimeProvider.nowEt).thenReturn(tNowEt);
    dataSource = SegmentsFirestoreDataSourceImpl(
      FirestoreService(fakeFirestore),
      mockTimeProvider,
    );
  });

  Future<void> flushAsyncCacheWrite() =>
      Future<void>.delayed(Duration.zero);

  group('SegmentsFirestoreDataSourceImpl', () {
    group('syncProductSegmentation', () {
      test(
        'syncProductSegmentation_cacheMiss_fetchesRemoteAndPersistsToExpectedDoc',
        () async {
          // arrange
          var remoteCalls = 0;
          Future<List<RevenueSegmentationDto>> remoteFetcher() async {
            remoteCalls++;
            return [tDto];
          }

          // act
          final result = await dataSource.syncProductSegmentation(
            tTicker,
            period: SegmentPeriod.annual,
            remoteFetcher: remoteFetcher,
          );
          await flushAsyncCacheWrite();

          // assert
          expect(remoteCalls, 1);
          expect(
            result,
            isA<cache.CacheSuccess<List<RevenueSegmentationDto>>>()
                .having((r) => r.data, 'data', [tDto])
                .having((r) => r.origin, 'origin', CompanyProfileDataOrigin.api),
          );
          final doc = await fakeFirestore
              .collection('companies')
              .doc(tTicker)
              .collection('financials')
              .doc('revenue_product_seg_annual')
              .get();
          expect(doc.exists, isTrue);
        },
      );

      test(
        'syncProductSegmentation_freshCache_returnsCachedWithoutRemoteFetch',
        () async {
          // arrange
          var remoteCalls = 0;
          Future<List<RevenueSegmentationDto>> remoteFetcher() async {
            remoteCalls++;
            return [tDto];
          }

          await dataSource.syncProductSegmentation(
            tTicker,
            period: SegmentPeriod.annual,
            remoteFetcher: remoteFetcher,
          );
          await flushAsyncCacheWrite();

          // act
          final result = await dataSource.syncProductSegmentation(
            tTicker,
            period: SegmentPeriod.annual,
            remoteFetcher: remoteFetcher,
          );

          // assert
          expect(remoteCalls, 1);
          expect(
            result,
            isA<cache.CacheSuccess<List<RevenueSegmentationDto>>>().having(
              (r) => r.data,
              'data',
              [tDto],
            ),
          );
        },
      );

      test(
        'syncProductSegmentation_remoteThrowsWithoutCache_returnsCacheFailure',
        () async {
          // arrange
          Future<List<RevenueSegmentationDto>> remoteFetcher() async {
            throw Exception('network down');
          }

          // act
          final result = await dataSource.syncProductSegmentation(
            tTicker,
            period: SegmentPeriod.annual,
            remoteFetcher: remoteFetcher,
          );

          // assert
          expect(
            result,
            isA<cache.CacheFailure<List<RevenueSegmentationDto>>>(),
          );
        },
      );
    });

    group('syncGeographicSegmentation', () {
      test(
        'syncGeographicSegmentation_cacheMiss_persistsToGeographicQuarterDoc',
        () async {
          // arrange
          Future<List<RevenueSegmentationDto>> remoteFetcher() async => [tDto];

          // act
          final result = await dataSource.syncGeographicSegmentation(
            tTicker,
            period: SegmentPeriod.quarter,
            remoteFetcher: remoteFetcher,
          );
          await flushAsyncCacheWrite();

          // assert
          expect(
            result,
            isA<cache.CacheSuccess<List<RevenueSegmentationDto>>>().having(
              (r) => r.origin,
              'origin',
              CompanyProfileDataOrigin.api,
            ),
          );
          final doc = await fakeFirestore
              .collection('companies')
              .doc(tTicker)
              .collection('financials')
              .doc('revenue_geographic_seg_quarter')
              .get();
          expect(doc.exists, isTrue);
        },
      );

      test(
        'syncGeographicSegmentation_remoteThrowsWithoutCache_returnsCacheFailure',
        () async {
          // arrange
          Future<List<RevenueSegmentationDto>> remoteFetcher() async {
            throw Exception('network down');
          }

          // act
          final result = await dataSource.syncGeographicSegmentation(
            tTicker,
            period: SegmentPeriod.quarter,
            remoteFetcher: remoteFetcher,
          );

          // assert
          expect(
            result,
            isA<cache.CacheFailure<List<RevenueSegmentationDto>>>(),
          );
        },
      );
    });
  });
}
