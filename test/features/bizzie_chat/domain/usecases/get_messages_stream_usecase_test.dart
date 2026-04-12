import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_messages_params.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/get_messages_stream_usecase.dart';

class MockIBizzieChatRepository extends Mock implements IBizzieChatRepository {}

const tUid = 'user_123';
const tSessionId = 'session_456';
const tParams = GetMessagesParams(uid: tUid, sessionId: tSessionId);

void main() {
  late GetMessagesStreamUseCase sut;
  late MockIBizzieChatRepository mockRepository;

  final tCreatedAt = DateTime(2024, 1, 1);
  late ChatMessage tMessage;
  late List<ChatMessage> tMessages;

  setUp(() {
    mockRepository = MockIBizzieChatRepository();
    sut = GetMessagesStreamUseCase(mockRepository);

    tMessage = ChatMessage(
      id: 'm1',
      role: 'user',
      content: 'What is AAPL?',
      createdAt: tCreatedAt,
    );
    tMessages = [tMessage];
  });

  group('GetMessagesStreamUseCase', () {
    group('call', () {
      test(
        'call_repositoryEmitsMessages_returnsStreamOfRightMessages',
        () async {
          // arrange
          when(
            () => mockRepository.getMessagesStream(any(), any()),
          ).thenAnswer((_) => Stream.value(Right(tMessages)));

          // act
          final resultStream = await sut(tParams);

          // assert
          await expectLater(resultStream, emits(Right(tMessages)));
          verify(
            () => mockRepository.getMessagesStream(tUid, tSessionId),
          ).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'call_repositoryStreamEmitsLeftFailure_returnsStreamOfLeftFailure',
        () async {
          // arrange
          final tFailure = Failure.server('Firestore error');
          when(
            () => mockRepository.getMessagesStream(any(), any()),
          ).thenAnswer((_) => Stream.value(Left(tFailure)));

          // act
          final resultStream = await sut(tParams);

          // assert
          await expectLater(resultStream, emits(Left(tFailure)));
          verify(
            () => mockRepository.getMessagesStream(tUid, tSessionId),
          ).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    });
  });
}
