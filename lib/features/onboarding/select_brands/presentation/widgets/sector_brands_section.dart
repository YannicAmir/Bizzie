import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/brand_cloud_section.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:flutter/material.dart';

class SectorBrandsSection extends StatelessWidget {
  final String sectorName;
  final List<SelectBrandsViewModel> brands;
  final bool isMaxReached;

  const SectorBrandsSection({
    super.key,
    required this.sectorName,
    required this.brands,
    required this.isMaxReached,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    final Color backgroundColor =
        badgeTheme?.neutralBackground ?? AppColors.mascotBackground;
    final Color foregroundColor = badgeTheme?.neutralText ?? AppColors.primary;

    return Column(
      children: [
        BrandCloudSection(
          title: 'Popular $sectorName brands & products',
          brands: brands,
          isEnabled: !isMaxReached,
          chipBackgroundColor: backgroundColor,
          chipForegroundColor: foregroundColor,
          iconData: Icons.add,
        ),
      ],
    );
  }
}
