import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ManageSubscriptionUseCase {
  final ISubscriptionRepository _subscriptionRepository;

  ManageSubscriptionUseCase(this._subscriptionRepository);

  Future<Either<Failure, SubscriptionStatus>> getStatus() {
    return _subscriptionRepository.getSubscriptionStatus();
  }

  Future<Either<Failure, SubscriptionStatus>> restorePurchases() {
    return _subscriptionRepository.restorePurchases();
  }
}
