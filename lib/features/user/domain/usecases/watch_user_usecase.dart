import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchUserUseCase
    implements StreamUseCase<Either<Failure, UserModel?>, String> {
  final IUserRepository _userRepository;

  WatchUserUseCase(this._userRepository);

  @override
  Stream<Either<Failure, UserModel?>> call(String uid) {
    return _userRepository.watchUser(uid);
  }
}
