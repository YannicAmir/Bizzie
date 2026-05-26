import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/send_message_params.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/send_message_stream_usecase.dart';

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

void main() {
  late SendMessageStreamUseCase sut;
  late MockIBizzieChatRepository mockRepository;

  setUp(() {
    mockRepository = MockIBizzieChatRepository();
    sut = SendMessageStreamUseCase(mockRepository);
  });

  group('SendMessageStreamUseCase', () {
    group('call', () {
      test(
        'call_repositoryEmitsTokenEvent_returnsStreamOfRightTokenEvent',
        () async {
          // arrange
          when(
            () => mockRepository.sendMessageStream(
              idempotencyKey: any(named: 'idempotencyKey'),
              query: any(named: 'query'),
              companyTicker: any(named: 'companyTicker'),
              companyName: any(named: 'companyName'),
              sessionId: any(named: 'sessionId'),
            ),
          ).thenAnswer(
            (_) => Stream.value(
              const Right(ChatSseEvent.token(token: 'Apple revenue...')),
            ),
          );

          // act
          final resultStream = await sut(tParams);

          // assert
          await expectLater(
            resultStream,
            emits(const Right(ChatSseEvent.token(token: 'Apple revenue...'))),
          );
          verify(
            () => mockRepository.sendMessageStream(
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
        'call_repositoryStreamEmitsLeftFailure_returnsStreamOfLeftFailure',
        () async {
          // arrange
          final tFailure = Failure.server('stream error');
          when(
            () => mockRepository.sendMessageStream(
              idempotencyKey: any(named: 'idempotencyKey'),
              query: any(named: 'query'),
              companyTicker: any(named: 'companyTicker'),
              companyName: any(named: 'companyName'),
              sessionId: any(named: 'sessionId'),
            ),
          ).thenAnswer((_) => Stream.value(Left(tFailure)));

          // act
          final resultStream = await sut(tParams);

          // assert
          await expectLater(resultStream, emits(Left(tFailure)));
          verify(
            () => mockRepository.sendMessageStream(
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
