import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/dtos/fmp_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockConfigService extends Mock implements ConfigService {}

class MockFmpConfig extends Mock implements FmpConfig {}

void main() {
  late CompanyRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late MockConfigService mockConfigService;
  late MockFmpConfig mockFmpConfig;

  setUp(() {
    mockDio = MockDio();
    mockConfigService = MockConfigService();
    mockFmpConfig = MockFmpConfig();

    when(() => mockConfigService.fmpConfig).thenReturn(mockFmpConfig);
    when(() => mockFmpConfig.baseUrl).thenReturn('https://api.test.com');
    when(() => mockFmpConfig.v3Url).thenReturn('https://api.test.com/v3');

    dataSource = CompanyRemoteDataSourceImpl(mockDio, mockConfigService);
  });

  const tTicker = 'AAPL';
  final tProfileJson = {
    'symbol': 'AAPL',
    'price': 150.0,
    'beta': 1.2,
    'marketCap': 2000000000.0,
    'companyName': 'Apple Inc.',
    'currency': 'USD',
    'exchange': 'NASDAQ',
    'exchangeShortName': 'NASDAQ',
    'industry': 'Technology',
    'website': 'https://apple.com',
    'description': 'Tech company',
    'ceo': 'Tim Cook',
    'sector': 'Technology',
    'country': 'US',
    'fullTimeEmployees': '100000',
    'phone': '1-800-APPLE',
    'address': '1 Apple Park Way',
    'city': 'Cupertino',
    'state': 'CA',
    'zip': '95014',
    'image': 'https://example.com/image.png',
    'ipoDate': '1980-12-12',
    'isEtf': false,
    'isActivelyTrading': true,
  };

  group('CompanyRemoteDataSource - Profile', () {
    test('getProfile_serverReturns200_returnsProfileList', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: [tProfileJson],
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // act
      final result = await dataSource.getProfile(tTicker);

      // assert
      expect(result, isA<List<ProfileDto>>());
      expect(result.first.symbol, 'AAPL');
      verify(
        () => mockDio.get(
          'https://api.test.com/profile',
          queryParameters: {'symbol': 'AAPL'},
        ),
      ).called(1);
    });

    test('getProfile_serverReturnsError_throwsDioException', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      // act & assert
      expect(
        () => dataSource.getProfile(tTicker),
        throwsA(isA<DioException>()),
      );
    });
  });
}
