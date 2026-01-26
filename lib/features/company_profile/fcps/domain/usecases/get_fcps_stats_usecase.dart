import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../interfaces/i_fcps_repository.dart';
import '../models/fcps_stats.dart';

@lazySingleton
class GetFcpsStatsUseCase
    implements UseCase<Either<Failure, FcpsStats>, String> {
  final IFcpsRepository _repository;

  GetFcpsStatsUseCase(this._repository);

  @override
  Future<Either<Failure, FcpsStats>> call(String ticker) async {
    return _repository.getFcpsStats(ticker);
  }
}
