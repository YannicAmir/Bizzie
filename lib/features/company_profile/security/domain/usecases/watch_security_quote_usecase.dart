import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_quote_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchSecurityQuoteUseCase
    implements StreamUseCase<Either<Failure, SecurityQuote?>, String> {
  final ISecurityQuoteRepository _repository;

  WatchSecurityQuoteUseCase(this._repository);

  @override
  Stream<Either<Failure, SecurityQuote?>> call(String ticker) {
    return _repository.watchSecurityQuote(ticker);
  }
}
