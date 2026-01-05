import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserUseCase implements UseCase<Either<Failure, UserModel>, String> {
  final IUserRepository _repository;

  GetUserUseCase(this._repository);

  String? get cachedSector => _repository.getCachedFavoriteSector();

  @override
  Future<Either<Failure, UserModel>> call(String params) async {
    return await _repository.getUser(params);
  }
}
