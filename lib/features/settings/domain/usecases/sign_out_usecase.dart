import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SignOutUseCase');

@lazySingleton
class SignOutUseCase implements UseCase<Either<Failure, void>, NoParams> {
  final IAuthRepository _authRepository;
  final ISubscriptionRepository _subscriptionRepository;

  SignOutUseCase(this._authRepository, this._subscriptionRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    _logger.info('Executing SignOutUseCase: Initiating user sign out');

    final result = await _authRepository.signOut();

    return await result.fold((failure) async {
      _logger.warning('Failed to sign out from auth repository', failure);
      return Left(failure);
    }, (_) async => _clearSubscriptionSession());
  }

  Future<Either<Failure, void>> _clearSubscriptionSession() async {
    try {
      _logger.info('Clearing subscription session (logOut)');
      await _subscriptionRepository.logOut();
      _logger.info('Successfully signed out and cleared sessions');
      return const Right(null);
    } catch (e) {
      _logger.warning('Optional subscription logOut failed during sign out', e);
      return const Right(null);
    }
  }
}
