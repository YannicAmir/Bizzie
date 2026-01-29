import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';

abstract class IBusinessRepository {
  Future<Either<Failure, BusinessProfile>> getBusinessProfile(String ticker);
}
