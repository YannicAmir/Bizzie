import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ProfileRepositoryImpl');

@LazySingleton(as: IProfileRepository)
class ProfileRepositoryImpl implements IProfileRepository {
  final ConfigService _configService;

  ProfileRepositoryImpl(this._configService);

  @override
  Future<Either<Failure, String>> getSectorDescription(
    String sectorName,
  ) async {
    _logger.info('Getting sector description for $sectorName');
    try {
      final description = _configService.getSectorDescription(sectorName);
      _logger.info('Successfully retrieved description for $sectorName');
      return Right(description);
    } catch (e, s) {
      _logger.severe('Error fetching sector description for $sectorName', e, s);
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getSectorDisplayName(
    String sectorName,
  ) async {
    _logger.info('Getting sector display name for $sectorName');
    try {
      final displayName = _configService.getSectorDisplayName(sectorName);
      _logger.info('Successfully retrieved display name for $sectorName');
      return Right(displayName);
    } catch (e, s) {
      _logger.severe(
        'Error fetching sector display name for $sectorName',
        e,
        s,
      );
      return Left(CacheFailure(e.toString()));
    }
  }
}
