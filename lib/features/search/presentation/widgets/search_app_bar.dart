import 'package:flutter/material.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onCancel;

  const SearchAppBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: BizzieSearchBar(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onClear: onClear,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 12.0),
          child: Center(
            child: GestureDetector(
              onTap: onCancel,
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
