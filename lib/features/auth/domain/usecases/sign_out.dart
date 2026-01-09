import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';

@lazySingleton
class SignOut implements UseCase<Either<Failure, void>, NoParams> {
  final IAuthRepository repository;

  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}
