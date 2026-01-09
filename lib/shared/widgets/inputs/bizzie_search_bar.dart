import 'package:bizzie/app/themes/app_assets.dart';
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
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        ignoring: readOnly,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          onChanged: onChanged,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.inputDecorationTheme.fillColor,
            hintText: hintText,
            hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerTheme.color ?? theme.colorScheme.outline,
                width: 0.67,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerTheme.color ?? theme.colorScheme.outline,
                width: 0.67,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerTheme.color ?? theme.colorScheme.outline,
                width: 0.67,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerTheme.color ?? theme.colorScheme.outline,
                width: 0.67,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            isDense: true,
          ),
        ),
      ),
    );
  }
}
