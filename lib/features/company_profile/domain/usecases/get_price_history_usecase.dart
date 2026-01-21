import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_price_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/price_history.dart';

@lazySingleton
class GetPriceHistoryUseCase
    implements UseCase<Either<Failure, PriceHistory>, String> {
  final IPriceRepository _repository;

  GetPriceHistoryUseCase(this._repository);

  @override
  Future<Either<Failure, PriceHistory>> call(String ticker) {
    return _repository.getPriceHistory(ticker);
  }
}
