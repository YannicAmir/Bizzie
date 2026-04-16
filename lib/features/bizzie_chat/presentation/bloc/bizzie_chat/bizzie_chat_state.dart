import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/rating_type.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bizzie_chat_state.freezed.dart';

@freezed
abstract class BizzieChatState with _$BizzieChatState {
  const factory BizzieChatState.initial() = _Initial;

  const factory BizzieChatState.loading({
    required String sessionId,
    required String uid,
    required String ticker,
    required String companyName,
  }) = _Loading;

  const factory BizzieChatState.active({
    required String sessionId,
    required String uid,
    required String ticker,
    required String companyName,
    required List<ChatMessage> messages,
    @Default(<String>[]) List<String> followUps,
    @Default(false) bool isStreaming,
    String? streamingContent,
    String? sseError,
    RatingType? rating,
  }) = _Active;

  const factory BizzieChatState.failure(Failure failure) = _Failure;
}
