import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_tick.freezed.dart';

@freezed
abstract class PriceTick with _$PriceTick {
  const PriceTick._();

  const factory PriceTick({
    required String unchangedText,
    required String changedText,
    required Color? flashColor,
    required double intensity,
  }) = _PriceTick;

  bool get isFlashing => flashColor != null && intensity > 0;
}
