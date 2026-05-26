import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_params.freezed.dart';

@freezed
abstract class SendMessageParams with _$SendMessageParams {
  const factory SendMessageParams({
    required String idempotencyKey,
    required String query,
    required String companyTicker,
    required String companyName,
    required String sessionId,
  }) = _SendMessageParams;
}
