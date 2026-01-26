import 'package:bizzie/features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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

class GetDailyBrandsParams extends Equatable {
  final Sector? sector;

  const GetDailyBrandsParams({this.sector});

  @override
  List<Object?> get props => [sector];
}
