import '../models/dividend_event.dart';
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

extension DividendEventExtension on DividendEvent {
  bool get isStale {
    final recordDate = DateTime.tryParse(date);
    if (recordDate == null) return true;
    final currentYear = DateTime.now().year;
    return recordDate.year < (currentYear - 1);
  }
}
