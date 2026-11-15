import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAuthStreamUseCase implements StreamUseCase<UserModel?, NoParams> {
  final IAuthRepository _authRepository;

  GetAuthStreamUseCase(this._authRepository);

  @override
  Stream<UserModel?> call([NoParams? params]) {
    return _authRepository.authStateChanges.map(
      (result) => result.fold<UserModel?>(
        (failure) => throw ServerException(message: failure.message),
        (user) => user,
      ),
    );
  }
}
