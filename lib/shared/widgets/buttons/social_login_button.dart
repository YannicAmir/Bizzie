import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconAsset;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? textColor;
  final bool isLoading;
  final VoidCallback? onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconAsset,
    required this.backgroundColor,
    required this.foregroundColor,
    this.textColor,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveTextColor = textColor ?? foregroundColor;

    return SizedBox(
      width: double.infinity,
      height: AppConstants.mainButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: backgroundColor == theme.colorScheme.surface
                ? BorderSide(color: theme.colorScheme.outlineVariant)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: foregroundColor,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconAsset,
                    height: 24,
                    color: foregroundColor == theme.colorScheme.surface
                        ? theme.colorScheme.surface
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: effectiveTextColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
