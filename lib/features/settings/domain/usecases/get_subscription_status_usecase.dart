import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('GetSubscriptionStatusUseCase');

@lazySingleton
class GetSubscriptionStatusUseCase
    implements UseCase<Either<Failure, SubscriptionStatus>, NoParams> {
  final ISubscriptionRepository _subscriptionRepository;

  GetSubscriptionStatusUseCase(this._subscriptionRepository);

  @override
  Future<Either<Failure, SubscriptionStatus>> call(NoParams params) async {
    _logger.info('Executing GetSubscriptionStatusUseCase');
    return await _subscriptionRepository.getSubscriptionStatus();
  }
}
