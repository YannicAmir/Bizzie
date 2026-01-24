import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

class MetricSummaryCard extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;
  final String? badgeText;
  final AppBadgeStyle? badgeStyle;
  final String subtitle;

  const MetricSummaryCard({
    super.key,
    required this.title,
    this.value,
    this.valueWidget,
    this.badgeText,
    this.badgeStyle,
    required this.subtitle,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h3),
                  const SizedBox(height: 4),
                  if (valueWidget != null)
                    valueWidget!
                  else if (value != null)
                    Text(value!, style: AppTextStyles.h3),
                ],
              ),
              if (badgeText != null && badgeStyle != null)
                AppBadge(text: badgeText!, style: badgeStyle!, isLarge: true),
            ],
          ),
          AppConstants.subSectionSpacing,
          Text(subtitle, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
