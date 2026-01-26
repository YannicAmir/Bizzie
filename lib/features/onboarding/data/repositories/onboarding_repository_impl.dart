import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/utils/string_utils.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';

import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepositoryImpl implements IOnboardingRepository {
  final IOnboardingRemoteDataSource _remoteDataSource;
  final _logger = BizzieLogger('OnboardingRepositoryImpl');

  OnboardingRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<HistoricalPrice>>> getSp500History() async {
    try {
      final history = dummyData
          .map((e) => HistoricalPrice.fromJson(e))
          .toList();
      return Right(history);
    } catch (e, stack) {
      _logger.severe('Failed to get SP500 history', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Sector>>> getSectors() async {
    try {
      final sectorStrings = _remoteDataSource.getStockMarketSectors();
      final sectors = sectorStrings
          .map((s) => Sector.fromString(s))
          .whereType<Sector>()
          .toList();
      return Right(sectors);
    } catch (e, stack) {
      _logger.severe('Failed to get sectors', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(UserModel user) async {
    try {
      final watchlistItems = user.watchlist.map((c) {
        return WatchlistItemDto.fromDomain(c);
      }).toList();

      final userDto = UserDto(
        uid: user.uid,
        name: user.name,
        favoriteSector: StringUtils.sanitizeTopic(user.favoriteSector),
        favoriteSectorDisplay: user.favoriteSector,
        investingExperience: user.investingExperience.name,
        isSubscribed: user.isSubscribed,
        fcmTokens: user.fcmTokens,
      );

      await _remoteDataSource.saveUserProfile(userDto, watchlistItems);
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to save user profile', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }
}
