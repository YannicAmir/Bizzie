import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_request_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_response_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_sse_event_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_message_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_session_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/interfaces/i_bizzie_chat_remote_datasource.dart';

final _logger = BizzieLogger('BizzieChatRemoteDataSource');

const _kEndpoint = '/bizzieChat';
const _kConversations = 'conversations';
const _kMessages = 'messages';

@Injectable(as: IBizzieChatRemoteDataSource)
class BizzieChatRemoteDataSource implements IBizzieChatRemoteDataSource {
  final Dio _dio;
  final FirestoreService _firestoreService;

  BizzieChatRemoteDataSource(
    @Named('BizzieDio') this._dio,
    this._firestoreService,
  );

  @override
  Future<BizzieChatResponseDto> sendMessage(
    BizzieChatRequestDto request,
  ) async {
    try {
      _logger.info('sendMessage: sessionId=${request.sessionId}');
      final response = await _dio.post<Map<String, dynamic>>(
        _kEndpoint,
        data: request.toJson(),
      );
      return BizzieChatResponseDto.fromJson(response.data!);
    } catch (e, s) {
      _logger.severe('sendMessage failed', e, s);
      rethrow;
    }
  }

  @override
  Stream<BizzieChatSseEventDto> sendMessageStream(
    BizzieChatRequestDto request,
  ) async* {
    _logger.info('sendMessageStream: sessionId=${request.sessionId}');

    final Response<ResponseBody> response;
    try {
      response = await _dio.post<ResponseBody>(
        _kEndpoint,
        data: request.toJson(),
        options: Options(responseType: ResponseType.stream),
      );
    } catch (e, s) {
      _logger.severe('sendMessageStream connection failed', e, s);
      rethrow;
    }

    final buffer = StringBuffer();

    try {
      await for (final chunk
          in response.data!.stream.map((bytes) => utf8.decode(bytes))) {
        buffer.write(chunk);

        final text = buffer.toString();
        final lines = text.split('\n');

        buffer
          ..clear()
          ..write(lines.last);

        for (final line in lines.sublist(0, lines.length - 1)) {
          if (!line.startsWith('data: ')) continue;
          final raw = line.substring(6).trim();
          if (raw.isEmpty) continue;

          try {
            yield BizzieChatSseEventDto.fromRawLine(raw);
          } catch (e) {
            _logger.warning('sendMessageStream: failed to parse SSE line: $raw');
          }
        }
      }
    } catch (e, s) {
      _logger.severe('sendMessageStream: byte-stream error', e, s);
      rethrow;
    }
  }

  @override
  Stream<List<ChatSessionDto>> getSessionsStream(String uid, String ticker) {
    return _firestoreService
        .getCollectionStream<ChatSessionDto>(
          path: 'users/$uid/$_kConversations',
          fromJson: ChatSessionDto.fromJson,
          toJson: (dto) => dto.toJson(),
          queryBuilder: (q) => q.where('ticker', isEqualTo: ticker),
        )
        .handleError((e, s) {
          _logger.severe(
            'getSessionsStream error for uid=$uid ticker=$ticker',
            e,
            s,
          );
          throw e;
        });
  }

  @override
  Stream<List<ChatMessageDto>> getMessagesStream(
    String uid,
    String sessionId,
  ) {
    return _firestoreService
        .getCollectionStream<ChatMessageDto>(
          path: 'users/$uid/$_kConversations/$sessionId/$_kMessages',
          fromJson: ChatMessageDto.fromJson,
          toJson: (dto) => dto.toJson(),
          queryBuilder: (q) => q.orderBy('createdAt'),
        )
        .handleError((e, s) {
          _logger.severe(
            'getMessagesStream error for uid=$uid sessionId=$sessionId',
            e,
            s,
          );
          throw e;
        });
  }
}
