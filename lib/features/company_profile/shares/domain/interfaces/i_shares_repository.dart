import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/share_stats.dart';

abstract class ISharesRepository {
  Future<Either<Failure, (ShareStats, CompanyProfileDataOrigin)>> getShareStats(
    String ticker,
  );
}
