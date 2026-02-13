import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ResetPasswordUseCase');

@lazySingleton
class ResetPasswordUseCase implements UseCase<Either<Failure, void>, String> {
  final IAuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(String email) async {
    _logger.info(
      'Executing ResetPasswordUseCase: Requesting password reset for $email',
    );

    if (email.trim().isEmpty) {
      _logger.warning('ResetPasswordUseCase failed: Email is empty');
      return Left(
        Failure.server('Email address is required to reset password.'),
      );
    }

    return _performResetPassword(email);
  }

  Future<Either<Failure, void>> _performResetPassword(String email) async {
    try {
      final result = await _authRepository.resetPassword(email: email);

      return result.fold(
        (failure) {
          _logger.warning('Auth repository password reset failed', failure);
          return Left(failure);
        },
        (_) {
          _logger.info('Password reset email successfully requested');
          return const Right(null);
        },
      );
    } catch (e) {
      _logger.severe('Unexpected error during password reset request', e);
      return Left(
        Failure.server('An unexpected error occurred. Please try again later.'),
      );
    }
  }
}
