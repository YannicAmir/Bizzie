import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:flutter/material.dart';

class DiscountPlanBox extends StatelessWidget {
  final SubscriptionPackage? package;
  final String? standardAnnualPriceText;
  final String savingsPercentageText;

  const DiscountPlanBox({
    super.key,
    this.package,
    this.standardAnnualPriceText,
    required this.savingsPercentageText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String priceText = package?.priceString ?? '\$...';
    final String monthlyEquivalent = package != null
        ? '\$${(package!.price / 12).toStringAsFixed(0)}'
        : '\$...';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.primary, width: 2),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Annual Plan',
                  style: AppTextStyles.bodyLargeBold.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (package == null) ...[
                const _UnavailableOfferMessage(),
              ] else ...[
                const SizedBox(height: 16),
                _DiscountSavingsRow(
                  standardPrice: standardAnnualPriceText,
                  savingsText: savingsPercentageText,
                ),
                _MainPriceDisplay(priceText: priceText),
                const SizedBox(height: 16),
                _MonthlyEquivalentBox(text: monthlyEquivalent),
              ],
            ],
          ),
        ),
        _FloatingSaveBadge(savingsText: savingsPercentageText),
      ],
    );
  }
}

class _UnavailableOfferMessage extends StatelessWidget {
  const _UnavailableOfferMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'Offer currently unavailable',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }
}

class _DiscountSavingsRow extends StatelessWidget {
  final String? standardPrice;
  final String savingsText;

  const _DiscountSavingsRow({
    required this.standardPrice,
    required this.savingsText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (standardPrice != null) ...[
          Text(
            standardPrice!,
            style: AppTextStyles.h3.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            savingsText,
            style: AppTextStyles.bodySmallBold.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MainPriceDisplay extends StatelessWidget {
  final String priceText;

  const _MainPriceDisplay({required this.priceText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: priceText,
            style: AppTextStyles.h1.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 48,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: '/ year',
            style: AppTextStyles.h3.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyEquivalentBox extends StatelessWidget {
  final String text;

  const _MonthlyEquivalentBox({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Just $text / month',
        style: AppTextStyles.bodyLargeBold.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _FloatingSaveBadge extends StatelessWidget {
  final String savingsText;

  const _FloatingSaveBadge({required this.savingsText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      top: -12,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.discountBadgeBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'SAVE ${savingsText.replaceAll('-', '')}',
            style: AppTextStyles.bodySmallBold.copyWith(
              color: theme.colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
