import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension ChartDataListX on List<FinancialDataPoint> {
  List<ChartDataPoint> toChartDataReversed({required FinancialPeriod period}) {
    return reversed.map((p) => p._toChartPoint(period: period)).toList();
  }

  List<ChartDataPoint> toChartDataSortedByDate({
    required FinancialPeriod period,
  }) {
    final sorted = List<FinancialDataPoint>.from(this)
      ..sort((a, b) => a.date.compareTo(b.date));
    return sorted.map((p) => p._toChartPoint(period: period)).toList();
  }
}

extension on FinancialDataPoint {
  ChartDataPoint _toChartPoint({required FinancialPeriod period}) {
    return ChartDataPoint(
      label: BizzieDateFormatter.formatChartLabel(date, period: period),
      value: value,
    );
  }
}
