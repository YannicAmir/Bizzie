import 'package:bizzie/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';

part 'historical_price_eod_state.freezed.dart';

@freezed
class HistoricalPriceEodState with _$HistoricalPriceEodState {
  const factory HistoricalPriceEodState.initial() = _Initial;
  const factory HistoricalPriceEodState.loading() = _Loading;
  const factory HistoricalPriceEodState.loaded(
    List<HistoricalPriceEod> prices, {
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory HistoricalPriceEodState.failure(Failure failure) = _Failure;
}
