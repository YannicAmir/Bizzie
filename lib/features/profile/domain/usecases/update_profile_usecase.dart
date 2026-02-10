import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';

class UpdateProfileParams {
  final String? firstName;
  final String? email;

  const UpdateProfileParams({this.firstName, this.email});
}

@injectable
class UpdateProfileUseCase
    implements UseCase<Either<Failure, void>, UpdateProfileParams> {
  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;

  UpdateProfileUseCase(this._userRepository, this._authRepository);

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) async {
    final authUser = _authRepository.currentUser;
    if (authUser == null) {
      return const Left(Failure.userNotFound());
    }

    if (params.firstName != null) {
      final userResult = await _userRepository.getUser(authUser.id);
      if (userResult.isLeft()) {
        return Left(
          userResult.fold(
            (l) => l,
            (r) => const Failure.server('Failed to fetch user'),
          ),
        );
      }

      final dbUser = userResult.getOrElse(
        () => throw const Failure.server('User not found'),
      );
      final updatedUser = dbUser.copyWith(name: params.firstName!);
      final updateResult = await _userRepository.updateUser(updatedUser);
      if (updateResult.isLeft()) {
        return updateResult;
      }
    }

    if (params.email != null) {
      if (authUser.email != params.email) {
        final result = await _authRepository.updateEmail(params.email!);
        if (result.isLeft()) {
          return result;
        }
      }
    }

    return const Right(null);
  }
}
