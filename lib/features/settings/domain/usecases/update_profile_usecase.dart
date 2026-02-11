import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('UpdateProfileUseCase');

@lazySingleton
class UpdateProfileUseCase
    implements UseCase<Either<Failure, void>, UserModel> {
  final IUserRepository _userRepository;

  UpdateProfileUseCase(this._userRepository);

  @override
  Future<Either<Failure, void>> call(UserModel user) async {
    _logger.info(
      'Executing UpdateProfileUseCase: Requesting profile update for ${user.uid}',
    );

    return _persistProfileChanges(user);
  }

  Future<Either<Failure, void>> _persistProfileChanges(UserModel user) async {
    try {
      final result = await _userRepository.updateUser(user);

      return result.fold(
        (failure) {
          _logger.warning('User repository profile update failed', failure);
          return Left(failure);
        },
        (_) {
          _logger.info('Successfully updated user profile in repository');
          return const Right(null);
        },
      );
    } catch (e) {
      _logger.severe('Unexpected error during profile update', e);
      return Left(
        Failure.server(
          'An unexpected error occurred while saving your profile.',
        ),
      );
    }
  }
}
