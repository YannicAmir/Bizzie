import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchUserUseCase {
  final IUserRepository _userRepository;

  WatchUserUseCase(this._userRepository);

  Stream<UserModel> call(String uid) {
    return _userRepository.watchUser(uid);
  }
}
