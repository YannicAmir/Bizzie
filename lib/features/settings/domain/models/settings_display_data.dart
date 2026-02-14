import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_display_data.freezed.dart';

@freezed
abstract class SettingsDisplayData with _$SettingsDisplayData {
  const factory SettingsDisplayData({
    required UserModel user,
    required SubscriptionStatus subscriptionStatus,
    required bool isAppNotificationsEnabled,
    required bool isSystemNotificationsEnabled,
    required String appVersion,
    required String favoriteSector,
    required String privacyPolicyUrl,
    required String termsOfServiceUrl,
  }) = _SettingsDisplayData;
}
