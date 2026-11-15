import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/utils/string_utils.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:injectable/injectable.dart';

const _defaultInvestingExperience = InvestingExperience.beginner;

@lazySingleton
class OnboardingProfileBuilder {
  UserModel newUser({
    required String uid,
    required OnboardingData data,
    required Map<String, String> fcmTokens,
  }) {
    return UserModel(
      uid: uid,
      name: data.firstName,
      favoriteSector: StringUtils.sanitizeTopic(
        data.selectedSector?.name ?? '',
      ),
      watchlist: data.detectedCompanies
          .map((c) => Company(ticker: c.ticker, name: c.name))
          .toList(),
      investingExperience:
          data.investingExperience ?? _defaultInvestingExperience,
      createdAt: DateTime.now(),
      isSubscribed: false,
      notificationsEnabled: data.notificationsEnabled,
      fcmTokens: fcmTokens,
    );
  }

  OnboardingProfileUpdate profileUpdate({
    required String uid,
    required OnboardingData data,
  }) {
    return OnboardingProfileUpdate(
      uid: uid,
      name: data.firstName.trim().isEmpty ? null : data.firstName,
      investingExperience: data.investingExperience,
      notificationsEnabled: data.hasDecidedNotifications
          ? data.notificationsEnabled
          : null,
    );
  }
}
