import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleNotificationsUseCase {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  ToggleNotificationsUseCase(this._authRepository, this._userRepository);

  Future<Either<Failure, void>> call(bool enable) async {
    try {
      final user = _authRepository.currentUser;
      if (user == null) {
        return const Left(CacheFailure('User not found'));
      }

      final userResult = await _userRepository.getUser(user.id);
      return await userResult.fold((l) async => Left(l), (userModel) async {
        final updatedUser = userModel.copyWith(notificationsEnabled: enable);
        final updateResult = await _userRepository.updateUser(updatedUser);
        return updateResult;
      });
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }
}
