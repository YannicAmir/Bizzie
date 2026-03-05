import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';

abstract class ISecurityRepository {
  Future<Either<Failure, (SecurityDetails, CompanyProfileDataOrigin)>>
  getSecurityDetails(String ticker);
  Future<Either<Failure, (DateTime?, CompanyProfileDataOrigin)>>
  getUpcomingEarningsDate(String ticker);
}
