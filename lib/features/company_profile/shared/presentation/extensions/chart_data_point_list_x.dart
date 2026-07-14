import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';

extension ChartDataPointListX on List<ChartDataPoint> {
  List<BizzieChartData> toBizzieChartData() =>
      map((point) => BizzieChartData(point.label, point.value)).toList();
}
