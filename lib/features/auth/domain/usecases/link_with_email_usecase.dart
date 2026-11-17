import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../interfaces/i_auth_repository.dart';
import '../models/link_with_email_params.dart';
import '../models/user_model.dart';

@lazySingleton
class LinkWithEmailUseCase
    implements UseCase<Either<Failure, UserModel>, LinkWithEmailParams> {
  final IAuthRepository repository;

  LinkWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(LinkWithEmailParams params) {
    return repository.linkWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}
