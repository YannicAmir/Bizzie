import 'package:freezed_annotation/freezed_annotation.dart';

part 'pe_ratio.freezed.dart';

@freezed
abstract class PeRatio with _$PeRatio {
  const factory PeRatio({
    required String symbol,
    required String date,
    required String period,
    required double priceToEarningsRatio,
  }) = _PeRatio;
}
