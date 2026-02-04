import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_package_extensions.dart';
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
    final hasTrial = package?.isEligibleForTrial ?? false;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        _PlanButtonContainer(
          isSelected: isSelected,
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: _PlanInfoColumn(
                  title: title,
                  package: package,
                  hasTrial: hasTrial,
                ),
              ),
              if (isSelected) const _SelectionIndicator(),
            ],
          ),
        ),
        if (badgeText != null) _PlanBadge(text: badgeText!),
      ],
    );
  }
}

class _PlanButtonContainer extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  const _PlanButtonContainer({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
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
        child: child,
      ),
    );
  }
}

class _PlanInfoColumn extends StatelessWidget {
  final String title;
  final SubscriptionPackage? package;
  final bool hasTrial;

  const _PlanInfoColumn({
    required this.title,
    required this.package,
    required this.hasTrial,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
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
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check, color: theme.colorScheme.surface, size: 20),
    );
  }
}

class _PlanBadge extends StatelessWidget {
  final String text;

  const _PlanBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      top: -10,
      right: 24,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
