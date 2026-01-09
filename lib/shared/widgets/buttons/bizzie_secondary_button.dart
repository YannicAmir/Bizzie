import 'package:flutter/material.dart';

class BizzieSecondaryButton extends StatelessWidget {
  const BizzieSecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 56,
  });

  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          foregroundColor: theme.colorScheme.onSurfaceVariant,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
