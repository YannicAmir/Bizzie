import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/share_stats.dart';

abstract class ISharesRepository {
  Future<Either<Failure, ShareStats>> getShareStats(String ticker);
}
