import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/user_model.dart';

class SignUpWithEmailParams {
  final String email;
  final String password;

  SignUpWithEmailParams({required this.email, required this.password});
}

@lazySingleton
class SignUpWithEmailUseCase
    implements UseCase<Either<Failure, UserModel>, SignUpWithEmailParams> {
  final IAuthRepository repository;

  SignUpWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(SignUpWithEmailParams params) {
    return repository.signUpWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}
