import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_stock_price_extensions.dart';
import 'package:bizzie/features/home/presentation/widgets/watchlist_mini_price_chart.dart';
import 'package:bizzie/shared/models/price_tick.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/animations/price_tick_flash.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';

const double _chartWidth = 64;
const double _chartHeight = 32;
const double _chartHorizontalPadding = 10;
const double _chartToPriceSpacing = 12;
const double _priceToChangeSpacing = 4;
const String _priceCurrency = 'USD';
const double _flashBoxFillOpacity = 0.12;
const double _flashBoxBorderWidth = 1;
const double _flashBoxBorderRadius = 8;
const EdgeInsets _flashBoxPadding = EdgeInsets.symmetric(
  horizontal: 6,
  vertical: 2,
);

class WatchlistPriceTrailing extends StatelessWidget {
  final WatchlistStockPrice stockPrice;

  const WatchlistPriceTrailing({super.key, required this.stockPrice});

  @override
  Widget build(BuildContext context) {
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
            PriceTickFlash(
              key: ValueKey(stockPrice.ticker),
              price: stockPrice.price,
              text: CurrencyFormatter.format(stockPrice.price, _priceCurrency),
              builder: (context, tick) => _PriceFlashBox(
                tick: tick,
                child: PriceTickText(
                  tick: tick,
                  style: AppTextStyles.bodyLargeBold,
                ),
              ),
            ),
            const SizedBox(height: _priceToChangeSpacing),
            AppBadge(
              text: stockPrice.formattedChangePercent,
              style: switch (stockPrice.changePercent) {
                null => AppBadgeStyle.muted,
                _ when stockPrice.hasPositiveChange => AppBadgeStyle.goodSolid,
                _ => AppBadgeStyle.criticalSolid,
              },
              isLarge: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceFlashBox extends StatelessWidget {
  final PriceTick tick;
  final Widget child;

  const _PriceFlashBox({required this.tick, required this.child});

  @override
  Widget build(BuildContext context) {
    final flashColor =
        (tick.isFlashing ? tick.flashColor : null) ?? AppColors.transparent;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: flashColor.withValues(
          alpha: flashColor.a * _flashBoxFillOpacity * tick.intensity,
        ),
        border: Border.all(
          color: flashColor.withValues(alpha: flashColor.a * tick.intensity),
          width: _flashBoxBorderWidth,
        ),
        borderRadius: BorderRadius.circular(_flashBoxBorderRadius),
      ),
      child: Padding(padding: _flashBoxPadding, child: child),
    );
  }
}
