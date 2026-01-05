import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/user_model.dart';

class SignInWithEmailParams {
  final String email;
  final String password;

  SignInWithEmailParams({required this.email, required this.password});
}

@lazySingleton
class SignInWithEmail implements UseCase<UserModel, SignInWithEmailParams> {
  final IAuthRepository repository;

  SignInWithEmail(this.repository);

  @override
  Future<UserModel> call(SignInWithEmailParams params) {
    return repository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}
