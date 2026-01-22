import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/enums/ratio_category.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/presentation/utils/market_cap_category_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/utils/ratio_category_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

class KeyMetricsSection extends StatelessWidget {
  final SecurityDetails details;

  const KeyMetricsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Metrics', style: AppTextStyles.h3),
          AppConstants.secondarySectionSpacing,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetricItem(
                label: 'Market Cap',
                value: CurrencyFormatter.formatCompact(
                  details.marketCap ?? 0,
                  '\$',
                ),
                badge: AppBadge(
                  text: details.marketCapCategory.label,
                  style: AppBadgeStyle.neutral,
                  isLarge: true,
                ),
                alignment: CrossAxisAlignment.start,
              ),
              const SizedBox(width: 8),
              _MetricItem(
                label: 'PE TTM',
                value: details.peRatioTTM?.toStringAsFixed(2) ?? '-',
                badge: AppBadge(
                  text: details.peRatioCategory == RatioCategory.negative
                      ? 'Neg. EPS'
                      : details.peRatioCategory.label,
                  style: details.peRatioCategory.badgeStyle,
                  isLarge: true,
                ),
                alignment: CrossAxisAlignment.center,
              ),
              const SizedBox(width: 8),
              _MetricItem(
                label: 'PFCF TTM',
                value:
                    details.priceToFreeCashFlowTTM?.toStringAsFixed(2) ?? '-',
                badge: AppBadge(
                  text: details.pfcfRatioCategory == RatioCategory.negative
                      ? 'Neg. FCF'
                      : details.pfcfRatioCategory.label,
                  style: details.pfcfRatioCategory.badgeStyle,
                  isLarge: true,
                ),
                alignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final Widget? badge;
  final CrossAxisAlignment alignment;

  const _MetricItem({
    required this.label,
    required this.value,
    this.badge,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMediumBoldSecondary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppConstants.subSectionSpacing,
          Text(
            value,
            style: AppTextStyles.bodyLargeBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (badge != null) ...[AppConstants.subSectionSpacing, badge!],
        ],
      ),
    );
  }
}
