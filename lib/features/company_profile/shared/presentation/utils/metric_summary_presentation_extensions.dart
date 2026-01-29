import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
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
    final avg5Y = getAverageOfLatest(5);
    if (avg5Y != null) {
      return (label: '5Y Avg. $metricSuffix', value: avg5Y.formattedRatioValue);
    }

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
    required String formattedDelta,
    required bool isChangeZero,
    required String referenceLabel,
  }) {
    if (isChangeZero) {
      return '${asOfPrefix}No change since $referenceLabel';
    }
    final action = isPositive ? 'Increased' : 'Decreased';
    return '$asOfPrefix$action by $formattedDelta since $referenceLabel';
  }
}
