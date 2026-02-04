import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/interfaces/i_subscription_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOfferingsUseCase
    implements UseCase<Either<Failure, SubscriptionOffering>, NoParams> {
  final ISubscriptionRepository _repository;

  GetOfferingsUseCase(this._repository);

  @override
  Future<Either<Failure, SubscriptionOffering>> call(NoParams params) async {
    return _repository.getOfferings();
  }
}
