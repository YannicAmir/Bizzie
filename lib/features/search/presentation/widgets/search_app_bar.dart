import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onCancel;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const SearchAppBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
    required this.onCancel,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: BizzieSearchBar(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onClear: onClear,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        showPlusBadge: false,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Center(
            child: TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 48),
                foregroundColor: theme.colorScheme.primary,
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                'Cancel',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
