import 'dividend_event.dart';
import 'package:equatable/equatable.dart';

class DividendInfo extends Equatable {
  final String symbol;
  final List<DividendEvent> history;

  const DividendInfo({required this.symbol, required this.history});

  @override
  List<Object?> get props => [symbol, history];
}
