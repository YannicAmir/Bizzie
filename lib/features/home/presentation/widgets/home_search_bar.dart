import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const HomeSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.inputBorder, width: 0.665),
        ),
        child: Row(
          children: [
            Image.asset(AppAssets.searchIconLarge, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              'Search',
              style: AppTextStyles.inputHint.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
