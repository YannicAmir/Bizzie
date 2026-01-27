import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/mark_reports_viewed_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkReportsViewedUseCase
    implements UseCase<void, MarkReportsViewedParams> {
  final IReportsRepository _repository;

  MarkReportsViewedUseCase(this._repository);

  @override
  Future<void> call(MarkReportsViewedParams params) {
    return _repository.markReportsViewed(params.uid, params.timestamp);
  }
}
