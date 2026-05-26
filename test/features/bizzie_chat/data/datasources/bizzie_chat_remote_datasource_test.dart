import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/features/bizzie_chat/data/datasources/bizzie_chat_remote_datasource.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_request_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_message_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_session_dto.dart';
import 'package:bizzie/services/firestore_service.dart';

class MockDio extends Mock implements Dio {}

class MockFirestoreService extends Mock implements FirestoreService {}

const tUid = 'user_123';
const tSessionId = 'session_456';
const tTicker = 'AAPL';

const tRequest = BizzieChatRequestDto(
  idempotencyKey: 'idem_789',
  query: 'What is AAPL?',
  companyTicker: 'AAPL',
  companyName: 'Apple Inc.',
  sessionId: tSessionId,
);

void main() {
  late BizzieChatRemoteDataSource sut;
  late MockDio mockDio;
  late MockFirestoreService mockFirestoreService;

  final tCreatedAt = DateTime(2024, 1, 1);
  final tUpdatedAt = DateTime(2024, 1, 2);

  late ChatSessionDto tSessionDto;
  late ChatMessageDto tMessageDto;

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
  });

  setUp(() {
    mockDio = MockDio();
    mockFirestoreService = MockFirestoreService();
    sut = BizzieChatRemoteDataSource(mockDio, mockFirestoreService);

    tSessionDto = ChatSessionDto(
      id: 's1',
      title: 'Test Session',
      ticker: 'AAPL',
      companyName: 'Apple Inc.',
      createdAt: tCreatedAt,
      updatedAt: tUpdatedAt,
      messageCount: 3,
    );
    tMessageDto = ChatMessageDto(
      id: 'm1',
      role: 'user',
      content: 'What is AAPL?',
      createdAt: tCreatedAt,
    );
  });

  group('BizzieChatRemoteDataSource', () {
    group('sendMessage', () {
      test(
        'sendMessage_dioSucceeds_returnsBizzieChatResponseDto',
        () async {
          // arrange
          when(
            () => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
            ),
          ).thenAnswer(
            (_) async => Response<Map<String, dynamic>>(
              data: {
                'message': 'Hello',
                'followUps': ['What else?'],
                'source': null,
                'metadata': {'sessionId': tSessionId, 'routePath': null},
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: '/bizzieChat'),
            ),
          );

          // act
          final result = await sut.sendMessage(tRequest);

          // assert
          expect(result.message, equals('Hello'));
          expect(result.metadata.sessionId, equals(tSessionId));
          verify(
            () => mockDio.post<Map<String, dynamic>>(
              '/bizzieChat',
              data: any(named: 'data'),
            ),
          ).called(1);
        },
      );

      test(
        'sendMessage_dioThrows_rethrowsException',
        () async {
          // arrange
          final tException = DioException(
            requestOptions: RequestOptions(path: '/bizzieChat'),
            type: DioExceptionType.connectionTimeout,
          );
          when(
            () => mockDio.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
            ),
          ).thenThrow(tException);

          // act + assert
          expect(
            () => sut.sendMessage(tRequest),
            throwsA(same(tException)),
          );
        },
      );
    });

    // -------------------------------------------------------------------------
    group('getSessionsStream', () {
      test(
        'getSessionsStream_firestoreEmitsSessions_returnsStreamOfSessions',
        () async {
          // arrange
          when(
            () => mockFirestoreService.getCollectionStream<ChatSessionDto>(
              path: any(named: 'path'),
              fromJson: any(named: 'fromJson'),
              toJson: any(named: 'toJson'),
              queryBuilder: any(named: 'queryBuilder'),
            ),
          ).thenAnswer((_) => Stream.value([tSessionDto]));

          // act
          final result = sut.getSessionsStream(tUid, tTicker);
          final sessions = await result.first;

          // assert
          expect(sessions, equals([tSessionDto]));
        },
      );

      test(
        'getSessionsStream_usesCorrectFirestorePath',
        () async {
          // arrange
          when(
            () => mockFirestoreService.getCollectionStream<ChatSessionDto>(
              path: any(named: 'path'),
              fromJson: any(named: 'fromJson'),
              toJson: any(named: 'toJson'),
              queryBuilder: any(named: 'queryBuilder'),
            ),
          ).thenAnswer((_) => Stream.value([]));

          // act
          sut.getSessionsStream(tUid, tTicker);

          // assert
          verify(
            () => mockFirestoreService.getCollectionStream<ChatSessionDto>(
              path: 'users/$tUid/conversations',
              fromJson: any(named: 'fromJson'),
              toJson: any(named: 'toJson'),
              queryBuilder: any(named: 'queryBuilder'),
            ),
          ).called(1);
        },
      );
    });

    // -------------------------------------------------------------------------
    group('getMessagesStream', () {
      test(
        'getMessagesStream_firestoreEmitsMessages_returnsStreamOfMessages',
        () async {
          // arrange
          when(
            () => mockFirestoreService.getCollectionStream<ChatMessageDto>(
              path: any(named: 'path'),
              fromJson: any(named: 'fromJson'),
              toJson: any(named: 'toJson'),
              queryBuilder: any(named: 'queryBuilder'),
            ),
          ).thenAnswer((_) => Stream.value([tMessageDto]));

          // act
          final result = sut.getMessagesStream(tUid, tSessionId);
          final messages = await result.first;

          // assert
          expect(messages, equals([tMessageDto]));
        },
      );

      test(
        'getMessagesStream_usesCorrectFirestorePath',
        () async {
          // arrange
          when(
            () => mockFirestoreService.getCollectionStream<ChatMessageDto>(
              path: any(named: 'path'),
              fromJson: any(named: 'fromJson'),
              toJson: any(named: 'toJson'),
              queryBuilder: any(named: 'queryBuilder'),
            ),
          ).thenAnswer((_) => Stream.value([]));

          // act
          sut.getMessagesStream(tUid, tSessionId);

          // assert
          verify(
            () => mockFirestoreService.getCollectionStream<ChatMessageDto>(
              path: 'users/$tUid/conversations/$tSessionId/messages',
              fromJson: any(named: 'fromJson'),
              toJson: any(named: 'toJson'),
              queryBuilder: any(named: 'queryBuilder'),
            ),
          ).called(1);
        },
      );
    });
  });
}
