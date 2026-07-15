import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/segments/domain/interfaces/i_segments_repository.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRevenueGeographicSegmentsUseCase
    implements
        UseCase<
          Either<
            Failure,
            (RevenueGeographicSegments, CompanyProfileDataOrigin)
          >,
          String
        > {
  final ISegmentsRepository _repository;

  GetRevenueGeographicSegmentsUseCase(this._repository);

  @override
  Future<
    Either<Failure, (RevenueGeographicSegments, CompanyProfileDataOrigin)>
  >
  call(String ticker) {
    return _repository.getGeographicSegments(ticker);
  }
}
