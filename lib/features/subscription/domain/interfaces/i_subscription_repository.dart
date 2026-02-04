import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';

abstract class ISubscriptionRepository {
  Future<void> initialize();

  Stream<SubscriptionStatus> watchSubscriptionStatus(String userId);

  Future<Either<Failure, void>> refreshSubscriptionStatus();

  Future<Either<Failure, SubscriptionStatus>> getSubscriptionStatus();

  Future<Either<Failure, SubscriptionOffering>> getOfferings();

  Future<Either<Failure, SubscriptionStatus>> purchasePackage(
    SubscriptionPackage package,
  );

  Future<Either<Failure, SubscriptionStatus>> restorePurchases();

  Future<Either<Failure, void>> syncIdentity(String? uid);

  Future<Either<Failure, void>> logIn(String uid);

  Future<Either<Failure, void>> logOut();
}
