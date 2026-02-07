import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateFavoriteSectorUseCase
    implements UseCase<Either<Failure, void>, UserModel> {
  final IUserRepository _userRepository;

  UpdateFavoriteSectorUseCase(this._userRepository);

  @override
  Future<Either<Failure, void>> call(UserModel params) async {
    return _userRepository.updateUser(params);
  }
}
