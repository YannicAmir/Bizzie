import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/user_model.dart';

@lazySingleton
class SignInWithApple implements UseCase<Either<Failure, UserModel>, NoParams> {
  final IAuthRepository repository;

  SignInWithApple(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) {
    return repository.signInWithApple();
  }
}
