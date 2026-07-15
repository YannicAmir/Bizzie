import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:dartz/dartz.dart';

abstract class ISegmentsRepository {
  Future<Either<Failure, (RevenueProductSegments, CompanyProfileDataOrigin)>>
  getProductSegments(String ticker);

  Future<Either<Failure, (RevenueGeographicSegments, CompanyProfileDataOrigin)>>
  getGeographicSegments(String ticker);
}
