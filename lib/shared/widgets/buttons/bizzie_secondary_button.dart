import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BizzieSecondaryButton extends StatelessWidget {
  const BizzieSecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 56,
  });

  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.slate100,
          foregroundColor: AppColors.slate700,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyles.button.copyWith(color: AppColors.slate700),
        ),
      ),
    );
  }
}
