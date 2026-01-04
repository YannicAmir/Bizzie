import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/shared_widgets.dart';

class HistoricalDataCard extends StatelessWidget {
  const HistoricalDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Full historical data', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            'View complete financial history over time',
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yearly Revenue',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      _BarChartItem(label: "'17", height: 60),
                      _BarChartItem(label: "'18", height: 75),
                      _BarChartItem(label: "'19", height: 70),
                      _BarChartItem(label: "'20", height: 78),
                      _BarChartItem(label: "'21", height: 95),
                      _BarChartItem(label: "'22", height: 100),
                      _BarChartItem(label: "'23", height: 95),
                      _BarChartItem(label: "'24", height: 110),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, color: AppColors.slate100),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '5-Year CAGR',
                      style: AppTextStyles.smallLink.copyWith(
                        fontSize: 13,
                        color: AppColors.slate500,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'HIGH',
                            style: AppTextStyles.smallLink.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.green800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '+7.1%',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green800,
                          ),
                        ),
                      ],
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

class _BarChartItem extends StatelessWidget {
  final String label;
  final double height;

  const _BarChartItem({required this.label, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.blue500,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class FinancialReportAlertsCard extends StatelessWidget {
  const FinancialReportAlertsCard({
    super.key,
    this.primaryAlert,
    this.secondaryAlert,
  });

  final Brand? primaryAlert;
  final Brand? secondaryAlert;

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Financial report alerts', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            'Get notified when reports are released',
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
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.slate100, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.blueGradientStart,
                              AppColors.indigoPrimary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Image.asset(AppAssets.bellIcon),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming Reports',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'From your watchlist',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _AlertItem(
                  companyName: primaryAlert?.company ?? 'Netflix',
                  ticker: primaryAlert?.ticker ?? 'NFLX',
                  status: 'Q1 Earnings',
                  timeAgo: '1 week',
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: AppColors.slate100),
                const SizedBox(height: 16),
                _AlertItem(
                  companyName: secondaryAlert?.company ?? 'Microsoft',
                  ticker: secondaryAlert?.ticker ?? 'MSFT',
                  status: 'Q1 Earnings',
                  timeAgo: 'Today',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final String companyName;
  final String ticker;
  final String status;
  final String timeAgo;

  const _AlertItem({
    required this.companyName,
    required this.ticker,
    required this.status,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    companyName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.slate300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    ticker,
                    style: AppTextStyles.smallLink.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    status,
                    style: AppTextStyles.smallLink.copyWith(
                      color: AppColors.slate500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          timeAgo,
          style: AppTextStyles.smallTimeAgo.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
