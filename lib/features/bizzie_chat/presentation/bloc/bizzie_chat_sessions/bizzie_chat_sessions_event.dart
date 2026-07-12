import 'package:freezed_annotation/freezed_annotation.dart';

part 'bizzie_chat_sessions_event.freezed.dart';

@freezed
sealed class BizzieChatSessionsEvent with _$BizzieChatSessionsEvent {
  const factory BizzieChatSessionsEvent.started({
    required String uid,
    required String ticker,
  }) = _Started;

  const factory BizzieChatSessionsEvent.reset() = _Reset;
}
