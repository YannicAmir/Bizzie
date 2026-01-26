import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';

class FeatureHighlightCard extends StatelessWidget {
  final Widget child;

  const FeatureHighlightCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.mascotBackground, AppColors.mascotCardGradientEnd],
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(24.0), child: child),
    );
  }
}

class SummaryIllustration extends StatelessWidget {
  final String currentYear;

  const SummaryIllustration({super.key, required this.currentYear});

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('AI analysis of financial reports', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            'Deep insights from quarterly and annual reports',
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
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.slate100),
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
                        child: Image.asset(
                          AppAssets.sparkleIcon,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '10-K Annual Report',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'FY ${DateTime.now().year}',
                            style: AppTextStyles.smallLink.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                _BulletPoint(
                  text:
                      'Revenue grew 13% YoY to \$24.2B, driven by increased in units sold',
                  isPositive: true,
                ),
                const SizedBox(height: 8),
                _BulletPoint(
                  text: 'Free cash flow of \$5.5B, up 7% YoY',
                  isPositive: true,
                ),
                const SizedBox(height: 8),
                _BulletPoint(
                  text:
                      'Net income declined 2% YoY due to increased COGS and R&D expenses',
                  isPositive: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  final bool isPositive;

  const _BulletPoint({required this.text, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isPositive ? AppColors.green100 : AppColors.red100;
    final Color iconColor = isPositive ? AppColors.green800 : AppColors.red800;
    final String iconAsset = isPositive
        ? AppAssets.arrowUpIcon
        : AppAssets.arrowDownIcon;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            padding: const EdgeInsets.all(5),
            child: Image.asset(iconAsset, color: iconColor),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              height: 1.5,
              letterSpacing: -0.15,
              color: AppColors.brandChipOtherForeground,
            ),
          ),
        ),
      ],
    );
  }
}

class BrandSearchCard extends StatelessWidget {
  final Brand displayBrand;

  const BrandSearchCard({super.key, required this.displayBrand});

  @override
  Widget build(BuildContext context) {
    return FeatureHighlightCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('Search brands, get stocks', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            "Search products to see if they're owned by stock market companies",
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate200),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.searchIcon,
                  width: 20,
                  height: 20,
                  color: AppColors.slate500,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    displayBrand.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 1),
                Container(width: 1.5, height: 18, color: AppColors.blue500),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.brandChipSelectedBackground,
                        AppColors.indigo100,
                      ],
                    ),
                  ),
                  child: Center(
                    child: displayBrand.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              displayBrand.imageUrl!,
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _BrandFallbackLogo(name: displayBrand.name),
                            ),
                          )
                        : _BrandFallbackLogo(name: displayBrand.name),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayBrand.company,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        displayBrand.ticker,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.slate500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.trending_up,
                  color: AppColors.green600,
                  size: 20,
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandFallbackLogo extends StatelessWidget {
  final String name;

  const _BrandFallbackLogo({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name.isNotEmpty ? name[0] : 'B',
      style: AppTextStyles.h3.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.slate800,
      ),
    );
  }
}
