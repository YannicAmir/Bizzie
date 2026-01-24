import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BizzieError extends StatelessWidget {
  final String title;
  final String message;
  final String mascotAssetPath;
  final VoidCallback? onRetry;
  final String retryButtonLabel;

  const BizzieError({
    super.key,
    this.title = 'Something went wrong',
    required this.message,
    this.mascotAssetPath = AppAssets.defaultMascot,
    this.onRetry,
    this.retryButtonLabel = 'Try Again',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              child: Image.asset(
                mascotAssetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.criticalText,
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(title, style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(retryButtonLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
