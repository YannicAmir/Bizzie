import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_financial_statement_params.freezed.dart';

@freezed
abstract class GetFinancialStatementParams with _$GetFinancialStatementParams {
  const factory GetFinancialStatementParams({
    required String ticker,
    @Default('annual') String period,
  }) = _GetFinancialStatementParams;
}
