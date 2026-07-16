import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TabSectionDivider extends StatelessWidget {
  final String label;

  const TabSectionDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: AppConstants.editTabsDividerPadding,
      child: Row(
        children: [
          Expanded(child: Divider(color: theme.dividerTheme.color)),
          Padding(
            padding: AppConstants.editTabsDividerLabelPadding,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Divider(color: theme.dividerTheme.color)),
        ],
      ),
    );
  }
}
