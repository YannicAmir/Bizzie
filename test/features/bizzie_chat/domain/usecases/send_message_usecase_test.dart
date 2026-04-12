import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_response.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/send_message_params.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/send_message_usecase.dart';

class MockIBizzieChatRepository extends Mock implements IBizzieChatRepository {}

const tIdempotencyKey = 'idem_789';
const tQuery = 'What is AAPL?';
const tTicker = 'AAPL';
const tCompanyName = 'Apple Inc.';
const tSessionId = 'session_456';

const tParams = SendMessageParams(
  idempotencyKey: tIdempotencyKey,
  query: tQuery,
  companyTicker: tTicker,
  companyName: tCompanyName,
  sessionId: tSessionId,
);

const tResponse = ChatResponse(
  message: 'Hello',
  followUps: ['What else?'],
  sessionId: tSessionId,
);

void main() {
  late SendMessageUseCase sut;
  late MockIBizzieChatRepository mockRepository;

  setUp(() {
    mockRepository = MockIBizzieChatRepository();
    sut = SendMessageUseCase(mockRepository);
  });

  group('SendMessageUseCase', () {
    group('call', () {
      test(
        'call_repositoryReturnsRight_returnsRightChatResponse',
        () async {
          // arrange
          when(
            () => mockRepository.sendMessage(
              idempotencyKey: any(named: 'idempotencyKey'),
              query: any(named: 'query'),
              companyTicker: any(named: 'companyTicker'),
              companyName: any(named: 'companyName'),
              sessionId: any(named: 'sessionId'),
            ),
          ).thenAnswer((_) async => const Right(tResponse));

          // act
          final result = await sut(tParams);

          // assert
          expect(result, const Right(tResponse));
          verify(
            () => mockRepository.sendMessage(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'call_repositoryReturnsLeft_returnsLeftFailure',
        () async {
          // arrange
          final tFailure = Failure.server('server error');
          when(
            () => mockRepository.sendMessage(
              idempotencyKey: any(named: 'idempotencyKey'),
              query: any(named: 'query'),
              companyTicker: any(named: 'companyTicker'),
              companyName: any(named: 'companyName'),
              sessionId: any(named: 'sessionId'),
            ),
          ).thenAnswer((_) async => Left(tFailure));

          // act
          final result = await sut(tParams);

          // assert
          expect(result, Left(tFailure));
          verify(
            () => mockRepository.sendMessage(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    });
  });
}
