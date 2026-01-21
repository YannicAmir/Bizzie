import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';

abstract class ISecurityRepository {
  // Tab 1: Security Details (Overview)
  Future<Either<Failure, SecurityDetails>> getSecurityDetails(String ticker);

  // Tab 2: Business Profile (Bio, Executives, Filings)
  Future<Either<Failure, BusinessProfile>> getBusinessProfile(String ticker);

  // Share Statistics
  Future<Either<Failure, ShareStats>> getShareStats(String ticker);
}
