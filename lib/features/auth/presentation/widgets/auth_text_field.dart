import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconPath,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onVisibilityChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.borderRadius = 16,
    this.fillColor = AppColors.inputBackground,
    this.borderColor = AppColors.inputBorder,
  });

  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityChanged;
  final VoidCallback? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final double borderRadius;
  final Color fillColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor),
    );

    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(iconPath, width: 24, height: 24),
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Image.asset(
                    isPasswordVisible
                        ? AppAssets.authShowPasswordIcon
                        : AppAssets.authHidePasswordIcon,
                    width: 24,
                    height: 24,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: onVisibilityChanged,
                )
                : null,
        hintText: hintText,
        hintStyle: AppTextStyles.inputHint,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorMaxLines: 2,
      ),
      validator: validator,
    );
  }
}
