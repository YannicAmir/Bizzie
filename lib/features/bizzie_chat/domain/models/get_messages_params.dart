import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_messages_params.freezed.dart';

@freezed
abstract class GetMessagesParams with _$GetMessagesParams {
  const factory GetMessagesParams({
    required String uid,
    required String sessionId,
  }) = _GetMessagesParams;
}
