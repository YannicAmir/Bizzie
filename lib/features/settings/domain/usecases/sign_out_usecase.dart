import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOutUseCase implements UseCase<Either<Failure, void>, NoParams> {
  final IAuthRepository _authRepository;
  final ISubscriptionRepository _subscriptionRepository;

  SignOutUseCase(this._authRepository, this._subscriptionRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final result = await _authRepository.signOut();
    return result.fold((l) => Left(l), (r) async {
      await _subscriptionRepository.logOut();
      return const Right(null);
    });
  }
}
