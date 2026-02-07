import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase implements UseCase<Either<Failure, void>, String> {
  final IAuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(String email) async {
    return _authRepository.resetPassword(email: email);
  }
}
