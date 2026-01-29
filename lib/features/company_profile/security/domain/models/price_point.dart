import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_point.freezed.dart';

@freezed
abstract class PricePoint with _$PricePoint {
  const factory PricePoint({
    required String date,
    required double close,
    double? volume,
  }) = _PricePoint;
}
