import 'package:equatable/equatable.dart';

class GetFinancialStatementParams extends Equatable {
  final String ticker;
  final String period;

  const GetFinancialStatementParams({
    required this.ticker,
    this.period = 'annual',
  });

  @override
  List<Object?> get props => [ticker, period];
}
