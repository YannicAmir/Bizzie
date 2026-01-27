import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/metric_summary_presentation_extensions.dart';
import 'package:intl/intl.dart';

class RoePresentationHelper {
  static ({
    String valueStr,
    String badgeText,
    AppBadgeStyle badgeStyle,
    String subtitle,
  })
  formatSummary({
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceLabel,
  }) {
    final valueStr = '${(currentValue * 100).toStringAsFixed(2)}%';
    final badgeText =
        '${growthPercentage > 0 ? '+' : ''}${growthPercentage.toStringAsFixed(1)}%';
    final badgeStyle = isPositive ? AppBadgeStyle.good : AppBadgeStyle.critical;

    final subtitle = MetricSummarySubtitleHelper.getSubtitle(
      asOfPrefix: '',
      isPositive: isPositive,
      formattedDelta: '${(absoluteDelta * 100).toStringAsFixed(2)}%',
      isChangeZero: absoluteDelta == 0,
      referenceLabel: referenceLabel,
    );

    return (
      valueStr: valueStr,
      badgeText: badgeText,
      badgeStyle: badgeStyle,
      subtitle: subtitle,
    );
  }

  static NumberFormat get chartFormatter =>
      NumberFormat("#,##0.00'%'", 'en_US');
}
