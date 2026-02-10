import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAccountUseCase implements UseCase<Either<Failure, void>, NoParams> {
  final IAuthRepository _authRepository;

  DeleteAccountUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _authRepository.deleteAccount();
  }
}
