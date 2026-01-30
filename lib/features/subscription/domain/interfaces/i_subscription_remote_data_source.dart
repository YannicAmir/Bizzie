import 'package:bizzie/features/subscription/data/dtos/subscription_status_dto.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_offering_dto.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';

abstract class ISubscriptionRemoteDataSource {
  Future<void> initialize();
  Future<void> logIn(String uid);
  Future<void> logOut();
  Future<SubscriptionOfferingDto> getOfferings();
  Future<SubscriptionStatusDto> purchasePackage(SubscriptionPackage package);
  Future<SubscriptionStatusDto> restorePurchases();
  Future<SubscriptionStatusDto> getSubscriptionStatus();
}
