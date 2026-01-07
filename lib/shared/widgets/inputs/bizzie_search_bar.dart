import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BizzieSearchBar extends StatelessWidget {
  const BizzieSearchBar({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onClear,
    this.hintText = 'Search for stocks',
  });

  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.inputBorder, width: 0.67),
        ),
        child: IgnorePointer(
          ignoring: readOnly,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly,
            onChanged: onChanged,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.inputHint.copyWith(
                color: AppColors.textTertiary,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  AppAssets.searchIconLarge,
                  width: 24,
                  height: 24,
                ),
              ),
              suffixIcon: controller != null
                  ? ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller!,
                      builder: (context, value, child) {
                        if (value.text.isEmpty) return const SizedBox.shrink();
                        return IconButton(
                          icon: Image.asset(
                            AppAssets.clearTextfieldIcon,
                            width: 24,
                            height: 24,
                          ),
                          onPressed: onClear,
                        );
                      },
                    )
                  : null,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              isDense: true,
            ),
          ),
        ),
      ),
    );
  }
}
