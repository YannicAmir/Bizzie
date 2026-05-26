import 'package:freezed_annotation/freezed_annotation.dart';

part 'bizzie_chat_request_dto.freezed.dart';
part 'bizzie_chat_request_dto.g.dart';

@freezed
abstract class BizzieChatRequestDto with _$BizzieChatRequestDto {
  const BizzieChatRequestDto._();

  const factory BizzieChatRequestDto({
    required String idempotencyKey,
    required String query,
    required String companyTicker,
    required String companyName,
    required String sessionId,
    @Default(false) bool stream,
  }) = _BizzieChatRequestDto;

  factory BizzieChatRequestDto.fromJson(Map<String, dynamic> json) =>
      _$BizzieChatRequestDtoFromJson(json);
}
