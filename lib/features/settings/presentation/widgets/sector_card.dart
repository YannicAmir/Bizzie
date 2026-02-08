import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/models/sector_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SectorCard extends StatelessWidget {
  final SectorViewModel sector;
  final bool isSelected;
  final VoidCallback onTap;

  const SectorCard({
    super.key,
    required this.sector,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: theme.colorScheme.primary, width: 1.5)
              : Border.all(color: theme.colorScheme.outline, width: 1.5),
        ),
        child: Row(
          children: [
            Image.asset(
              AppAssets.getMascotForSector(sector.sector.name),
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sector.displayName,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sector.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              opacity: isSelected ? 1.0 : 0.0,
              child: Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
