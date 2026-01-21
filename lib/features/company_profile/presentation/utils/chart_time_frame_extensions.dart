import 'package:bizzie/features/company_profile/domain/enums/chart_time_frame.dart';
import 'package:intl/intl.dart';

extension ChartTimeFrameX on ChartTimeFrame {
  String get label {
    switch (this) {
      case ChartTimeFrame.d5:
        return '5D';
      case ChartTimeFrame.m1:
        return '1M';
      case ChartTimeFrame.m6:
        return '6M';
      case ChartTimeFrame.y1:
        return '1Y';
      case ChartTimeFrame.y5:
        return '5Y';
      case ChartTimeFrame.all:
        return 'All';
    }
  }

  String formatDateForChart(String dateStr) {
    final dt = DateTime.parse(dateStr);
    if (this == ChartTimeFrame.d5) {
      return DateFormat('EEE').format(dt);
    } else if (this == ChartTimeFrame.y1 ||
        this == ChartTimeFrame.y5 ||
        this == ChartTimeFrame.all) {
      return DateFormat("MMM ''yy").format(dt);
    }
    return DateFormat('MM/dd').format(dt);
  }

  String formatDateForTooltip(String dateStr) {
    final dt = DateTime.parse(dateStr);
    return DateFormat('MMM. dd, yyyy').format(dt);
  }
}
