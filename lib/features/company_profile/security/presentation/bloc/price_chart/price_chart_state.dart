import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_chart_state.freezed.dart';

@freezed
abstract class PriceChartState with _$PriceChartState {
  const PriceChartState._();

  const factory PriceChartState({
    required List<HistoricalPriceEod> fullHistory,
    required List<HistoricalPriceEod> viewData,
    required ChartTimeFrame selectedTimeFrame,
    @Default(0) int chartChangeCount,
  }) = _PriceChartState;

  factory PriceChartState.initial() => const PriceChartState(
    fullHistory: [],
    viewData: [],
    selectedTimeFrame: ChartTimeFrame.d5,
    chartChangeCount: 0,
  );
}
