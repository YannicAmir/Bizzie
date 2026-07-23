import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class CompanyListTile extends StatelessWidget {
  final String symbol;
  final String name;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? contentPadding;
  final ShapeBorder? shape;
  final Widget? leading;
  final Widget? trailing;
  final bool showLeading;
  final Color? backgroundColor;

  const CompanyListTile({
    super.key,
    required this.symbol,
    required this.name,
    required this.onTap,
    this.contentPadding,
    this.shape,
    this.showLeading = true,
    this.leading,
    this.trailing,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            contentPadding ??
            const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: theme.dividerColor,
            width: theme.dividerTheme.thickness ?? .665,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (showLeading) ...[
              leading ??
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(AppAssets.businessIcon),
                  ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    symbol,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 16), trailing!],
          ],
        ),
      ),
    );
  }
}
