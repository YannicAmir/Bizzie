import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/revenue/domain/models/revenue_stats.dart';
import 'package:dartz/dartz.dart';

abstract class IRevenueRepository {
  Future<Either<Failure, RevenueStats>> getRevenueStats(String ticker);
}
