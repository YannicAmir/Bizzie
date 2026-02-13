import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String assetPath;

  const ProfileAvatar({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: CircleAvatar(
        backgroundColor: theme.colorScheme.surface,
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }
}
