import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_onboarding_destination.freezed.dart';

@freezed
abstract class PostOnboardingDestination with _$PostOnboardingDestination {
  const factory PostOnboardingDestination({
    required String ticker,
    required OnboardingValueSource tickerSource,
    required bool shouldPromptNotifications,
    @Default(false) bool shouldPersistNotificationGrant,
  }) = _PostOnboardingDestination;
}
