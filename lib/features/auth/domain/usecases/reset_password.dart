import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';

class ResetPassword implements UseCase<void, String> {
  final IAuthRepository repository;

  ResetPassword(this.repository);

  @override
  Future<void> call(String email) async {
    return repository.resetPassword(email: email);
  }
}
