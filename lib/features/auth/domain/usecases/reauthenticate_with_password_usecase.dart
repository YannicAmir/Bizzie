import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class ReauthenticateWithPasswordParams {
  final String password;

  const ReauthenticateWithPasswordParams({required this.password});
}

@injectable
class ReauthenticateWithPasswordUseCase
    implements UseCase<void, ReauthenticateWithPasswordParams> {
  final IAuthRepository _authRepository;

  ReauthenticateWithPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(
    ReauthenticateWithPasswordParams params,
  ) async {
    return _authRepository.reauthenticateWithPassword(params.password);
  }
}
