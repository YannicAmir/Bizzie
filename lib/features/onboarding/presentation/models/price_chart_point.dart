import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_chart_point.freezed.dart';

@freezed
abstract class PriceChartPoint with _$PriceChartPoint {
  const factory PriceChartPoint({
    required DateTime date,
    required double price,
  }) = _PriceChartPoint;
}
