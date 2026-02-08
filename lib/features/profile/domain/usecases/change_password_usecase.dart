import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });
}

@injectable
class ChangePasswordUseCase implements UseCase<void, ChangePasswordParams> {
  final IAuthRepository _authRepository;

  ChangePasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return _authRepository.updatePassword(
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }
}
