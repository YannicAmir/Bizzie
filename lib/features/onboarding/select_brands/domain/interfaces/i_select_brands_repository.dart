import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:dartz/dartz.dart';

abstract class ISelectBrandsRepository {
  Future<Either<Failure, BrandListing>> getDailyBrands(Sector? userSector);
}
