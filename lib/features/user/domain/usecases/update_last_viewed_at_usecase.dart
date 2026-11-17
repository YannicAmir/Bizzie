import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateLastViewedAtUseCase
    implements UseCase<Either<Failure, void>, NoParams> {
  final IUserRepository _repository;

  UpdateLastViewedAtUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      _repository.updateLastViewedAt();
}
