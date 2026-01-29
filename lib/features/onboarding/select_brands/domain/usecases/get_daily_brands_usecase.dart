import 'package:bizzie/features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

@injectable
class GetDailyBrandsUseCase
    implements UseCase<Either<Failure, BrandListing>, GetDailyBrandsParams> {
  final ISelectBrandsRepository _repository;

  GetDailyBrandsUseCase(this._repository);

  @override
  Future<Either<Failure, BrandListing>> call(GetDailyBrandsParams params) {
    return _repository.getDailyBrands(params.sector);
  }
}
