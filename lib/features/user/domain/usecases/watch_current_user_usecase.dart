import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchCurrentUserUseCase
    implements StreamUseCase<Either<Failure, UserModel?>, NoParams> {
  final IUserRepository _userRepository;

  WatchCurrentUserUseCase(this._userRepository);

  @override
  Stream<Either<Failure, UserModel?>> call([NoParams? params]) {
    return _userRepository.userStream;
  }
}
