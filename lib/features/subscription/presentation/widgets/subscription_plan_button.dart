import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:flutter/material.dart';

class SubscriptionPlanButton extends StatelessWidget {
  final SubscriptionPackage? package;
  final String title;
  final bool isSelected;
  final String? badgeText;
  final VoidCallback onTap;

  const SubscriptionPlanButton({
    super.key,
    required this.package,
    required this.title,
    required this.isSelected,
    this.badgeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasTrial = package?.isEligibleForTrial ?? false;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            package?.priceString ?? '---',
                            style: theme.textTheme.displayMedium,
                          ),
                          if (package != null && !package!.isMonthly) ...[
                            const SizedBox(width: 8),
                            Text(
                              '(${package!.pricePerMonthString} / mo)',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (hasTrial) ...[
                        const SizedBox(height: 8),
                        Text(
                          '7-Day Free Trial',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: theme.colorScheme.surface,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: -10,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.surface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
