import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CompanyListTile extends StatelessWidget {
  final String symbol;
  final String name;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? contentPadding;
  final ShapeBorder? shape;
  final bool showLeading;

  const CompanyListTile({
    super.key,
    required this.symbol,
    required this.name,
    required this.onTap,
    this.contentPadding,
    this.shape,
    this.showLeading = true,
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
              decoration: const BoxDecoration(
                color: AppColors.mascotBackground,
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
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
