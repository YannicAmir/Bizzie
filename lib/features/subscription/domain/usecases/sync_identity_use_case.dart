import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncIdentityUseCase extends UseCase<Either<Failure, void>, String?> {
  final ISubscriptionRepository _repository;

  SyncIdentityUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String? uid) async {
    if (uid != null) {
      return _repository.logIn(uid);
    } else {
      return _repository.logOut();
    }
  }
}
