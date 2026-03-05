import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/metric_summary_presentation_extensions.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';

class PeRatioPresentationHelper {
  static ({
    String valueStr,
    String badgeText,
    AppBadgeStyle badgeStyle,
    String subtitle,
    ({String label, String value})? dynamicAvg,
  })
  formatSummary({
    required List<FinancialDataPoint> dataPoints,
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceLabel,
    DateTime? lastUpdated,
  }) {
    final asOfPrefix = dataPoints.getAsOfPrefix(lastUpdated);
    final dynamicAvg = dataPoints.getDynamicAverageColumn('P/E Ratio');

    return (
      valueStr: currentValue.formattedRatioValue,
      badgeText: growthPercentage.formattedRatioBadge,
      badgeStyle: AppBadgeStyle.neutral,
      subtitle: MetricSummarySubtitleHelper.getSubtitle(
        asOfPrefix: asOfPrefix,
        isPositive: isPositive,
        formattedDelta: absoluteDelta.formattedRatioValue,
        isChangeZero: absoluteDelta == 0,
        referenceLabel: referenceLabel,
      ),
      dynamicAvg: dynamicAvg,
    );
  }
}
