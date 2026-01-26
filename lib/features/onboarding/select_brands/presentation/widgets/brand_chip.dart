import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrandChip extends StatelessWidget {
  final Brand brand;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final IconData? iconData;
  final bool leadingIcon;
  final bool isEnabled;
  final VoidCallback? onTap;

  const BrandChip({
    super.key,
    required this.brand,
    required this.backgroundColor,
    required this.foregroundColor,
    this.iconData,
    this.leadingIcon = false,
    this.isEnabled = true,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveBackgroundColor = isEnabled
        ? backgroundColor
        : Colors.grey.shade100;
    final effectiveForegroundColor = isEnabled
        ? foregroundColor
        : Colors.grey.shade400;
    final effectiveIcon = isEnabled ? iconData : null;
    final effectiveBorder = isEnabled ? borderColor : null;

    return GestureDetector(
      onTap: () {
        if (onTap != null && isEnabled) {
          HapticFeedback.lightImpact();
          onTap!();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(100),
          border: effectiveBorder != null
              ? Border.all(color: effectiveBorder, width: 0.665)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon && effectiveIcon != null) ...[
              Icon(effectiveIcon, size: 20, color: effectiveForegroundColor),
              const SizedBox(width: 4),
            ],
            Text(
              brand.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: effectiveForegroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (!leadingIcon && effectiveIcon != null) ...[
              const SizedBox(width: 8),
              Icon(effectiveIcon, size: 20, color: effectiveForegroundColor),
            ],
          ],
        ),
      ),
    );
  }
}
