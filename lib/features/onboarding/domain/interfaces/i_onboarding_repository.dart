import 'package:bizzie/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';

import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/domain/models/user_model.dart';

abstract class IOnboardingRepository {
  Future<Either<Failure, List<Sector>>> getSectors();

  Future<Either<Failure, OnboardingSkipDefaults>> getSkipDefaults();

  Future<Either<Failure, List<HistoricalPrice>>> getSp500History();

  Future<Either<Failure, bool>> userProfileExists(String uid);

  Future<Either<Failure, void>> saveUserProfile(
    UserModel user, {
    bool awaitServerAck = true,
  });

  Future<Either<Failure, void>> updateOnboardingProfile(
    OnboardingProfileUpdate update, {
    bool awaitServerAck = true,
  });
}
