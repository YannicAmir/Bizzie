import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_dividend_repository.dart';
import '../models/dividend_info.dart';

@injectable
class GetDividendInfoUseCase
    implements UseCase<Either<Failure, DividendInfo>, String> {
  final IDividendRepository _repository;

  GetDividendInfoUseCase(this._repository);

  @override
  Future<Either<Failure, DividendInfo>> call(String ticker) {
    return _repository.getDividendInfo(ticker);
  }
}
