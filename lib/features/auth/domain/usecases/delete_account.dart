import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';

class DeleteAccount implements UseCase<void, NoParams> {
  final IAuthRepository repository;

  DeleteAccount(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return repository.deleteAccount();
  }
}
