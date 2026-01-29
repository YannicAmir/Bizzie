import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data_point.freezed.dart';

@freezed
abstract class ChartDataPoint with _$ChartDataPoint {
  const factory ChartDataPoint({required String label, required double value}) =
      _ChartDataPoint;
}
