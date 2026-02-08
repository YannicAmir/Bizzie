import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateFavoriteSectorUseCase
    implements UseCase<Either<Failure, void>, Sector> {
  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;

  UpdateFavoriteSectorUseCase(this._userRepository, this._authRepository);

  @override
  Future<Either<Failure, void>> call(Sector params) async {
    final currentUser = _authRepository.currentUser;
    if (currentUser == null) {
      return const Left(CacheFailure('User not found'));
    }

    final userResult = await _userRepository.getUser(currentUser.id);

    return userResult.fold((failure) => Left(failure), (user) async {
      final updatedUser = user.copyWith(favoriteSector: params.name);
      return _userRepository.updateUser(updatedUser);
    });
  }
}
