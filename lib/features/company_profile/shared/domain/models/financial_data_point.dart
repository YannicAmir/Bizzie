import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_data_point.freezed.dart';

@freezed
abstract class FinancialDataPoint with _$FinancialDataPoint {
  const factory FinancialDataPoint({
    required String date,
    required String period,
    required double value,
  }) = _FinancialDataPoint;
}
