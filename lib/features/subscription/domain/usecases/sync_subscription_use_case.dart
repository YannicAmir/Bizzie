import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncSubscriptionUseCase extends UseCase<Either<Failure, void>, NoParams> {
  final ISubscriptionRepository _repository;

  SyncSubscriptionUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _repository.syncSubscriptionWithBackend();
  }
}
