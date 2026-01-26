import 'package:equatable/equatable.dart';

class DividendEvent extends Equatable {
  final String date;
  final double dividend;
  final double adjDividend;
  final double? yield;
  final String? recordDate;
  final String? paymentDate;
  final String? declarationDate;
  final String? frequency;

  const DividendEvent({
    required this.date,
    required this.dividend,
    required this.adjDividend,
    this.yield,
    this.recordDate,
    this.paymentDate,
    this.declarationDate,
    this.frequency,
  });

  int get frequencyMultiplier {
    final freq = frequency?.toLowerCase() ?? '';
    if (freq.contains('quarter')) return 4;
    if (freq.contains('month')) return 12;
    if (freq.contains('semi')) return 2;
    return 1;
  }

  double get annualizedDividend => dividend * frequencyMultiplier;

  double calculateYield({required double currentPrice}) {
    if (currentPrice > 0) {
      return (annualizedDividend / currentPrice) * 100;
    }
    return yield ?? 0.0;
  }

  double calculateGrowthRate(DividendEvent? previous) {
    if (previous == null || previous.dividend <= 0) return 0.0;
    return ((dividend - previous.dividend) / previous.dividend) * 100;
  }

  @override
  List<Object?> get props => [
    date,
    dividend,
    adjDividend,
    yield,
    recordDate,
    paymentDate,
    declarationDate,
    frequency,
  ];
}
