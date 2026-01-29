import 'package:freezed_annotation/freezed_annotation.dart';

part 'dividend_event.freezed.dart';

@freezed
abstract class DividendEvent with _$DividendEvent {
  const DividendEvent._();

  const factory DividendEvent({
    required String date,
    required double dividend,
    required double adjDividend,
    double? yield,
    String? recordDate,
    String? paymentDate,
    String? declarationDate,
    String? frequency,
  }) = _DividendEvent;

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
}
