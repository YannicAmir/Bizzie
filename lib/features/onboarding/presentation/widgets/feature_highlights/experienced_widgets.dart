import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/shared_widgets.dart';

class VisualFinancialsCard extends StatelessWidget {
  const VisualFinancialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Visual financials', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            'Understand company performance with charts',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowCard,
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quarterly Revenue',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      _VisualChartBar(label: 'Q1', heightFactor: 0.6),
                      _VisualChartBar(label: 'Q2', heightFactor: 0.75),
                      _VisualChartBar(label: 'Q3', heightFactor: 0.85),
                      _VisualChartBar(label: 'Q4', heightFactor: 1.0),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, color: AppColors.slate100),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'YoY Growth',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.slate500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.trending_up,
                      size: 16,
                      color: AppColors.green800,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+13.2%',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.green800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VisualChartBar extends StatelessWidget {
  final String label;
  final double heightFactor;

  const _VisualChartBar({required this.label, required this.heightFactor});

  @override
  Widget build(BuildContext context) {
    const double maxBarHeight = 100.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: maxBarHeight * heightFactor,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.blueGradientStart, AppColors.graphBlueAccent],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.slate500,
          ),
        ),
      ],
    );
  }
}
