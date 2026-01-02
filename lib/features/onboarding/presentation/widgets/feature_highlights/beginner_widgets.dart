import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/sector_extensions.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/shared_widgets.dart';

class EasyToUnderstandCard extends StatelessWidget {
  const EasyToUnderstandCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('Easy to understand', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            "See if metrics are high or low at a glance",
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowCard,
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Column(
              children: [
                _MetricRow(
                  label: 'P/FCF Ratio',
                  valueWidget: Text(
                    '35.5',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  badgeText: 'HIGH',
                  badgeStyle: AppBadgeStyle.issue,
                ),
                const SizedBox(height: 8),
                _MetricRow(
                  label: 'P/E Ratio',
                  valueWidget: Text(
                    '34.5',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  badgeText: 'HIGH',
                  badgeStyle: AppBadgeStyle.issue,
                ),
                const SizedBox(height: 8),
                _MetricRow(
                  label: 'Revenue Growth',
                  valueWidget: Row(
                    children: [
                      Text(
                        '+8.2%',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'YoY',
                        style: AppTextStyles.smallLink.copyWith(
                          color: AppColors.slate500,
                        ),
                      ),
                    ],
                  ),
                  badgeText: 'HIGH',
                  badgeStyle: AppBadgeStyle.good,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label;
  final Widget valueWidget;
  final String badgeText;
  final AppBadgeStyle badgeStyle;

  const _MetricRow({
    required this.label,
    required this.valueWidget,
    required this.badgeText,
    required this.badgeStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 13,
                  color: AppColors.slate500,
                ),
              ),
              const SizedBox(height: 4),
              valueWidget,
            ],
          ),
          AppBadge(text: badgeText, style: badgeStyle),
        ],
      ),
    );
  }
}

class DailyPicksCard extends StatelessWidget {
  final Sector? selectedSector;
  final List<Brand> selectedBrands;

  const DailyPicksCard({
    super.key,
    this.selectedSector,
    this.selectedBrands = const [],
  });

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text("Get Bizzie's research lists", style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            "Curated research picks just for you",
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowCard,
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        selectedSector?.mascotAsset ??
                            AppAssets.onboardingBizzieMascot,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Review",
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'See what Bizzie is researching today!',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 13,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: AppColors.slate100),
                  const SizedBox(height: 16),
                  ...selectedBrands.map((brand) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _StockPickItem(
                        symbol: brand.ticker,
                        name: brand.company,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StockPickItem extends StatelessWidget {
  final String symbol;
  final String name;

  const _StockPickItem({required this.symbol, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              symbol,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              name,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 13,
                color: AppColors.slate500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'See products',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 13,
                color: AppColors.slate500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.slate400,
            ),
          ],
        ),
      ],
    );
  }
}
