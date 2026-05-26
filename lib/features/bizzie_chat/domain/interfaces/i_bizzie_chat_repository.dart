import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_response.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_sse_event.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/get_sessions_params.dart';

abstract class IBizzieChatRepository {
  /// Sends a message and returns the full response once the AI completes.
  Future<Either<Failure, ChatResponse>> sendMessage({
    required String idempotencyKey,
    required String query,
    required String companyTicker,
    required String companyName,
    required String sessionId,
  });

  /// Sends a message and returns a stream of SSE events as the AI generates
  /// its response. The stream ends after a [ChatDoneEvent] or [ChatErrorEvent].
  Stream<Either<Failure, ChatSseEvent>> sendMessageStream({
    required String idempotencyKey,
    required String query,
    required String companyTicker,
    required String companyName,
    required String sessionId,
  });

  /// Real-time stream of chat sessions for [params.uid] scoped to [params.ticker], ordered newest first.
  Stream<Either<Failure, List<ChatSession>>> getSessionsStream(GetSessionsParams params);

  /// Real-time stream of all messages for a given [sessionId], ordered oldest first.
  Stream<Either<Failure, List<ChatMessage>>> getMessagesStream(
    String uid,
    String sessionId,
  );
}
