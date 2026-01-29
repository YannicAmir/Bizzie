import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_pe_ratio_repository.dart';
import '../models/pe_ratio.dart';

@lazySingleton
class GetPeRatioUseCase
    implements UseCase<Either<Failure, List<PeRatio>>, String> {
  final IPeRatioRepository _repository;

  GetPeRatioUseCase(this._repository);

  @override
  Future<Either<Failure, List<PeRatio>>> call(String ticker) async {
    return _repository.getPeRatios(ticker);
  }
}
