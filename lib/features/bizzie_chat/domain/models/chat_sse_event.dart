import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_sse_event.freezed.dart';

@freezed
sealed class ChatSseEvent with _$ChatSseEvent {
  const factory ChatSseEvent.token({required String token}) = ChatTokenEvent;

  const factory ChatSseEvent.done({
    required List<String> followUps,
    String? source,
    String? routePath,
  }) = ChatDoneEvent;

  const factory ChatSseEvent.error({required String message}) = ChatErrorEvent;
}
