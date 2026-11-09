import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_price_summary.freezed.dart';

@freezed
abstract class SecurityPriceSummary with _$SecurityPriceSummary {
  const factory SecurityPriceSummary({
    required String priceFormatted,
    required double? price,
    required String changeFormatted,
    required bool isPositiveChange,
    required String sessionDate,
  }) = _SecurityPriceSummary;
}
