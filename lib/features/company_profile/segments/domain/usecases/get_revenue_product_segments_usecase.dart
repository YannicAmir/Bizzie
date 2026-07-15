import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/segments/domain/interfaces/i_segments_repository.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRevenueProductSegmentsUseCase
    implements
        UseCase<
          Either<Failure, (RevenueProductSegments, CompanyProfileDataOrigin)>,
          String
        > {
  final ISegmentsRepository _repository;

  GetRevenueProductSegmentsUseCase(this._repository);

  @override
  Future<Either<Failure, (RevenueProductSegments, CompanyProfileDataOrigin)>>
  call(String ticker) {
    return _repository.getProductSegments(ticker);
  }
}
