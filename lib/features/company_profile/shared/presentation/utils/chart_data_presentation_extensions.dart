import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension ChartDataListX on List<FinancialDataPoint> {
  List<ChartDataPoint> toChartDataReversed({required bool isAnnual}) {
    return reversed.map((p) => p._toChartPoint(isAnnual: isAnnual)).toList();
  }

  List<ChartDataPoint> toChartDataSortedByDate({required bool isAnnual}) {
    final sorted = List<FinancialDataPoint>.from(this)
      ..sort((a, b) => a.date.compareTo(b.date));
    return sorted.map((p) => p._toChartPoint(isAnnual: isAnnual)).toList();
  }
}

extension on FinancialDataPoint {
  ChartDataPoint _toChartPoint({required bool isAnnual}) {
    return ChartDataPoint(
      label: BizzieDateFormatter.formatChartLabel(date, isAnnual: isAnnual),
      value: value,
    );
  }
}
