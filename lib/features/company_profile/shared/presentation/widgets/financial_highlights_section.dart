import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class FinancialHighlightsSection extends StatelessWidget {
  final List<FinancialDataPoint> annualData;
  final List<FinancialDataPoint> quarterlyData;
  final String ttmTitle;
  final String currency;
  final bool isAnnual;

  const FinancialHighlightsSection({
    super.key,
    required this.annualData,
    required this.quarterlyData,
    required this.ttmTitle,
    required this.currency,
    this.isAnnual = true,
  });

  @override
  Widget build(BuildContext context) {
    final highlights = FinancialHighlightsResolver.resolve(
      annualData: annualData,
      quarterlyData: quarterlyData,
      ttmTitle: ttmTitle,
      currency: currency,
      isAnnual: isAnnual,
      locale: Localizations.localeOf(context).toString(),
    );
    if (highlights == null) return const SizedBox.shrink();

    final secondary = highlights.secondary;

    return Row(
      children: [
        Expanded(child: _HighlightCard(data: highlights.primary)),
        if (secondary != null) ...[
          AppConstants.subSectionHorizontalSpacing,
          Expanded(child: _HighlightCard(data: secondary)),
        ],
      ],
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final HighlightCardData data;

  const _HighlightCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = data.backgroundColor;

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: backgroundColor ?? theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(data.title, style: AppTextStyles.bodyMediumBoldSecondary),
          AppConstants.subSectionSpacing,
          Text(
            data.valueText,
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: data.valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
