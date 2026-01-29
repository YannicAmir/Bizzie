import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/metric_summary_presentation_extensions.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:intl/intl.dart';

class SharesPresentationHelper {
  static ({
    String valueStr,
    String badgeText,
    AppBadgeStyle badgeStyle,
    String subtitle,
  })
  formatSummary(SharesSummaryData summary, NumberFormat numberFormat) {
    final badgeStyle = summary.isPositive
        ? AppBadgeStyle.critical
        : AppBadgeStyle.good;

    final valueStr = numberFormat.format(summary.currentValue);

    final badgeText =
        '${summary.growthPercentage > 0 ? '+' : ''}${summary.growthPercentage.toStringAsFixed(1)}%';

    final subtitle = MetricSummarySubtitleHelper.getSubtitle(
      asOfPrefix: '',
      isPositive: summary.isPositive,
      formattedDelta: numberFormat.format(summary.absoluteDelta),
      isChangeZero: summary.absoluteDelta == 0,
      referenceLabel: summary.referenceLabel,
    );

    return (
      valueStr: valueStr,
      badgeText: badgeText,
      badgeStyle: badgeStyle,
      subtitle: subtitle,
    );
  }
}
