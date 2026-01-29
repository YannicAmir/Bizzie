import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_chart_state.freezed.dart';

@freezed
abstract class PriceChartState with _$PriceChartState {
  const PriceChartState._();

  const factory PriceChartState({
    @Default(ChartTimeFrame.d5) ChartTimeFrame selectedTimeFrame,
    @Default([]) List<HistoricalPriceEod> fullHistory,
    @Default([]) List<HistoricalPriceEod> viewData,
  }) = _PriceChartState;

  factory PriceChartState.initial() => const PriceChartState();
}
