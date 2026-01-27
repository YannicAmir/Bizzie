import 'package:equatable/equatable.dart';

class StockQuote extends Equatable {
  final String symbol;
  final String name;
  final double? price;
  final double? change;
  final double? changesPercentage;
  final double? marketCap;
  final double? pe;
  final double? eps;
  final double? volume;
  final double? sharesOutstanding;

  const StockQuote({
    required this.symbol,
    required this.name,
    this.price,
    this.change,
    this.changesPercentage,
    this.marketCap,
    this.pe,
    this.eps,
    this.volume,
    this.sharesOutstanding,
  });

  @override
  List<Object?> get props => [
    symbol,
    name,
    price,
    change,
    changesPercentage,
    marketCap,
    pe,
    eps,
    volume,
    sharesOutstanding,
  ];
}
