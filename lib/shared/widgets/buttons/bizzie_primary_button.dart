import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class BizziePrimaryButton extends StatelessWidget {
  const BizziePrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = AppConstants.mainButtonHeight,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: theme.colorScheme.primary.withValues(
            alpha: 0.5,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: theme.colorScheme.onPrimary,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                title,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }
}
