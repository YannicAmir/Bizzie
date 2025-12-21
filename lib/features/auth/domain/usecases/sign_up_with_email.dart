import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/user_model.dart';
import 'sign_in_with_email.dart'; // Reuse params

class SignUpWithEmail implements UseCase<UserModel, SignInWithEmailParams> {
  final IAuthRepository repository;

  SignUpWithEmail(this.repository);

  @override
  Future<UserModel> call(SignInWithEmailParams params) {
    return repository.signUpWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}
