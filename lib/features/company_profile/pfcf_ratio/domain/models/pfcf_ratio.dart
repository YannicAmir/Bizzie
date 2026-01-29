import 'package:freezed_annotation/freezed_annotation.dart';

part 'pfcf_ratio.freezed.dart';

@freezed
abstract class PfcfRatio with _$PfcfRatio {
  const factory PfcfRatio({
    required String symbol,
    required String date,
    required String period,
    required double priceToFreeCashFlowRatio,
  }) = _PfcfRatio;
}
