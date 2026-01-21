import 'package:equatable/equatable.dart';

class HistoricalPriceEod extends Equatable {
  final String symbol;
  final String date;
  final double price;
  final double volume;

  const HistoricalPriceEod({
    required this.symbol,
    required this.date,
    required this.price,
    required this.volume,
  });

  @override
  List<Object?> get props => [symbol, date, price, volume];
}
