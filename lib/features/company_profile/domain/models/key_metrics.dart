import 'package:equatable/equatable.dart';

class KeyMetrics extends Equatable {
  final String symbol;
  final String date;
  final String period;
  final double returnOnEquity;

  const KeyMetrics({
    required this.symbol,
    required this.date,
    required this.period,
    required this.returnOnEquity,
  });

  @override
  List<Object?> get props => [symbol, date, period, returnOnEquity];
}
