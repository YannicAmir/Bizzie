import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BizzieEmptyState extends StatelessWidget {
  final String message;
  final String? title;
  final String mascotAsset;
  final bool isFullPage;

  const BizzieEmptyState({
    super.key,
    required this.message,
    this.title,
    this.mascotAsset = AppAssets.defaultMascot,
    this.isFullPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: isFullPage ? 180 : 120,
            child: Image.asset(mascotAsset, fit: BoxFit.contain),
          ),
          const SizedBox(height: 32),
          if (title != null) ...[
            Text(title!, style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 16),
          ],
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    return Center(child: content);
  }
}
