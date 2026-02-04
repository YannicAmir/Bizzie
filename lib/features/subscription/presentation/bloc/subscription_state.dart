import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';

part 'subscription_state.freezed.dart';

@freezed
abstract class SubscriptionState with _$SubscriptionState {
  const SubscriptionState._();

  @override
  SubscriptionStatus get status;

  const factory SubscriptionState.initial({
    required SubscriptionStatus status,
  }) = SubscriptionStateInitial;

  const factory SubscriptionState.loading({
    required SubscriptionStatus status,
  }) = SubscriptionStateLoading;

  const factory SubscriptionState.loaded({
    required SubscriptionStatus status,
    required SubscriptionOffering offerings,
    SubscriptionPackage? annualPackage,
    SubscriptionPackage? monthlyPackage,
    SubscriptionPackage? discountAnnualPackage,
    @Default(false) bool isLocalSuccessOverride,
    @Default(false) bool isPurchasing,
    @Default(true) bool isAnnualSelection,
  }) = SubscriptionStateLoaded;

  const factory SubscriptionState.failure({
    required SubscriptionStatus status,
    required Failure failure,
  }) = SubscriptionStateFailure;

  factory SubscriptionState.initialState() =>
      SubscriptionState.initial(status: SubscriptionStatus.initial());
}
