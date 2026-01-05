import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';

@lazySingleton
class SignOut implements UseCase<void, NoParams> {
  final IAuthRepository repository;

  SignOut(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.signOut();
  }
}
