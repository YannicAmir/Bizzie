import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

@injectable
class GetSp500HistoryUseCase
    implements UseCase<Either<Failure, List<HistoricalPrice>>, NoParams> {
  final IOnboardingRepository _repository;

  GetSp500HistoryUseCase(this._repository);

  @override
  Future<Either<Failure, List<HistoricalPrice>>> call(NoParams params) {
    return _repository.getSp500History();
  }
}
