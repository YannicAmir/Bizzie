import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_subscription_result.freezed.dart';

@freezed
abstract class SyncSubscriptionResult with _$SyncSubscriptionResult {
  const factory SyncSubscriptionResult({
    required bool isActive,
    String? status,
    DateTime? expirationDate,
  }) = _SyncSubscriptionResult;
}
