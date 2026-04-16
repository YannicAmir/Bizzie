import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_request_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_response_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_sse_event_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_message_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_session_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/interfaces/i_bizzie_chat_remote_datasource.dart';
import 'package:bizzie/features/bizzie_chat/data/repositories/bizzie_chat_repository_impl.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_response.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_sessions_params.dart';

class MockIBizzieChatRemoteDataSource extends Mock
    implements IBizzieChatRemoteDataSource {}

const tUid = 'user_123';
const tSessionId = 'session_456';
const tIdempotencyKey = 'idem_789';
const tQuery = 'What is AAPL?';
const tTicker = 'AAPL';
const tCompanyName = 'Apple Inc.';

DioException _makeDioException(
  int statusCode, {
  Map<String, dynamic>? data,
}) =>
    DioException(
      requestOptions: RequestOptions(path: '/bizzieChat'),
      response: Response<dynamic>(
        data: data,
        statusCode: statusCode,
        requestOptions: RequestOptions(path: '/bizzieChat'),
      ),
      type: DioExceptionType.badResponse,
    );

void main() {
  late BizzieChatRepositoryImpl sut;
  late MockIBizzieChatRemoteDataSource mockRemoteDataSource;

  final tCreatedAt = DateTime(2024, 1, 1);
  final tUpdatedAt = DateTime(2024, 1, 2);

  late BizzieChatResponseDto tResponseDto;
  late ChatSessionDto tSessionDto;
  late ChatSession tSession;
  late ChatMessageDto tMessageDto;
  late ChatMessage tMessage;

  setUpAll(() {
    registerFallbackValue(
      const BizzieChatRequestDto(
        idempotencyKey: '',
        query: '',
        companyTicker: '',
        companyName: '',
        sessionId: '',
      ),
    );
    registerFallbackValue(const GetSessionsParams(uid: '', ticker: ''));
  });

  setUp(() {
    mockRemoteDataSource = MockIBizzieChatRemoteDataSource();
    sut = BizzieChatRepositoryImpl(mockRemoteDataSource);

    tResponseDto = BizzieChatResponseDto(
      message: 'Hello',
      followUps: const ['What else?'],
      metadata: const BizzieChatResponseMetadataDto(sessionId: tSessionId),
    );

    tSessionDto = ChatSessionDto(
      id: 's1',
      title: 'Test Session',
      ticker: tTicker,
      companyName: tCompanyName,
      createdAt: tCreatedAt,
      updatedAt: tUpdatedAt,
      messageCount: 3,
    );
    tSession = ChatSession(
      id: 's1',
      title: 'Test Session',
      ticker: tTicker,
      companyName: tCompanyName,
      createdAt: tCreatedAt,
      updatedAt: tUpdatedAt,
      messageCount: 3,
    );

    tMessageDto = ChatMessageDto(
      id: 'm1',
      role: 'user',
      content: tQuery,
      createdAt: tCreatedAt,
    );
    tMessage = ChatMessage(
      id: 'm1',
      role: ChatMessageRole.user,
      content: tQuery,
      createdAt: tCreatedAt,
    );
  });

  group('BizzieChatRepositoryImpl', () {
    group('sendMessage', () {
      test(
        'sendMessage_datasourceSucceeds_returnsRightChatResponse',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessage(any()))
              .thenAnswer((_) async => tResponseDto);

          // act
          final result = await sut.sendMessage(
            idempotencyKey: tIdempotencyKey,
            query: tQuery,
            companyTicker: tTicker,
            companyName: tCompanyName,
            sessionId: tSessionId,
          );

          // assert
          expect(
            result,
            equals(
              const Right(
                ChatResponse(
                  message: 'Hello',
                  followUps: ['What else?'],
                  sessionId: tSessionId,
                ),
              ),
            ),
          );
          verify(() => mockRemoteDataSource.sendMessage(any())).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test(
        'sendMessage_dioException401_returnsLeftPermissionFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessage(any()))
              .thenThrow(_makeDioException(401));

          // act
          final result = await sut.sendMessage(
            idempotencyKey: tIdempotencyKey,
            query: tQuery,
            companyTicker: tTicker,
            companyName: tCompanyName,
            sessionId: tSessionId,
          );

          // assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (l) => expect(l, isA<PermissionFailure>()),
            (r) => fail('Expected Left'),
          );
        },
      );

      test(
        'sendMessage_dioException404_returnsLeftUserNotFoundFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessage(any()))
              .thenThrow(_makeDioException(404));

          // act
          final result = await sut.sendMessage(
            idempotencyKey: tIdempotencyKey,
            query: tQuery,
            companyTicker: tTicker,
            companyName: tCompanyName,
            sessionId: tSessionId,
          );

          // assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (l) => expect(l, isA<UserNotFoundFailure>()),
            (r) => fail('Expected Left'),
          );
        },
      );

      test(
        'sendMessage_dioException429_returnsLeftRateLimitFailureWithRetrySeconds',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessage(any()))
              .thenThrow(_makeDioException(429, data: {'retryAfterSeconds': 30}));

          // act
          final result = await sut.sendMessage(
            idempotencyKey: tIdempotencyKey,
            query: tQuery,
            companyTicker: tTicker,
            companyName: tCompanyName,
            sessionId: tSessionId,
          );

          // assert
          expect(
            result,
            equals(Left(Failure.rateLimit(retryAfterSeconds: 30))),
          );
        },
      );

      test(
        'sendMessage_genericException_returnsLeftServerFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessage(any()))
              .thenThrow(Exception('Network error'));

          // act
          final result = await sut.sendMessage(
            idempotencyKey: tIdempotencyKey,
            query: tQuery,
            companyTicker: tTicker,
            companyName: tCompanyName,
            sessionId: tSessionId,
          );

          // assert
          expect(
            result,
            equals(Left(Failure.server('Exception: Network error'))),
          );
        },
      );
    });

    group('sendMessageStream', () {
      test(
        'sendMessageStream_tokenEvent_yieldsRightChatTokenEvent',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessageStream(any()))
              .thenAnswer(
            (_) => Stream.value(const BizzieChatTokenEventDto(token: 'hello')),
          );

          // act + assert
          await expectLater(
            sut.sendMessageStream(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
            emits(Right(ChatSseEvent.token(token: 'hello'))),
          );
        },
      );

      test(
        'sendMessageStream_doneEvent_yieldsRightChatDoneEvent',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessageStream(any()))
              .thenAnswer(
            (_) => Stream.value(
              const BizzieChatDoneEventDto(
                followUps: ['What else?'],
                source: 'sec-filing',
                routePath: null,
              ),
            ),
          );

          // act + assert
          await expectLater(
            sut.sendMessageStream(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
            emits(
              Right(
                ChatSseEvent.done(
                  followUps: const ['What else?'],
                  source: 'sec-filing',
                ),
              ),
            ),
          );
        },
      );

      test(
        'sendMessageStream_errorSseEvent_yieldsLeftServerFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessageStream(any()))
              .thenAnswer(
            (_) => Stream.value(
              const BizzieChatErrorEventDto(message: 'AI error'),
            ),
          );

          // act + assert
          await expectLater(
            sut.sendMessageStream(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
            emits(Left(Failure.server('AI error'))),
          );
        },
      );

      test(
        'sendMessageStream_dioException429_yieldsLeftRateLimitFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessageStream(any()))
              .thenAnswer(
            (_) => Stream.error(
              _makeDioException(429, data: {'retryAfterSeconds': 60}),
            ),
          );

          // act + assert
          await expectLater(
            sut.sendMessageStream(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
            emits(Left(Failure.rateLimit(retryAfterSeconds: 60))),
          );
        },
      );

      test(
        'sendMessageStream_genericException_yieldsLeftServerFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.sendMessageStream(any()))
              .thenAnswer((_) => Stream.error(Exception('Unknown stream error')));

          // act + assert
          await expectLater(
            sut.sendMessageStream(
              idempotencyKey: tIdempotencyKey,
              query: tQuery,
              companyTicker: tTicker,
              companyName: tCompanyName,
              sessionId: tSessionId,
            ),
            emits(Left(Failure.server('Exception: Unknown stream error'))),
          );
        },
      );
    });

    group('getSessionsStream', () {
      test(
        'getSessionsStream_datasourceEmitsSessions_emitsRightListOfSessions',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getSessionsStream(any(), any()))
              .thenAnswer((_) => Stream.value([tSessionDto]));

          // act
          final result = sut.getSessionsStream(GetSessionsParams(uid: tUid, ticker: tTicker));
          final event = await result.first;

          // assert
          expect(event.isRight(), isTrue);
          event.fold(
            (l) => fail('Expected Right but got Left: $l'),
            (sessions) => expect(sessions, equals([tSession])),
          );
          verify(() => mockRemoteDataSource.getSessionsStream(tUid, tTicker)).called(1);
        },
      );

      test(
        'getSessionsStream_datasourceEmitsMultipleSessions_emitsSortedByUpdatedAtDescending',
        () async {
          // arrange
          final tOlderSession = ChatSessionDto(
            id: 's_older',
            title: 'Older Session',
            ticker: tTicker,
            companyName: tCompanyName,
            createdAt: tCreatedAt,
            updatedAt: DateTime(2024, 1, 1),
            messageCount: 1,
          );
          final tNewerSession = ChatSessionDto(
            id: 's_newer',
            title: 'Newer Session',
            ticker: tTicker,
            companyName: tCompanyName,
            createdAt: tCreatedAt,
            updatedAt: DateTime(2024, 1, 3),
            messageCount: 2,
          );
          when(() => mockRemoteDataSource.getSessionsStream(any(), any()))
              .thenAnswer((_) => Stream.value([tOlderSession, tNewerSession]));

          // act
          final result = sut.getSessionsStream(
            GetSessionsParams(uid: tUid, ticker: tTicker),
          );
          final event = await result.first;

          // assert
          expect(event.isRight(), isTrue);
          event.fold(
            (l) => fail('Expected Right but got Left: $l'),
            (sessions) {
              expect(sessions.length, 2);
              expect(sessions[0].id, equals('s_newer'));
              expect(sessions[1].id, equals('s_older'));
            },
          );
        },
      );

      test(
        'getSessionsStream_datasourceEmitsError_emitsLeftServerFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getSessionsStream(any(), any()))
              .thenAnswer((_) => Stream.error(Exception('Firestore error')));

          // act
          final result = sut.getSessionsStream(GetSessionsParams(uid: tUid, ticker: tTicker));
          final event = await result.first;

          // assert
          expect(
            event,
            equals(Left(Failure.server('Exception: Firestore error'))),
          );
        },
      );
    });

    group('getMessagesStream', () {
      test(
        'getMessagesStream_datasourceEmitsMessages_emitsRightListOfMessages',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getMessagesStream(any(), any()))
              .thenAnswer((_) => Stream.value([tMessageDto]));

          // act
          final result = sut.getMessagesStream(tUid, tSessionId);
          final event = await result.first;

          // assert
          expect(event.isRight(), isTrue);
          event.fold(
            (l) => fail('Expected Right but got Left: $l'),
            (messages) => expect(messages, equals([tMessage])),
          );
          verify(
            () => mockRemoteDataSource.getMessagesStream(tUid, tSessionId),
          ).called(1);
        },
      );

      test(
        'getMessagesStream_datasourceEmitsError_emitsLeftServerFailure',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getMessagesStream(any(), any()))
              .thenAnswer((_) => Stream.error(Exception('Firestore error')));

          // act
          final result = sut.getMessagesStream(tUid, tSessionId);
          final event = await result.first;

          // assert
          expect(
            event,
            equals(Left(Failure.server('Exception: Firestore error'))),
          );
        },
      );
    });
  });
}
