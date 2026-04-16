import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bizzie_chat_event.freezed.dart';

@freezed
class BizzieChatEvent with _$BizzieChatEvent {
  const factory BizzieChatEvent.sessionStarted({
    required String uid,
    required String ticker,
    required String companyName,
    String? sessionId,
  }) = _SessionStarted;

  const factory BizzieChatEvent.messageSent({required String query}) =
      _MessageSent;

  const factory BizzieChatEvent.reset() = _Reset;

  const factory BizzieChatEvent.messagesLoaded(List<ChatMessage> messages) =
      _MessagesLoaded;

  const factory BizzieChatEvent.messagesLoadFailed(Failure failure) =
      _MessagesLoadFailed;

  const factory BizzieChatEvent.sseTokenReceived(String token) =
      _SseTokenReceived;

  const factory BizzieChatEvent.sseDone({
    required List<String> followUps,
    String? source,
  }) = _SseDone;

  const factory BizzieChatEvent.sseFailed(String message) = _SseFailed;
}
