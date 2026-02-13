import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/enums/auth_provider.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class ReauthenticateParams {
  final AuthProvider provider;
  final String? password;

  const ReauthenticateParams({required this.provider, this.password});
}

@injectable
class ReauthenticateUseCase implements UseCase<void, ReauthenticateParams> {
  final IAuthRepository _authRepository;

  ReauthenticateUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(ReauthenticateParams params) async {
    switch (params.provider) {
      case AuthProvider.password:
        return _authRepository.reauthenticateWithPassword(params.password!);
      case AuthProvider.google:
        return _authRepository.reauthenticateWithGoogle();
      case AuthProvider.apple:
        return _authRepository.reauthenticateWithApple();
    }
  }
}
