import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/user_model.dart';

@lazySingleton
class SignInWithGoogle implements UseCase<UserModel, NoParams> {
  final IAuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<UserModel> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}
