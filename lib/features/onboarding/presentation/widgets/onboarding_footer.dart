import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final bool shiftDown;
  final double? fixedTextHeight;

  const OnboardingFooter({
    super.key,
    this.title,
    this.subtitle,
    this.primaryButton,
    this.secondaryButton,
    this.shiftDown = false,
    this.fixedTextHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Text(
            title!,
            style: theme.textTheme.displayLarge,
            textAlign: TextAlign.left,
          ),
        if (subtitle != null) ...[
          if (title != null) const SizedBox(height: 8),
          Text(
            subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ],
    );

    if (fixedTextHeight != null) {
      textContent = SizedBox(
        height: fixedTextHeight,
        child: Align(alignment: Alignment.topLeft, child: textContent),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (shiftDown) const SizedBox(height: 16),
          textContent,
          if (title != null || subtitle != null) const SizedBox(height: 48),
          if (primaryButton != null) ...[
            SizedBox(width: double.infinity, height: 56, child: primaryButton),
          ],
          if (primaryButton != null && secondaryButton != null)
            const SizedBox(height: 16),
          if (secondaryButton != null) secondaryButton!,
          if (!shiftDown) const SizedBox(height: 16),
        ],
      ),
    );
  }
}
