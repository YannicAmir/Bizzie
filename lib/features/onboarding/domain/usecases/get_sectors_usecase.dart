import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

@injectable
class GetSectorsUseCase
    implements UseCase<Either<Failure, List<Sector>>, NoParams> {
  final IOnboardingRepository _repository;

  GetSectorsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Sector>>> call(NoParams params) {
    return _repository.getSectors();
  }
}
