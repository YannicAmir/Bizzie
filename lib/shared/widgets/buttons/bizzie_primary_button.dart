import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BizziePrimaryButton extends StatelessWidget {
  const BizziePrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 54,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: AppColors.black.withValues(alpha: 0.1),
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                title,
                style: AppTextStyles.button.copyWith(color: AppColors.white),
              ),
      ),
    );
  }
}
