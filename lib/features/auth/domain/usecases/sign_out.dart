import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  final IAuthRepository repository;

  SignOut(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.signOut();
  }
}
