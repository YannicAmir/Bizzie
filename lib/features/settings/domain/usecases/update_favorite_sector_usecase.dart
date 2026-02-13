import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('UpdateFavoriteSectorUseCase');

@lazySingleton
class UpdateFavoriteSectorUseCase
    implements UseCase<Either<Failure, void>, Sector> {
  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;

  UpdateFavoriteSectorUseCase(this._userRepository, this._authRepository);

  @override
  Future<Either<Failure, void>> call(Sector params) async {
    _logger.info(
      'Executing UpdateFavoriteSectorUseCase for sector: ${params.name}',
    );

    final authRes = _getAuthenticatedUserId();

    return await authRes.fold((failure) async => Left(failure), (userId) async {
      final fetchRes = await _fetchUserModel(userId);

      return await fetchRes.fold(
        (failure) async => Left(failure),
        (user) async => _updateSectorInRepo(user, params),
      );
    });
  }

  Either<Failure, String> _getAuthenticatedUserId() {
    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      _logger.warning('Update failed: No current user found in auth session');
      return const Left(Failure.userNotFound());
    }
    return Right(currentUser.id);
  }

  Future<Either<Failure, UserModel>> _fetchUserModel(String userId) async {
    final result = await _userRepository.getUser(userId);
    if (result.isLeft()) {
      _logger.warning('Failed to fetch user model for update');
    }
    return result;
  }

  Future<Either<Failure, void>> _updateSectorInRepo(
    UserModel user,
    Sector sector,
  ) async {
    final updatedUser = user.copyWith(favoriteSector: sector.name);
    final result = await _userRepository.updateUser(updatedUser);

    result.fold(
      (failure) => _logger.warning(
        'Failed to update favorite sector in repository',
        failure,
      ),
      (_) => _logger.info(
        'Successfully updated favorite sector to: ${sector.name}',
      ),
    );

    return result;
  }
}
