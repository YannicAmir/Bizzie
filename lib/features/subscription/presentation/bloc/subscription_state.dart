import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/core/error/failures.dart';

part 'subscription_state.freezed.dart';

@freezed
abstract class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    required SubscriptionStatus status,
    required bool isLoading,
    required bool isLocalSuccessOverride,
    Failure? failure,
  }) = SubscriptionStateImpl;

  factory SubscriptionState.initial() => SubscriptionState(
    status: SubscriptionStatus.initial(),
    isLoading: false,
    isLocalSuccessOverride: false,
  );
}
