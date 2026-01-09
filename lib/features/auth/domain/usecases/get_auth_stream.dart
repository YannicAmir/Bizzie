import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAuthStream implements StreamUseCase<UserModel?, NoParams> {
  final IAuthRepository _authRepository;

  GetAuthStream(this._authRepository);

  @override
  Stream<UserModel?> call([NoParams? params]) {
    return _authRepository.authStateChanges;
  }
}
