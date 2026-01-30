import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSubscriptionStatusUseCase
    extends UseCase<Either<Failure, SubscriptionStatus>, NoParams> {
  final ISubscriptionRepository _repository;

  GetSubscriptionStatusUseCase(this._repository);

  @override
  Future<Either<Failure, SubscriptionStatus>> call(NoParams params) {
    return _repository.getSubscriptionStatus();
  }
}
