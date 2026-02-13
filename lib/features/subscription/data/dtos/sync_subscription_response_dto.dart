import 'package:bizzie/features/subscription/domain/models/sync_subscription_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_subscription_response_dto.freezed.dart';
part 'sync_subscription_response_dto.g.dart';

@freezed
abstract class SyncSubscriptionResponseDto with _$SyncSubscriptionResponseDto {
  const SyncSubscriptionResponseDto._();

  const factory SyncSubscriptionResponseDto({
    required bool active,
    String? status,
    String? expirationDate,
  }) = _SyncSubscriptionResponseDto;

  factory SyncSubscriptionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SyncSubscriptionResponseDtoFromJson(json);

  SyncSubscriptionResult toDomain() {
    return SyncSubscriptionResult(
      isActive: active,
      status: status,
      expirationDate: expirationDate != null
          ? DateTime.tryParse(expirationDate!)
          : null,
    );
  }
}
