import 'package:bizzie/app/themes/app_assets.dart';

import 'package:flutter/material.dart';

class CompanyListTile extends StatelessWidget {
  final String symbol;
  final String name;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? contentPadding;
  final ShapeBorder? shape;
  final Widget? trailing;
  final bool showLeading;

  const CompanyListTile({
    super.key,
    required this.symbol,
    required this.name,
    required this.onTap,
    this.contentPadding,
    this.shape,
    this.showLeading = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      shape: shape,
      leading: showLeading
          ? Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Image.asset(AppAssets.businessIcon),
            )
          : null,
      title: Text(
        symbol,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        name,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
    );
  }
}
