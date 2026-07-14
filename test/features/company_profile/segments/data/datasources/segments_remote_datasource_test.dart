import 'package:bizzie/core/data/dtos/fmp_config.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/segments/data/datasources/segments_remote_datasource.dart';
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockConfigService extends Mock implements IConfigService {}

class MockFmpConfig extends Mock implements FmpConfig {}

class MockResponse extends Mock implements Response {}

const tBaseUrl = 'https://api.example.com/stable';

const tResponseJson = [
  {
    'symbol': 'AAPL',
    'fiscalYear': 2025,
    'period': 'FY',
    'reportedCurrency': 'USD',
    'date': '2025-09-27',
    'data': {'iPhone': 209586000000},
  },
];

const tDto = RevenueSegmentationDto(
  symbol: 'AAPL',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: 'USD',
  date: '2025-09-27',
  data: {'iPhone': 209586000000.0},
);

void main() {
  late SegmentsRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late MockConfigService mockConfigService;
  late MockFmpConfig mockFmpConfig;

  setUp(() {
    mockDio = MockDio();
    mockConfigService = MockConfigService();
    mockFmpConfig = MockFmpConfig();

    when(() => mockConfigService.fmpConfig).thenReturn(mockFmpConfig);
    // Trailing slash on purpose — the datasource must strip it.
    when(() => mockFmpConfig.baseUrl).thenReturn('$tBaseUrl/');

    dataSource = SegmentsRemoteDataSourceImpl(mockDio, mockConfigService);
  });

  void stubDioSuccess() {
    final response = MockResponse();
    when(() => response.data).thenReturn(tResponseJson);
    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => response);
  }

  group('SegmentsRemoteDataSourceImpl', () {
    group('getProductSegmentation', () {
      test(
        'getProductSegmentation_success_callsProductEndpointAndParsesDtos',
        () async {
          // arrange
          stubDioSuccess();

          // act
          final result = await dataSource.getProductSegmentation(
            'AAPL',
            period: SegmentPeriod.annual,
          );

          // assert
          expect(result, [tDto]);
          verify(
            () => mockDio.get(
              '$tBaseUrl/revenue-product-segmentation',
              queryParameters: {
                'symbol': 'AAPL',
                'period': 'annual',
                'structure': 'flat',
              },
            ),
          ).called(1);
        },
      );

      test(
        'getProductSegmentation_tickerWithDot_sanitizesSymbolParameter',
        () async {
          // arrange
          stubDioSuccess();

          // act
          await dataSource.getProductSegmentation(
            'BRK.B',
            period: SegmentPeriod.quarter,
          );

          // assert
          verify(
            () => mockDio.get(
              '$tBaseUrl/revenue-product-segmentation',
              queryParameters: {
                'symbol': 'BRK-B',
                'period': 'quarter',
                'structure': 'flat',
              },
            ),
          ).called(1);
        },
      );

      test('getProductSegmentation_dioThrows_rethrows', () async {
        // arrange
        final exception = DioException(
          requestOptions: RequestOptions(path: ''),
        );
        when(
          () =>
              mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
        ).thenThrow(exception);

        // act
        final call = dataSource.getProductSegmentation(
          'AAPL',
          period: SegmentPeriod.annual,
        );

        // assert
        await expectLater(call, throwsA(exception));
      });
    });

    group('getGeographicSegmentation', () {
      test(
        'getGeographicSegmentation_success_callsGeographicEndpointAndParsesDtos',
        () async {
          // arrange
          stubDioSuccess();

          // act
          final result = await dataSource.getGeographicSegmentation(
            'AAPL',
            period: SegmentPeriod.quarter,
          );

          // assert
          expect(result, [tDto]);
          verify(
            () => mockDio.get(
              '$tBaseUrl/revenue-geographic-segmentation',
              queryParameters: {
                'symbol': 'AAPL',
                'period': 'quarter',
                'structure': 'flat',
              },
            ),
          ).called(1);
        },
      );

      test('getGeographicSegmentation_dioThrows_rethrows', () async {
        // arrange
        final exception = DioException(
          requestOptions: RequestOptions(path: ''),
        );
        when(
          () =>
              mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
        ).thenThrow(exception);

        // act
        final call = dataSource.getGeographicSegmentation(
          'AAPL',
          period: SegmentPeriod.annual,
        );

        // assert
        await expectLater(call, throwsA(exception));
      });
    });
  });
}
