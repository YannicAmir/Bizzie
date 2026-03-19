import 'package:bizzie/features/company_profile/financial_statements/data/dtos/frankfurter_response_dto.dart';

abstract class IExchangeRateRemoteDataSource {
  /// Fetches the exchange rate from the Frankfurter API.
  /// [date] should be in YYYY-MM-DD format.
  /// [base] is the source currency (e.g., 'USD').
  /// [target] is the currency to convert to (e.g., 'CNY').
  Future<FrankfurterResponseDto> getExchangeRate({
    required String base,
    required String target,
    required String date,
  });
}
