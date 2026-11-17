import 'package:bizzie/core/domain/models/user_model.dart';
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
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('GetProfileDisplayDataUseCase');

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

    final (userRes, peRes, perfRes) = await (
      _userRepository.getUser(currentUser.id),
      _marketRepository.getSectorPeList(),
      _marketRepository.getSectorPerformanceList(),
    ).wait;

    return _aggregateData((
      userRes,
      peRes,
      perfRes,
    ), isGuest: currentUser.isAnonymous);
  }

  Either<Failure, ProfileDisplayData> _aggregateData(
    (
      Either<Failure, UserModel>,
      Either<Failure, List<SectorPe>>,
      Either<Failure, List<SectorPerformance>>,
    )
    results, {
    required bool isGuest,
  }) {
    final (userRes, peRes, perfRes) = results;

    return userRes.fold(
      (f) {
        _logger.severe('Failed to fetch user model', f);
        return Left(f);
      },
      (userModel) {
        final peList = peRes.fold((f) {
          _logger.warning('Failed to fetch PE list (using default)', f);
          return const <SectorPe>[];
        }, (list) => list);
        final performanceList = perfRes.fold((f) {
          _logger.warning(
            'Failed to fetch performance list (using default)',
            f,
          );
          return const <SectorPerformance>[];
        }, (list) => list);

        final sectorName = userModel.favoriteSector;
        final sectorApiName = _sectorService.getSectorApiName(sectorName);

        final peDate = peList.getDateForSector(sectorApiName);
        final perfDate = performanceList.getDateForSector(sectorApiName);
        final marketDateStr = peDate ?? perfDate;

        _logger.info('Successfully aggregated all data');
        return Right(
          ProfileDisplayData(
            displayName: userModel.name,
            sectorName: _sectorService.getSectorDisplayName(sectorName),
            sectorDescription: _sectorService.getSectorDescription(sectorName),
            joinedDate: userModel.createdAt,
            sectorPe: peList.getPeForSector(sectorApiName),
            sectorAverageChange: performanceList.getAverageChangeForSector(
              sectorApiName,
            ),
            marketDataDate: marketDateStr != null
                ? DateTime.tryParse(marketDateStr)
                : null,
            isGuest: isGuest,
          ),
        );
      },
    );
  }
}
