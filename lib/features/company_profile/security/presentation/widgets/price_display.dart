import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/badge_theme_extensions.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/shared/widgets/animations/price_tick_flash.dart';
import 'package:flutter/material.dart';

const double _priceToChangeSpacing = 12;
const double _arrowToChangeSpacing = 4;
const double _changeArrowIconSize = 20;

class PriceDisplay extends StatelessWidget {
  final String formattedPrice;
  final double? price;
  final String change;
  final bool isPositive;
  final String lastUpdated;

  const PriceDisplay({
    super.key,
    required this.formattedPrice,
    this.price,
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
            PriceTickFlash(
              price: price,
              text: formattedPrice,
              builder: (context, tick) =>
                  PriceTickText(tick: tick, style: AppTextStyles.h3),
            ),
            const SizedBox(width: _priceToChangeSpacing),
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
    final badgeTheme = Theme.of(context).extension<BadgeThemeExtension>();
    final color = isPositive
        ? badgeTheme.goodTextOrDefault
        : badgeTheme.criticalTextOrDefault;
    return Row(
      children: [
        Transform.flip(
          flipY: !isPositive,
          child: Image.asset(
            AppAssets.arrowUpIcon,
            width: _changeArrowIconSize,
            height: _changeArrowIconSize,
            color: color,
          ),
        ),
        const SizedBox(width: _arrowToChangeSpacing),
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
