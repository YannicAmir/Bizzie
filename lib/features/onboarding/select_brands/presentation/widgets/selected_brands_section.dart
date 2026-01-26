import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/animations/bizzie_entrance_scale.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/brand_chip.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/section_visibility_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedBrandsSection extends StatelessWidget {
  final List<SelectBrandsViewModel> brands;

  const SelectedBrandsSection({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color backgroundColor = theme.colorScheme.primary;
    final Color foregroundColor = theme.colorScheme.onPrimary;

    return SectionVisibilityAnimator(
      isVisible: brands.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your brands', style: AppTextStyles.bodyMediumBold),
          AppConstants.onboardSecondarySectionSpacing,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: brands.map((vm) {
              final child = BrandChip(
                key: ValueKey(vm.brand.name),
                brand: vm.brand,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                iconData: Icons.close,
                onTap: () => context.read<SelectBrandsBloc>().add(
                  SelectBrandsEvent.toggleBrand(vm.brand),
                ),
              );

              if (vm.shouldAnimate) {
                return BizzieEntranceScale(
                  key: ValueKey(vm.brand.name),
                  child: child,
                );
              }
              return child;
            }).toList(),
          ),
          AppConstants.onboardSectionSpacing,
        ],
      ),
    );
  }
}
