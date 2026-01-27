import 'package:equatable/equatable.dart';

class FinancialDataPoint extends Equatable {
  final String date;
  final String period;
  final double value;

  const FinancialDataPoint({
    required this.date,
    required this.period,
    required this.value,
  });

  @override
  List<Object?> get props => [date, period, value];
}
