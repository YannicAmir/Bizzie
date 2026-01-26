import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';

import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';

abstract class ISecurityRepository {
  Future<Either<Failure, ShareStats>> getShareStats(String ticker);
}
