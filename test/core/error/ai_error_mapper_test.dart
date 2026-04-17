import 'package:bizzie/core/error/ai_error_mapper.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDioException extends Mock implements DioException {}

class MockResponse extends Mock implements Response<dynamic> {}

const tContext = 'test_context';

void main() {
  late MockDioException mockException;
  late MockResponse mockResponse;

  setUp(() {
    mockException = MockDioException();
    mockResponse = MockResponse();
  });

  group('AiErrorMapper', () {
    group('map', () {
      test('map_status400_returnsServerFailureWithValidMessageError', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(400);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(sut, const Failure.server('Error. Please enter a valid message.'));
      });

      test('map_status401_returnsServerFailureWithValidMessageError', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(401);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(sut, const Failure.server('Error. Please enter a valid message.'));
      });

      test('map_status403_returnsServerFailureWithValidMessageError', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(403);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(sut, const Failure.server('Error. Please enter a valid message.'));
      });

      test('map_status404_returnsServerFailureWithValidMessageError', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(404);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(sut, const Failure.server('Error. Please enter a valid message.'));
      });

      test('map_status429_returnsRateLimitFailureWithDailyLimitMessage', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(429);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(
          sut,
          const Failure.rateLimit(
            retryAfterSeconds: 0,
            message:
                'You have reached your message limit for today. Come back to Bizzie AI tomorrow.',
          ),
        );
      });

      test('map_status503_returnsServerFailureWithTroublesMessage', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(503);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(
          sut,
          const Failure.server(
            'Bizzie AI is having some troubles. Please try again later.',
          ),
        );
      });

      test('map_unknownStatus_returnsServerFailureWithGenericMessage', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(500);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(
          sut,
          const Failure.server(
            'Something went wrong generating a response. Please try again.',
          ),
        );
      });

      test('map_nullStatusCode_returnsServerFailureWithGenericMessage', () {
        // arrange
        when(() => mockException.response).thenReturn(mockResponse);
        when(() => mockResponse.statusCode).thenReturn(null);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(
          sut,
          const Failure.server(
            'Something went wrong generating a response. Please try again.',
          ),
        );
      });

      test('map_nullResponse_returnsServerFailureWithGenericMessage', () {
        // arrange
        when(() => mockException.response).thenReturn(null);

        // act
        final sut = AiErrorMapper.map(mockException, StackTrace.empty, tContext);

        // assert
        expect(
          sut,
          const Failure.server(
            'Something went wrong generating a response. Please try again.',
          ),
        );
      });
    });
  });
}
