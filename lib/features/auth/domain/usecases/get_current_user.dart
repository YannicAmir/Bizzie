import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentUser implements SynchronousUseCase<UserModel?, NoParams> {
  final IAuthRepository _authRepository;

  GetCurrentUser(this._authRepository);

  @override
  UserModel? call([NoParams? params]) {
    return _authRepository.currentUser;
  }
}
