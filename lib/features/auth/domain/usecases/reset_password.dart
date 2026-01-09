import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';

class ResetPasswordParams {
  final String email;

  ResetPasswordParams({required this.email});
}

@lazySingleton
class ResetPassword
    implements UseCase<Either<Failure, void>, ResetPasswordParams> {
  final IAuthRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return repository.resetPassword(email: params.email);
  }
}
