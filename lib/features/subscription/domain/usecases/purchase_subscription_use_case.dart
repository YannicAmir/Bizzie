import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PurchaseSubscriptionUseCase
    extends UseCase<Either<Failure, SubscriptionStatus>, SubscriptionPackage> {
  final ISubscriptionRepository _repository;

  PurchaseSubscriptionUseCase(this._repository);

  @override
  Future<Either<Failure, SubscriptionStatus>> call(
    SubscriptionPackage package,
  ) {
    return _repository.purchasePackage(package);
  }
}
