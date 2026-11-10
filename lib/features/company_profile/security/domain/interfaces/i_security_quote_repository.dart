import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:dartz/dartz.dart';

abstract class ISecurityQuoteRepository {
  Stream<Either<Failure, SecurityQuote?>> watchSecurityQuote(String ticker);
}
