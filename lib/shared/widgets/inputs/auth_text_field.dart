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
    this.errorText,
    this.enabled,
    this.hideReadOnlyFocus = false,
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
  final String? errorText;
  final bool? enabled;
  final bool hideReadOnlyFocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSvg = iconPath?.endsWith('.svg') ?? false;

    final hiddenBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: hideReadOnlyFocus && readOnly
            ? theme.colorScheme.outline
            : theme.colorScheme.primary,
        width: hideReadOnlyFocus && readOnly ? 1.0 : 1.5,
      ),
    );

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
      enabled: enabled,
      decoration: InputDecoration(
        errorText: errorText,
        counterText: '',
        focusedBorder: hideReadOnlyFocus && readOnly ? hiddenBorder : null,
        prefixIcon: iconPath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: isSvg
                    ? SvgPicture.asset(
                        iconPath!,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onTertiary,
                          BlendMode.srcIn,
                        ),
                      )
                    : Image.asset(iconPath!, width: 24, height: 24),
              )
            : null,
        suffixIcon:
            suffix ??
            (isPassword
                ? _PasswordToggle(
                    isVisible: isPasswordVisible,
                    onToggle: onVisibilityChanged,
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

class _PasswordToggle extends StatelessWidget {
  const _PasswordToggle({required this.isVisible, required this.onToggle});

  final bool isVisible;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: SvgPicture.asset(
        isVisible
            ? AppAssets.authShowPasswordIcon
            : AppAssets.authHidePasswordIcon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.onSurfaceVariant,
          BlendMode.srcIn,
        ),
      ),
      onPressed: onToggle,
      splashColor: theme.colorScheme.scrim,
      highlightColor: theme.colorScheme.scrim,
      hoverColor: theme.colorScheme.scrim,
    );
  }
}
