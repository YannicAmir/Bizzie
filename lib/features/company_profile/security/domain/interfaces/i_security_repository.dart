import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';

abstract class ISecurityRepository {
  Future<Either<Failure, SecurityDetails>> getSecurityDetails(String ticker);
  Future<Either<Failure, DateTime?>> getUpcomingEarningsDate(String ticker);
}
