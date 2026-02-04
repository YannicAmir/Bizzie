import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:flutter/material.dart';

class SavingsSummaryCard extends StatelessWidget {
  final SubscriptionPackage? package;
  final String totalSavingsText;

  const SavingsSummaryCard({
    super.key,
    this.package,
    required this.totalSavingsText,
  });

  @override
  Widget build(BuildContext context) {
    if (package == null || totalSavingsText.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: badgeTheme?.goodBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeTheme?.goodText ?? Colors.transparent),
      ),
      child: Column(
        children: [
          Text(
            'You save $totalSavingsText with this offer!',
            style: AppTextStyles.bodyMediumBold.copyWith(
              color: badgeTheme?.goodText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Subscribe now to enjoy Bizzie Plus',
            style: AppTextStyles.bodyMedium.copyWith(
              color: badgeTheme?.goodText,
            ),
          ),
        ],
      ),
    );
  }
}
