import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/subscription/data/dtos/sync_subscription_response_dto.dart';
import 'package:bizzie/services/firebase_functions_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult<T> extends Mock
    implements HttpsCallableResult<T> {}

void main() {
  late FirebaseFunctionsService service;
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;

  setUp(() {
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    service = FirebaseFunctionsService(mockFunctions);
  });

  group('FirebaseFunctionsService', () {
    const tFunctionName = 'syncUserSubscription';
    const tData = {'active': true, 'status': 'active'};
    final tResponse = SyncSubscriptionResponseDto.fromJson(tData);

    group('syncUserSubscription', () {
      test(
        'syncUserSubscription_success_returnsSyncSubscriptionResponseDto',
        () async {
          // arrange
          final mockResult = MockHttpsCallableResult<Map<String, dynamic>>();
          when(() => mockResult.data).thenReturn(tData);
          when(
            () => mockFunctions.httpsCallable(
              any(),
              options: any(named: 'options'),
            ),
          ).thenReturn(mockCallable);
          when(
            () => mockCallable.call<Map<String, dynamic>>(),
          ).thenAnswer((_) async => mockResult);

          // act
          final result = await service.syncUserSubscription();

          // assert
          expect(result, equals(tResponse));
          verify(
            () => mockFunctions.httpsCallable(
              tFunctionName,
              options: any(
                named: 'options',
                that: isA<HttpsCallableOptions>().having(
                  (o) => o.timeout,
                  'timeout',
                  const Duration(seconds: 30),
                ),
              ),
            ),
          ).called(1);
          verify(() => mockCallable.call<Map<String, dynamic>>()).called(1);
        },
      );

      test(
        'syncUserSubscription_firebaseFunctionsException_throwsServerException',
        () async {
          // arrange
          when(
            () => mockFunctions.httpsCallable(
              any(),
              options: any(named: 'options'),
            ),
          ).thenReturn(mockCallable);
          when(() => mockCallable.call<Map<String, dynamic>>()).thenThrow(
            FirebaseFunctionsException(message: 'test error', code: 'internal'),
          );

          // act
          Future<void> call() => service.syncUserSubscription();

          // assert
          expect(
            call,
            throwsA(
              isA<ServerException>().having(
                (e) => e.message,
                'message',
                'test error',
              ),
            ),
          );
        },
      );

      test(
        'syncUserSubscription_unexpectedError_throwsServerException',
        () async {
          // arrange
          when(
            () => mockFunctions.httpsCallable(
              any(),
              options: any(named: 'options'),
            ),
          ).thenReturn(mockCallable);
          when(
            () => mockCallable.call<Map<String, dynamic>>(),
          ).thenThrow(Exception('unexpected'));

          // act
          Future<void> call() => service.syncUserSubscription();

          // assert
          expect(
            call,
            throwsA(
              isA<ServerException>().having(
                (e) => e.message,
                'message',
                contains('unexpected'),
              ),
            ),
          );
        },
      );
    });
  });
}
