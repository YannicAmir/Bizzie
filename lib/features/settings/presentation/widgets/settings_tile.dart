import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: titleColor ?? colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 16),
              trailing!,
            ] else if (onTap != null) ...[
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
