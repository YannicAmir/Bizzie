import 'package:equatable/equatable.dart';

class PricePoint extends Equatable {
  final String date;
  final double close;
  final double? volume;

  const PricePoint({required this.date, required this.close, this.volume});

  @override
  List<Object?> get props => [date, close, volume];
}
