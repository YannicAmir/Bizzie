import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ResolveOnboardingUserUseCase');

@lazySingleton
class ResolveOnboardingUserUseCase
    implements UseCase<Either<Failure, UserModel>, NoParams> {
  final IAuthRepository _authRepository;

  ResolveOnboardingUserUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    final currentUser = _authRepository.currentUser;
    if (currentUser != null) return Right(currentUser);

    _logger.info('No current user; signing in anonymously for onboarding');
    return _authRepository.signInAnonymously();
  }
}
