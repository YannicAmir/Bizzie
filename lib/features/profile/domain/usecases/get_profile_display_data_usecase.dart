import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/market/domain/extensions/market_data_extensions.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/domain/interfaces/i_market_repository.dart';
import 'package:bizzie/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('GetProfileDisplayDataUseCase');

typedef MarketDataRecord = ({
  String description,
  String displayName,
  List<SectorPe> peList,
  List<SectorPerformance> performanceList,
});

@lazySingleton
class GetProfileDisplayDataUseCase
    implements UseCase<Either<Failure, ProfileDisplayData>, NoParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IProfileRepository _profileRepository;
  final IMarketRepository _marketRepository;

  GetProfileDisplayDataUseCase(
    this._authRepository,
    this._userRepository,
    this._profileRepository,
    this._marketRepository,
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

        final results = await (
          _profileRepository.getSectorDescription(sectorName),
          _profileRepository.getSectorDisplayName(sectorName),
          _marketRepository.getSectorPeList(),
          _marketRepository.getSectorPerformanceList(),
        ).wait;

        return _aggregateSectorData(results).map((data) {
          _logger.info('Successfully aggregated all data');

          final peDate = data.peList.getDateForSector(sectorName);
          final perfDate = data.performanceList.getDateForSector(sectorName);
          final marketDateStr = peDate ?? perfDate;

          return ProfileDisplayData(
            displayName: userModel.name,
            sectorName: data.displayName,
            sectorDescription: data.description,
            joinedDate: userModel.createdAt,
            sectorPe: data.peList.getPeForSector(sectorName),
            sectorAverageChange: data.performanceList.getAverageChangeForSector(
              sectorName,
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
    (
      Either<Failure, String>,
      Either<Failure, String>,
      Either<Failure, List<SectorPe>>,
      Either<Failure, List<SectorPerformance>>,
    )
    results,
  ) {
    final (descRes, nameRes, peRes, perfRes) = results;

    return descRes.fold(
      (f) {
        _logger.warning('Failed to fetch sector description', f);
        return Left(f);
      },
      (desc) => nameRes.fold(
        (f) {
          _logger.warning('Failed to fetch sector display name', f);
          return Left(f);
        },
        (name) => peRes.fold(
          (f) {
            _logger.warning('Failed to fetch PE list', f);
            return Left(f);
          },
          (peList) => perfRes.fold(
            (f) {
              _logger.warning('Failed to fetch performance list', f);
              return Left(f);
            },
            (perfList) => Right((
              description: desc,
              displayName: name,
              peList: peList,
              performanceList: perfList,
            )),
          ),
        ),
      ),
    );
  }
}
