import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_stock_price_extensions.dart';
import 'package:bizzie/features/home/presentation/widgets/watchlist_mini_price_chart.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

const double _chartWidth = 64;
const double _chartHeight = 32;
const double _chartHorizontalPadding = 10;
const double _chartToPriceSpacing = 12;
const double _priceToChangeSpacing = 4;
const String _priceCurrency = 'USD';

class WatchlistPriceTrailing extends StatelessWidget {
  final WatchlistStockPrice stockPrice;

  const WatchlistPriceTrailing({super.key, required this.stockPrice});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final changeColor = stockPrice.hasPositiveChange
        ? (badgeTheme?.goodText ?? AppColors.goodText)
        : (badgeTheme?.criticalText ?? AppColors.criticalText);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _chartHorizontalPadding,
          ),
          child: SizedBox(
            width: _chartWidth,
            height: _chartHeight,
            child: WatchlistMiniPriceChart(stockPrice: stockPrice),
          ),
        ),
        const SizedBox(width: _chartToPriceSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              CurrencyFormatter.format(stockPrice.price, _priceCurrency),
              style: AppTextStyles.bodyLargeBold,
            ),
            const SizedBox(height: _priceToChangeSpacing),
            Text(
              stockPrice.formattedChangePercent,
              style: AppTextStyles.bodyMedium.copyWith(color: changeColor),
            ),
          ],
        ),
      ],
    );
  }
}
