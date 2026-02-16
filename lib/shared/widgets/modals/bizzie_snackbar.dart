import 'package:flutter/material.dart';

enum BizzieSnackBarType { neutral, error, success }

class BizzieSnackBar {
  const BizzieSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    BizzieSnackBarType type = BizzieSnackBarType.neutral,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context);

    Color? backgroundColor;
    switch (type) {
      case BizzieSnackBarType.error:
        backgroundColor = theme.colorScheme.error;
        break;
      case BizzieSnackBarType.success:
        backgroundColor = theme.colorScheme.surfaceBright;
        break;
      case BizzieSnackBarType.neutral:
        backgroundColor = theme.snackBarTheme.backgroundColor;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
