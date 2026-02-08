import 'package:flutter/material.dart';

class ProfileFieldWithHeader extends StatelessWidget {
  final String header;
  final Widget child;
  final double bottomMargin;

  const ProfileFieldWithHeader({
    super.key,
    required this.header,
    required this.child,
    this.bottomMargin = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            header,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        child,
        SizedBox(height: bottomMargin),
      ],
    );
  }
}
