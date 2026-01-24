import 'package:bizzie/features/company_profile/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension MetricSummaryListX on List<FinancialDataPoint> {
  String getAsOfPrefix(DateTime? lastUpdated) {
    if (isEmpty) {
      if (lastUpdated != null) {
        return 'As of ${BizzieDateFormatter.formatMonthYearFull(lastUpdated.toIso8601String())} | ';
      }
      return '';
    }

    final dateToFormat = last.date;
    final asOfDate = BizzieDateFormatter.formatMonthYearFull(dateToFormat);
    return 'As of $asOfDate | ';
  }

  ({String label, String value})? getDynamicAverageColumn(String metricSuffix) {
    // Try 5Y
    final avg5Y = getAverageOfLatest(5);
    if (avg5Y != null) {
      return (label: '5Y Avg. $metricSuffix', value: avg5Y.formattedRatioValue);
    }

    // Try 3Y
    final avg3Y = getAverageOfLatest(3);
    if (avg3Y != null) {
      return (label: '3Y Avg. $metricSuffix', value: avg3Y.formattedRatioValue);
    }

    return null;
  }
}

extension MetricSummaryDoubleX on double {
  String get formattedRatioValue => toStringAsFixed(2);

  String get formattedRatioBadge {
    final sign = this > 0 ? '+' : '';
    return '$sign${toStringAsFixed(1)}%';
  }
}

class MetricSummarySubtitleHelper {
  static String getSubtitle({
    required String asOfPrefix,
    required bool isPositive,
    required double absoluteDelta,
    required String referenceLabel,
  }) {
    final action = isPositive ? 'Increased' : 'Decreased';
    final delta = absoluteDelta.toStringAsFixed(2);
    return '$asOfPrefix$action by $delta since $referenceLabel';
  }
}
