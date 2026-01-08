import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/utils/string_utils.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
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
  Future<Either<Failure, (List<Brand>, List<Brand>)>> getDailyBrands(
    Sector? userSector,
  ) async {
    _logger.info('Repository getDailyBrands called');
    try {
      final dailyBrandsDto = await _remoteDataSource.fetchDailyBrands();

      if (dailyBrandsDto == null) {
        _logger.warning('dailyBrandsDto is NULL - using mocks');
        return Right(_getMockBrands(userSector));
      }

      _logger.info(
        'DTO Sectors found: ${dailyBrandsDto.sectors.map((s) => s.name).toList()}',
      );
      _logger.info('User Sector: ${userSector?.displayName}');

      final globalBrands = <Brand>[];
      final sectorBrands = <Brand>[];

      for (final sectorDto in dailyBrandsDto.sectors) {
        final brands = sectorDto.products.map((p) {
          return Brand(
            name: p.name,
            company: p.company,
            ticker: p.ticker,
            sector: sectorDto.name,
            description: p.description,
          );
        }).toList();

        if (sectorDto.name == 'All Sectors') {
          globalBrands.addAll(brands);
        } else if (userSector != null &&
            sectorDto.name == userSector.displayName) {
          sectorBrands.addAll(brands);
        }
      }

      return Right((globalBrands, sectorBrands));
    } catch (e, stack) {
      _logger.severe('Failed to get daily brands', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }

  (List<Brand>, List<Brand>) _getMockBrands(Sector? userSector) {
    final global = [
      Brand(
        name: 'iPhone',
        company: 'Apple Inc.',
        ticker: 'AAPL',
        sector: 'Information Technology',
        description: 'Tech Giant',
      ),
      Brand(
        name: 'Tesla',
        company: 'Tesla Inc.',
        ticker: 'TSLA',
        sector: 'Consumer Discretionary',
        description: 'EV Manufacturer',
      ),
      Brand(
        name: 'Nike',
        company: 'Nike Inc.',
        ticker: 'NKE',
        sector: 'Consumer Discretionary',
        description: 'Sportswear',
      ),
      Brand(
        name: 'Coca-Cola',
        company: 'The Coca-Cola Company',
        ticker: 'KO',
        sector: 'Consumer Staples',
        description: 'Beverage',
      ),
      Brand(
        name: 'Netflix',
        company: 'Netflix Inc.',
        ticker: 'NFLX',
        sector: 'Communication Services',
        description: 'Streaming',
      ),
    ];

    final sectorSpecific = <Brand>[];
    if (userSector != null) {
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Brand A',
          company: 'Company A',
          ticker: 'AAA',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Brand B',
          company: 'Company B',
          ticker: 'BBB',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Consumer',
          company: 'Company C',
          ticker: 'CCC',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
    }

    return (global, sectorSpecific);
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
