import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_chart_event.freezed.dart';

@freezed
sealed class PriceChartEvent with _$PriceChartEvent {
  const factory PriceChartEvent.historyUpdated(
    List<HistoricalPriceEod> history,
  ) = HistoryUpdated;
  const factory PriceChartEvent.timeFrameChanged(ChartTimeFrame timeFrame) =
      TimeFrameChanged;
}
