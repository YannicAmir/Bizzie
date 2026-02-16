import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/market/domain/extensions/sector_pe_extensions.dart';
import 'package:bizzie/features/market/domain/extensions/sector_performance_extensions.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/domain/interfaces/i_market_repository.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('GetProfileDisplayDataUseCase');

typedef MarketDataRecord = ({
  List<SectorPe> peList,
  List<SectorPerformance> performanceList,
});

@lazySingleton
class GetProfileDisplayDataUseCase
    implements UseCase<Either<Failure, ProfileDisplayData>, NoParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IMarketRepository _marketRepository;
  final ISectorService _sectorService;

  GetProfileDisplayDataUseCase(
    this._authRepository,
    this._userRepository,
    this._marketRepository,
    this._sectorService,
  );

  @override
  Future<Either<Failure, ProfileDisplayData>> call(NoParams params) async {
    _logger.info('Fetching Profile Display Data');

    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      _logger.warning('User not found in cache');
      return const Left(CacheFailure('User not found in cache'));
    }

    final userResult = await _userRepository.getUser(currentUser.id);
    return userResult.fold(
      (failure) {
        _logger.severe('Failed to fetch user model', failure);
        return Left(failure);
      },
      (userModel) async {
        final sectorName = userModel.favoriteSector;
        final sectorApiName = _sectorService.getSectorApiName(sectorName);

        final results = await (
          _marketRepository.getSectorPeList(),
          _marketRepository.getSectorPerformanceList(),
        ).wait;

        return _aggregateSectorData(results).map((data) {
          _logger.info('Successfully aggregated all data');

          final peDate = data.peList.getDateForSector(sectorApiName);
          final perfDate = data.performanceList.getDateForSector(sectorApiName);
          final marketDateStr = peDate ?? perfDate;

          final displayName = _sectorService.getSectorDisplayName(sectorName);
          final description = _sectorService.getSectorDescription(sectorName);

          return ProfileDisplayData(
            displayName: userModel.name,
            sectorName: displayName,
            sectorDescription: description,
            joinedDate: userModel.createdAt,
            sectorPe: data.peList.getPeForSector(sectorApiName),
            sectorAverageChange: data.performanceList.getAverageChangeForSector(
              sectorApiName,
            ),
            marketDataDate: marketDateStr != null
                ? DateTime.tryParse(marketDateStr)
                : null,
          );
        });
      },
    );
  }

  Either<Failure, MarketDataRecord> _aggregateSectorData(
    (Either<Failure, List<SectorPe>>, Either<Failure, List<SectorPerformance>>)
    results,
  ) {
    final (peRes, perfRes) = results;

    return peRes.fold(
      (f) {
        _logger.warning('Failed to fetch PE list', f);
        return Left(f);
      },
      (peList) => perfRes.fold((f) {
        _logger.warning('Failed to fetch performance list', f);
        return Left(f);
      }, (perfList) => Right((peList: peList, performanceList: perfList))),
    );
  }
}
