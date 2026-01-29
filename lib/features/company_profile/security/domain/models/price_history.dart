import 'package:bizzie/features/company_profile/security/domain/models/price_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_history.freezed.dart';

@freezed
abstract class PriceHistory with _$PriceHistory {
  const factory PriceHistory({
    required String symbol,
    required List<PricePoint> history,
  }) = _PriceHistory;
}
