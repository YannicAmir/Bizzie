import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/onboarding/data/interfaces/i_onboarding_remote_datasource.dart';
import 'package:bizzie/features/onboarding/data/dtos/onboarding_profile_update_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/onboarding_skip_config_mapper.dart';
import 'package:bizzie/core/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';

import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bizzie/core/data/dtos/watchlist_item_dto.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('OnboardingRepositoryImpl');

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepositoryImpl implements IOnboardingRepository {
  final IOnboardingRemoteDataSource _remoteDataSource;

  OnboardingRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<HistoricalPrice>>> getSp500History() async {
    _logger.info('Fetching S&P 500 history');
    try {
      final history = _remoteDataSource
          .getSp500History()
          .map((dto) => dto.toDomain())
          .toList();
      _logger.info('Successfully fetched ${history.length} historical prices');
      return Right(history);
    } catch (e, stack) {
      _logger.severe('Failed to get SP500 history', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Sector>>> getSectors() async {
    _logger.info('Fetching available sectors');
    try {
      final sectorStrings = _remoteDataSource.getStockMarketSectors();
      final sectors = sectorStrings
          .map((s) => Sector.fromString(s))
          .whereType<Sector>()
          .toList();
      _logger.info('Successfully fetched ${sectors.length} sectors');
      return Right(sectors);
    } catch (e, stack) {
      _logger.severe('Failed to get sectors', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OnboardingSkipDefaults>> getSkipDefaults() async {
    _logger.info('Fetching onboarding skip defaults');
    try {
      final defaults = _remoteDataSource.getOnboardingSkipConfig().toDomain();
      _logger.info(
        'Successfully fetched ${defaults.defaultWatchlist.length} default watchlist companies',
      );
      return Right(defaults);
    } catch (e, stack) {
      _logger.severe('Failed to get onboarding skip defaults', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> userProfileExists(String uid) async {
    _logger.info('Checking for an existing user profile for UID: $uid');
    try {
      return Right(await _remoteDataSource.userProfileExists(uid));
    } catch (e, stack) {
      _logger.severe('Failed to check for an existing user profile', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserProfile(
    UserModel user, {
    bool awaitServerAck = true,
  }) async {
    _logger.info('Saving user profile for: ${user.name}');
    try {
      final watchlistItems = user.watchlist.map((c) {
        return WatchlistItemDto.fromDomain(c);
      }).toList();

      final userDto = UserDto.fromDomain(user);

      await _remoteDataSource.saveUserProfile(
        userDto,
        watchlistItems,
        awaitServerAck: awaitServerAck,
      );
      _logger.info('Successfully saved user profile');
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to save user profile', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOnboardingProfile(
    OnboardingProfileUpdate update, {
    bool awaitServerAck = true,
  }) async {
    _logger.info('Updating onboarding profile for UID: ${update.uid}');
    try {
      await _remoteDataSource.updateOnboardingProfile(
        update.uid,
        OnboardingProfileUpdateDto.fromDomain(update),
        awaitServerAck: awaitServerAck,
      );
      _logger.info('Successfully updated onboarding profile');
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to update onboarding profile', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }
}
