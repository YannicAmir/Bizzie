import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter/material.dart';

class PriceDisplay extends StatelessWidget {
  final String price;
  final String change;
  final bool isPositive;
  final String lastUpdated;

  const PriceDisplay({
    super.key,
    required this.price,
    required this.change,
    required this.isPositive,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(price, style: AppTextStyles.h3),
            const SizedBox(width: 12),
            _PriceChangeIndicator(change: change, isPositive: isPositive),
          ],
        ),
        AppConstants.subSectionSpacing,
        _LastUpdatedText(dateStr: lastUpdated),
      ],
    );
  }
}

class _PriceChangeIndicator extends StatelessWidget {
  final String change;
  final bool isPositive;

  const _PriceChangeIndicator({required this.change, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppColors.goodText : AppColors.criticalText;
    return Row(
      children: [
        Transform.flip(
          flipY: !isPositive,
          child: Image.asset(
            AppAssets.arrowUpIcon,
            width: 20,
            height: 20,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(change, style: AppTextStyles.bodyLargeBold.copyWith(color: color)),
      ],
    );
  }
}

class _LastUpdatedText extends StatelessWidget {
  final String dateStr;

  const _LastUpdatedText({required this.dateStr});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Last updated: ${BizzieDateFormatter.formatLastUpdated(dateStr)}',
      style: AppTextStyles.bodySmallSecondary,
    );
  }
}
