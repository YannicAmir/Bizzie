import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_remote_data_source.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('SubscriptionRepositoryImpl');

@LazySingleton(as: ISubscriptionRepository)
class SubscriptionRepositoryImpl implements ISubscriptionRepository {
  final ISubscriptionRemoteDataSource _remoteDataSource;
  final FirestoreService _firestoreService;

  SubscriptionRepositoryImpl(this._remoteDataSource, this._firestoreService);

  @override
  Future<void> initialize() async {
    try {
      await _remoteDataSource.initialize();
    } catch (e, s) {
      _logger.severe('Subscription initialization failed', e, s);
    }
  }

  @override
  Stream<SubscriptionStatus> watchSubscriptionStatus(String userId) {
    return _firestoreService
        .getDocumentStream<UserModel>(
          path: 'users/$userId',
          fromJson: UserModel.fromJson,
          toJson: (user) => user.toJson(),
        )
        .map((user) {
          if (user == null) return SubscriptionStatus.initial();
          return SubscriptionStatus(
            isSubscribed: user.isSubscribed,
            activeEntitlements: user.isSubscribed ? {'plus'} : {},
          );
        });
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> getSubscriptionStatus() async {
    try {
      final dto = await _remoteDataSource.getSubscriptionStatus();
      return Right(dto.toDomain());
    } catch (e, s) {
      _logger.severe('Failed to get subscription status', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscriptionOffering>> getOfferings() async {
    try {
      final dto = await _remoteDataSource.getOfferings();
      return Right(dto.toDomain());
    } catch (e, s) {
      _logger.severe('Failed to get offerings', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> purchasePackage(
    SubscriptionPackage package,
  ) async {
    try {
      final dto = await _remoteDataSource.purchasePackage(package);
      return Right(dto.toDomain());
    } catch (e, s) {
      _logger.severe('Purchase failed for ${package.identifier}', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> restorePurchases() async {
    try {
      final dto = await _remoteDataSource.restorePurchases();
      return Right(dto.toDomain());
    } catch (e, s) {
      _logger.severe('Restore purchases failed', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logIn(String uid) async {
    try {
      await _remoteDataSource.logIn(uid);
      return const Right(null);
    } catch (e, s) {
      _logger.severe('Login to subscription service failed for $uid', e, s);
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await _remoteDataSource.logOut();
      return const Right(null);
    } catch (e, s) {
      _logger.severe('Logout from subscription service failed', e, s);
      return Left(Failure.server(e.toString()));
    }
  }
}
