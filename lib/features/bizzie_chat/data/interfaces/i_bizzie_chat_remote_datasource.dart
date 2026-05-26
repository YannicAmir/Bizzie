import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_request_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_response_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/bizzie_chat_sse_event_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_message_dto.dart';
import 'package:bizzie/features/bizzie_chat/data/dtos/chat_session_dto.dart';

abstract class IBizzieChatRemoteDataSource {
  /// Non-streaming POST — returns the full [BizzieChatResponseDto] once complete.
  Future<BizzieChatResponseDto> sendMessage(BizzieChatRequestDto request);

  /// Streaming POST — yields [BizzieChatSseEventDto] events as SSE chunks arrive.
  /// Throws on connection errors; SSE `error` events are yielded as
  /// [BizzieChatErrorEventDto] rather than thrown.
  Stream<BizzieChatSseEventDto> sendMessageStream(BizzieChatRequestDto request);

  /// Real-time Firestore stream of sessions for [uid] scoped to [ticker], ordered newest first.
  Stream<List<ChatSessionDto>> getSessionsStream(String uid, String ticker);

  /// Real-time Firestore stream of messages for a session, ordered oldest first.
  Stream<List<ChatMessageDto>> getMessagesStream(String uid, String sessionId);
}
