import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/user_model.dart';

@lazySingleton
class SignInWithApple implements UseCase<UserModel, NoParams> {
  final IAuthRepository repository;

  SignInWithApple(this.repository);

  @override
  Future<UserModel> call(NoParams params) {
    return repository.signInWithApple();
  }
}
