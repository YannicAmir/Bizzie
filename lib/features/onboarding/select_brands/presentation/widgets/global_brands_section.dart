import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/brand_cloud_section.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:flutter/material.dart';

class GlobalBrandsSection extends StatelessWidget {
  final List<SelectBrandsViewModel> brands;
  final bool isMaxReached;

  const GlobalBrandsSection({
    super.key,
    required this.brands,
    required this.isMaxReached,
  });

  @override
  Widget build(BuildContext context) {
    return BrandCloudSection(
      title: 'Other popular brands & products',
      brands: brands,
      isEnabled: !isMaxReached,
      chipBackgroundColor: AppColors.slate100,
      chipForegroundColor: AppColors.brandChipOtherForeground,
      iconData: Icons.add,
    );
  }
}
