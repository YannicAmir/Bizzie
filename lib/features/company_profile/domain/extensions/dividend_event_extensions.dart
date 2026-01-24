import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:intl/intl.dart';

extension DividendEventListExtensions on List<DividendEvent> {
  List<BizzieChartData> toChartData() {
    return reversed.map((e) {
      String label = '';
      try {
        label = DateFormat("MMM ''yy").format(DateTime.parse(e.date));
      } catch (_) {
        label = e.date;
      }
      return BizzieChartData(label, e.dividend);
    }).toList();
  }
}
