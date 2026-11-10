import 'package:bizzie/features/company_profile/security/data/dtos/security_quote_dto.dart';

abstract class ISecurityQuoteRemoteDataSource {
  Stream<SecurityQuoteDto?> getSecurityQuoteStream(String ticker);
}
