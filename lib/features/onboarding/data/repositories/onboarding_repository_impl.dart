import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/utils/string_utils.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';

import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
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
      final history = dummyData
          .map((e) => HistoricalPrice.fromJson(e))
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
  Future<Either<Failure, void>> saveUserProfile(UserModel user) async {
    _logger.info('Saving user profile for: ${user.name}');
    try {
      final watchlistItems = user.watchlist.map((c) {
        return WatchlistItemDto.fromDomain(c);
      }).toList();

      final userDto = UserDto.fromDomain(user).copyWith(
        favoriteSector: StringUtils.sanitizeTopic(user.favoriteSector),
      );

      await _remoteDataSource.saveUserProfile(userDto, watchlistItems);
      _logger.info('Successfully saved user profile');
      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to save user profile', e, stack);
      return Left(Failure.server(e.toString()));
    }
  }
}
