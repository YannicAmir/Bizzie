import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:equatable/equatable.dart';
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

class MarkReportsViewedParams extends Equatable {
  final String uid;
  final DateTime timestamp;

  const MarkReportsViewedParams({required this.uid, required this.timestamp});

  @override
  List<Object> get props => [uid, timestamp];
}
