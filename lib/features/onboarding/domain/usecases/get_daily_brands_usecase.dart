import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

@injectable
class GetDailyBrandsUseCase
    implements
        UseCase<
          Either<Failure, (List<Brand>, List<Brand>)>,
          GetDailyBrandsParams
        > {
  final IOnboardingRepository _repository;

  GetDailyBrandsUseCase(this._repository);

  @override
  Future<Either<Failure, (List<Brand>, List<Brand>)>> call(
    GetDailyBrandsParams params,
  ) {
    return _repository.getDailyBrands(params.sector);
  }
}

class GetDailyBrandsParams extends Equatable {
  final Sector? sector;

  const GetDailyBrandsParams({this.sector});

  @override
  List<Object?> get props => [sector];
}
