import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_roe_repository.dart';
import '../models/roe.dart';

@lazySingleton
class GetRoeUseCase implements UseCase<Either<Failure, List<Roe>>, String> {
  final IRoeRepository _repository;

  GetRoeUseCase(this._repository);

  @override
  Future<Either<Failure, List<Roe>>> call(String ticker) async {
    return _repository.getRoeMetrics(ticker);
  }
}
