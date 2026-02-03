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

extension SubscriptionStateX on SubscriptionState {
  bool get isLoading => this is SubscriptionStateLoading;
  Failure? get failure =>
      maybeMap(failure: (f) => f.failure, orElse: () => null);

  SubscriptionPackage? get annualPackage =>
      maybeMap(loaded: (s) => s.annualPackage, orElse: () => null);

  SubscriptionPackage? get monthlyPackage =>
      maybeMap(loaded: (s) => s.monthlyPackage, orElse: () => null);

  SubscriptionPackage? get discountAnnualPackage =>
      maybeMap(loaded: (s) => s.discountAnnualPackage, orElse: () => null);

  bool get isPurchasing =>
      maybeMap(loaded: (s) => s.isPurchasing, orElse: () => false);
}
