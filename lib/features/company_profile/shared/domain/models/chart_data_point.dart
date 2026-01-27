import 'package:equatable/equatable.dart';

class ChartDataPoint extends Equatable {
  final String label;
  final double value;

  const ChartDataPoint({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}
