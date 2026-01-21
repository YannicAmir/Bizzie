import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';

@lazySingleton
class GetShareStatsUseCase
    implements UseCase<Either<Failure, ShareStats>, String> {
  final ISecurityRepository _repository;

  GetShareStatsUseCase(this._repository);

  @override
  Future<Either<Failure, ShareStats>> call(String ticker) async {
    return _repository.getShareStats(ticker);
  }
}
