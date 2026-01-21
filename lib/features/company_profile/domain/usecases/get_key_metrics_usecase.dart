import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/models/key_metrics.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';

@lazySingleton
class GetKeyMetricsUseCase
    implements UseCase<Either<Failure, List<KeyMetrics>>, String> {
  final IFinancialRepository _repository;

  GetKeyMetricsUseCase(this._repository);

  @override
  Future<Either<Failure, List<KeyMetrics>>> call(String params) {
    return _repository.getKeyMetrics(params);
  }
}
