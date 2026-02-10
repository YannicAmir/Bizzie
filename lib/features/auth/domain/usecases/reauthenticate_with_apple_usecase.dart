import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReauthenticateWithAppleUseCase implements UseCase<void, NoParams> {
  final IAuthRepository _authRepository;

  ReauthenticateWithAppleUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _authRepository.reauthenticateWithApple();
  }
}
