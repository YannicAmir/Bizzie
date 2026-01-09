import 'package:bizzie/app/themes/app_assets.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(iconPath, width: 24, height: 24),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Image.asset(
                  isPasswordVisible
                      ? AppAssets.authShowPasswordIcon
                      : AppAssets.authHidePasswordIcon,
                  width: 24,
                  height: 24,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: onVisibilityChanged,
              )
            : null,
        hintText: hintText,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        errorMaxLines: 2,
      ),
      validator: validator,
    );
  }
}
