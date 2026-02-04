import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/brand_chip.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/section_visibility_animator.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/animations/bizzie_entrance_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandCloudSection extends StatelessWidget {
  final String title;
  final List<SelectBrandsViewModel> brands;
  final bool isEnabled;
  final Color chipBackgroundColor;
  final Color chipForegroundColor;
  final Color? chipBorderColor;
  final IconData? iconData;

  const BrandCloudSection({
    super.key,
    required this.title,
    required this.brands,
    this.isEnabled = true,
    required this.chipBackgroundColor,
    required this.chipForegroundColor,
    this.chipBorderColor,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SectionVisibilityAnimator(
      isVisible: brands.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyMediumBold),
          AppConstants.onboardSecondarySectionSpacing,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: brands.asMap().entries.map((entry) {
              final index = entry.key;
              final vm = entry.value;
              final key = ValueKey('${vm.brand.name}_$index');

              final child = BrandChip(
                key: key,
                brand: vm.brand,
                backgroundColor: chipBackgroundColor,
                foregroundColor: chipForegroundColor,
                borderColor: chipBorderColor,
                iconData: iconData,
                isEnabled: isEnabled,
                leadingIcon: true,
                onTap: () => context.read<SelectBrandsBloc>().add(
                  SelectBrandsEvent.toggleBrand(vm.brand),
                ),
              );

              if (vm.shouldAnimate) {
                return BizzieEntranceScale(key: key, child: child);
              }
              return child;
            }).toList(),
          ),
        ],
      ),
    );
  }
}
