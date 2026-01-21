import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_price_eod_event.freezed.dart';

@freezed
sealed class HistoricalPriceEodEvent with _$HistoricalPriceEodEvent {
  const factory HistoricalPriceEodEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory HistoricalPriceEodEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
