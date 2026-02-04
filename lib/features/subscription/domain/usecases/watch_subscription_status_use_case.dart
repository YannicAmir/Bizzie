import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchSubscriptionStatusUseCase
    extends StreamUseCase<SubscriptionStatus, String> {
  final ISubscriptionRepository _repository;

  WatchSubscriptionStatusUseCase(this._repository);

  @override
  Stream<SubscriptionStatus> call(String userId) {
    return _repository.watchSubscriptionStatus(userId);
  }
}
