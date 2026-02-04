import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_status_dto.freezed.dart';
part 'subscription_status_dto.g.dart';

@freezed
abstract class SubscriptionStatusDto with _$SubscriptionStatusDto {
  const SubscriptionStatusDto._();
  const factory SubscriptionStatusDto({
    required bool isSubscribed,
    required Set<String> activeEntitlements,
    required Set<String> activeProductIds,
    DateTime? expirationDate,
  }) = _SubscriptionStatusDto;

  factory SubscriptionStatusDto.initial() => const SubscriptionStatusDto(
    isSubscribed: false,
    activeEntitlements: {},
    activeProductIds: {},
  );

  factory SubscriptionStatusDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStatusDtoFromJson(json);

  factory SubscriptionStatusDto.fromRevenueCat(CustomerInfo info) {
    final entitlement = info.entitlements.active['plus'];
    return SubscriptionStatusDto(
      isSubscribed: entitlement != null,
      activeEntitlements: info.entitlements.active.keys.toSet(),
      activeProductIds: info.entitlements.active.values
          .map((e) => e.productIdentifier)
          .toSet(),
      expirationDate: _safeParseDate(entitlement?.expirationDate),
    );
  }

  static DateTime? _safeParseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  SubscriptionStatus toDomain() {
    return SubscriptionStatus(
      isSubscribed: isSubscribed,
      activeEntitlements: activeEntitlements,
      activeProductIds: activeProductIds,
      expirationDate: expirationDate,
    );
  }
}
