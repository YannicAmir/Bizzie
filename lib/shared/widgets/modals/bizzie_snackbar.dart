import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:material_ui/material_ui.dart';

enum BizzieSnackBarType { neutral, error, success, brand }

class BizzieSnackBar {
  const BizzieSnackBar._();

  static const _defaultDuration = Duration(seconds: 4);

  static void show(
    BuildContext context, {
    required String message,
    BizzieSnackBarType type = BizzieSnackBarType.neutral,
    Duration duration = _defaultDuration,
  }) {
    final theme = Theme.of(context);

    final backgroundColor = switch (type) {
      BizzieSnackBarType.error => theme.colorScheme.error,
      BizzieSnackBarType.success => theme.colorScheme.surfaceBright,
      BizzieSnackBarType.neutral => theme.snackBarTheme.backgroundColor,
      BizzieSnackBarType.brand => theme.colorScheme.inverseSurface,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: type == BizzieSnackBarType.brand ? TextAlign.center : null,
          style: AppTextStyles.bodyLargeBold.copyWith(
            color: theme.colorScheme.surface,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
