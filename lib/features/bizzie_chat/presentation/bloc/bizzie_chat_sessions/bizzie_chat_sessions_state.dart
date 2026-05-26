import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bizzie_chat_sessions_state.freezed.dart';

@freezed
abstract class BizzieChatSessionsState with _$BizzieChatSessionsState {
  const factory BizzieChatSessionsState.initial() = _Initial;
  const factory BizzieChatSessionsState.loading() = _Loading;
  const factory BizzieChatSessionsState.loaded({
    required List<ChatSession> sessions,
    required String ticker,
  }) = _Loaded;
  const factory BizzieChatSessionsState.failure(Failure failure) = _Failure;
}
