import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market/data/datasources/market_remote_datasource.dart';
import 'package:bizzie/features/market/data/dtos/market_data_snapshot.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/data/dtos/fmp_config.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockConfigService extends Mock implements IConfigService {}

class MockResponse extends Mock implements Response {}

class MockFmpConfig extends Mock implements FmpConfig {}

void main() {
  late MarketRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late MockConfigService mockConfigService;
  late MockFmpConfig mockFmpConfig;

  setUp(() {
    mockDio = MockDio();
    mockConfigService = MockConfigService();
    mockFmpConfig = MockFmpConfig();

    when(() => mockConfigService.fmpConfig).thenReturn(mockFmpConfig);
    when(() => mockFmpConfig.baseUrl).thenReturn('https://api.example.com');

    dataSource = MarketRemoteDataSourceImpl(mockDio, mockConfigService);
  });

  const tDateString = '2026-02-07';
  final tDate = DateTime(2026, 2, 7);

  final tPeList = [
    {
      'date': tDateString,
      'sector': 'Technology',
      'exchange': 'NASDAQ',
      'pe': 25.5,
    },
  ];

  final tPerformanceList = [
    {
      'date': tDateString,
      'sector': 'Technology',
      'exchange': 'NASDAQ',
      'averageChange': 1.5,
    },
  ];

  void setUpMockDioSuccess(String date) {
    final responsePe = MockResponse();
    final responsePerf = MockResponse();

    when(() => responsePe.data).thenReturn(tPeList);
    when(() => responsePerf.data).thenReturn(tPerformanceList);

    when(
      () => mockDio.get(
        any(that: contains('sector-pe-snapshot')),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      final queryParams =
          invocation.namedArguments[const Symbol('queryParameters')]
              as Map<String, dynamic>;
      if (queryParams['date'] == date) {
        return responsePe;
      }
      final emptyResponse = MockResponse();
      when(() => emptyResponse.data).thenReturn([]);
      return emptyResponse;
    });

    when(
      () => mockDio.get(
        any(that: contains('sector-performance-snapshot')),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      final queryParams =
          invocation.namedArguments[const Symbol('queryParameters')]
              as Map<String, dynamic>;
      if (queryParams['date'] == date) {
        return responsePerf;
      }
      final emptyResponse = MockResponse();
      when(() => emptyResponse.data).thenReturn([]);
      return emptyResponse;
    });
  }

  void setUpMockDioEmpty() {
    final emptyResponse = MockResponse();
    when(() => emptyResponse.data).thenReturn([]);

    when(
      () => mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => emptyResponse);
  }

  group('getMarketDataSnapshot', () {
    test(
      'getMarketDataSnapshot_success_returnsSnapshotForRequestedDate',
      () async {
        // arrange
        setUpMockDioSuccess(tDateString);

        // act
        final result = await dataSource.getMarketDataSnapshot(tDate);

        // assert
        expect(result, isA<MarketDataSnapshot>());
        expect(result.date, tDateString);
        expect(result.peList.length, 1);
        expect(result.performanceList.length, 1);
      },
    );

    test(
      'getMarketDataSnapshot_marketClosure_recursesAndReturnsPreviousDayData',
      () async {
        // arrange
        final previousDay = tDate.subtract(const Duration(days: 1));
        final previousDayString = BizzieDateFormatter.formatApiDate(
          previousDay,
        );
        setUpMockDioSuccess(previousDayString);

        // act
        final result = await dataSource.getMarketDataSnapshot(tDate);

        // assert
        expect(result.date, previousDayString);
        verify(
          () => mockDio.get(any(), queryParameters: {'date': tDateString}),
        );
        verify(
          () =>
              mockDio.get(any(), queryParameters: {'date': previousDayString}),
        );
      },
    );

    test('getMarketDataSnapshot_maxRetries_throwsServerFailure', () async {
      // arrange
      setUpMockDioEmpty();

      // act
      final call = dataSource.getMarketDataSnapshot;

      // assert
      await expectLater(() => call(tDate), throwsA(isA<ServerFailure>()));
      verify(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).called(10);
    });

    test('getMarketDataSnapshot_networkError_rethrowsException', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      // act
      final call = dataSource.getMarketDataSnapshot;

      // assert
      await expectLater(() => call(tDate), throwsA(isA<DioException>()));
    });
  });
}
