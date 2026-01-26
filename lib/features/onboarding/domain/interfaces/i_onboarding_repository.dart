import 'package:bizzie/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';

import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';

abstract class IOnboardingRepository {
  Future<Either<Failure, List<Sector>>> getSectors();

  Future<Either<Failure, List<HistoricalPrice>>> getSp500History();

  Future<Either<Failure, void>> saveUserProfile(UserModel user);
}
