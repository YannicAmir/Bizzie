import 'package:bizzie/app/themes/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.iconPath,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onVisibilityChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.suffix,
    this.autovalidateMode,
  });

  final TextEditingController controller;
  final String hintText;
  final String? iconPath;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityChanged;
  final VoidCallback? onSubmitted;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSvg = iconPath?.endsWith('.svg') ?? false;

    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      style: theme.textTheme.bodyLarge,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: iconPath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: isSvg
                    ? SvgPicture.asset(
                        iconPath!,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      )
                    : Image.asset(iconPath!, width: 24, height: 24),
              )
            : null,
        suffixIcon:
            suffix ??
            (isPassword
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
                : null),
        hintText: hintText,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        errorMaxLines: 2,
      ),
      validator: validator,
    );
  }
}
