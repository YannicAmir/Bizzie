import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/interfaces/i_bizzie_chat_repository.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:bizzie/features/bizzie_chat/domain/usecases/get_sessions_stream_usecase.dart';

class MockIBizzieChatRepository extends Mock implements IBizzieChatRepository {}

const tUid = 'user_123';

void main() {
  late GetSessionsStreamUseCase sut;
  late MockIBizzieChatRepository mockRepository;

  final tCreatedAt = DateTime(2024, 1, 1);
  final tUpdatedAt = DateTime(2024, 1, 2);
  late ChatSession tSession;
  late List<ChatSession> tSessions;

  setUp(() {
    mockRepository = MockIBizzieChatRepository();
    sut = GetSessionsStreamUseCase(mockRepository);

    tSession = ChatSession(
      id: 's1',
      title: 'Test Session',
      ticker: 'AAPL',
      companyName: 'Apple Inc.',
      createdAt: tCreatedAt,
      updatedAt: tUpdatedAt,
      messageCount: 3,
    );
    tSessions = [tSession];
  });

  group('GetSessionsStreamUseCase', () {
    group('call', () {
      test(
        'call_repositoryEmitsSessions_returnsStreamOfRightSessions',
        () async {
          // arrange
          when(
            () => mockRepository.getSessionsStream(any()),
          ).thenAnswer((_) => Stream.value(Right(tSessions)));

          // act
          final resultStream = await sut(tUid);

          // assert
          await expectLater(resultStream, emits(Right(tSessions)));
          verify(() => mockRepository.getSessionsStream(tUid)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );

      test(
        'call_repositoryStreamEmitsLeftFailure_returnsStreamOfLeftFailure',
        () async {
          // arrange
          final tFailure = Failure.server('Firestore error');
          when(
            () => mockRepository.getSessionsStream(any()),
          ).thenAnswer((_) => Stream.value(Left(tFailure)));

          // act
          final resultStream = await sut(tUid);

          // assert
          await expectLater(resultStream, emits(Left(tFailure)));
          verify(() => mockRepository.getSessionsStream(tUid)).called(1);
          verifyNoMoreInteractions(mockRepository);
        },
      );
    });
  });
}
