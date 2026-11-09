import 'package:bizzie/features/company_profile/financial_statements/data/datasources/frankfurter_remote_data_source_impl.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/frankfurter_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late FrankfurterRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = FrankfurterRemoteDataSourceImpl(mockDio);
  });

  void stubResponse(List<dynamic> data) {
    when(
      () => mockDio.get<List<dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer(
      (_) async => Response<List<dynamic>>(
        data: data,
        requestOptions: RequestOptions(path: '/rates'),
      ),
    );
  }

  group('getExchangeRate', () {
    test('getExchangeRate_success_requestsRatesAndParsesResponse', () async {
      // arrange
      stubResponse([
        {'date': '2026-11-05', 'base': 'USD', 'quote': 'TWD', 'rate': 32.85},
      ]);

      // act
      final result = await dataSource.getExchangeRate(
        base: 'USD',
        target: 'TWD',
        date: '2026-11-05',
      );

      // assert
      expect(result, const [
        FrankfurterResponseDto(
          date: '2026-11-05',
          base: 'USD',
          quote: 'TWD',
          rate: 32.85,
        ),
      ]);
      verify(
        () => mockDio.get<List<dynamic>>(
          '/rates',
          queryParameters: {
            'date': '2026-11-05',
            'base': 'USD',
            'quotes': 'TWD',
          },
        ),
      ).called(1);
    });

    test('getExchangeRate_integerRate_parsesAsDouble', () async {
      // arrange
      stubResponse([
        {'date': '2026-11-05', 'base': 'USD', 'quote': 'KWD', 'rate': 1},
      ]);

      // act
      final result = await dataSource.getExchangeRate(
        base: 'USD',
        target: 'KWD',
        date: '2026-11-05',
      );

      // assert
      expect(result.single.rate, 1.0);
    });

    test('getExchangeRate_emptyResponse_returnsEmptyList', () async {
      // arrange
      stubResponse([]);

      // act
      final result = await dataSource.getExchangeRate(
        base: 'USD',
        target: 'TWD',
        date: '2026-11-05',
      );

      // assert
      expect(result, isEmpty);
    });
  });
}
