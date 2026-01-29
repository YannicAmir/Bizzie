import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/metric_summary_card.dart';
import 'package:bizzie/features/company_profile/dividends/domain/extensions/dividend_event_extensions.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/utils/dividend_formatters.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DividendOverviewSection extends StatelessWidget {
  final DividendEvent latestEvent;
  final List<DividendEvent> history;
  final double currentPrice;

  const DividendOverviewSection({
    super.key,
    required this.latestEvent,
    required this.history,
    required this.currentPrice,
  });

  @override
  Widget build(BuildContext context) {
    final annualDiv = latestEvent.isStale
        ? 0.0
        : latestEvent.annualizedDividend;
    final yieldVal = latestEvent.isStale
        ? 0.0
        : latestEvent.calculateYield(currentPrice: currentPrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MetricSummaryCard(
          title: 'Forward Dividend & Yield',
          valueWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$${annualDiv.toStringAsFixed(2)}',
                style: AppTextStyles.bodyLargeBold,
              ),
              AppConstants.subSectionHorizontalSpacing,
              Text(
                '(${yieldVal.toStringAsFixed(2)}%)',
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          subtitle: 'Annual dividend per share',
        ),
        AppConstants.mainSectionSpacing,
        _DividendDatesRow(event: latestEvent),
        AppConstants.subSectionSpacing,
        _DividendGrowthRow(history: history),
      ],
    );
  }
}

class _DividendGrowthRow extends StatelessWidget {
  final List<DividendEvent> history;

  const _DividendGrowthRow({required this.history});

  @override
  Widget build(BuildContext context) {
    final latest = history.first;
    final previous = history.length > 1 ? history[1] : null;
    final growth = latest.calculateGrowthRate(previous);
    final latestAmount = DividendFormatters.formatAmount(latest.dividend);
    final latestDate = DividendFormatters.formatDate(latest.date);
    final growthStr = DividendFormatters.formatGrowthRate(growth);
    final growthColor = growth >= 0
        ? AppColors.goodText
        : AppColors.criticalText;

    return Row(
      children: [
        Expanded(
          child: _DateCard(
            title: 'Latest Div.',
            value: latestAmount,
            subtitle: latestDate,
          ),
        ),
        AppConstants.subSectionHorizontalSpacing,
        Expanded(
          child: _DateCard(
            title: 'Growth Rate',
            value: growthStr,
            subtitle: 'vs previous quarter',
            valueColor: growthColor,
          ),
        ),
      ],
    );
  }
}

class _DividendDatesRow extends StatelessWidget {
  final DividendEvent event;

  const _DividendDatesRow({required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DateCard(
            title: 'Ex-Div. Date',
            value: event.date,
            subtitle: 'Last day to purchase',
          ),
        ),
        AppConstants.subSectionHorizontalSpacing,
        Expanded(
          child: _DateCard(
            title: 'Div. Payout Date',
            value: event.paymentDate ?? 'N/A',
            subtitle: 'Payment distribution',
          ),
        ),
      ],
    );
  }
}

class _DateCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color? valueColor;

  const _DateCard({
    required this.title,
    required this.value,
    required this.subtitle,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: AppConstants.dateCardHeight,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMediumBoldSecondary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppConstants.subSectionSpacing,
          Text(
            DividendFormatters.formatDisplayValue(value),
            style: AppTextStyles.bodyLargeBold,
          ),
          AppConstants.subSectionSpacing,
          Text(subtitle, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
