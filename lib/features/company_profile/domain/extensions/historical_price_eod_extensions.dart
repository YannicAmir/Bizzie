import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/shared/models/chart_data_point.dart';

extension HistoricalPriceEodListExtensions on List<HistoricalPriceEod> {
  List<ChartDataPoint> toChartDataPoints() {
    return map((e) => ChartDataPoint(e.date, e.price)).toList();
  }
}
