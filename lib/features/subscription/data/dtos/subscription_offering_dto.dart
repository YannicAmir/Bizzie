import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_package_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_offering_dto.freezed.dart';
part 'subscription_offering_dto.g.dart';

@freezed
abstract class SubscriptionOfferingDto with _$SubscriptionOfferingDto {
  const SubscriptionOfferingDto._();
  const factory SubscriptionOfferingDto({
    required String identifier,
    required String serverDescription,
    required List<SubscriptionPackageDto> availablePackages,
  }) = _SubscriptionOfferingDto;

  factory SubscriptionOfferingDto.initial() => const SubscriptionOfferingDto(
    identifier: '',
    serverDescription: '',
    availablePackages: [],
  );

  factory SubscriptionOfferingDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOfferingDtoFromJson(json);

  factory SubscriptionOfferingDto.fromRevenueCat(Offering offering) {
    return SubscriptionOfferingDto(
      identifier: offering.identifier,
      serverDescription: offering.serverDescription,
      availablePackages: offering.availablePackages
          .map((p) => SubscriptionPackageDto.fromRevenueCat(p))
          .toList(),
    );
  }

  SubscriptionOffering toDomain() {
    return SubscriptionOffering(
      identifier: identifier,
      serverDescription: serverDescription,
      availablePackages: availablePackages.map((e) => e.toDomain()).toList(),
    );
  }
}
