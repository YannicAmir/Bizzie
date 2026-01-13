import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/core/usecase/usecase.dart';

@injectable
class GetUserActivityUseCase
    implements StreamUseCase<Either<Failure, UserActivity>, String> {
  final IReportsRepository _repository;

  GetUserActivityUseCase(this._repository);

  @override
  Stream<Either<Failure, UserActivity>> call(String uid) {
    return _repository.getUserActivityStream(uid);
  }
}
