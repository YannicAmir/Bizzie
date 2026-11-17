import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/utils/brand_toggle_helper.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/animations/bizzie_entrance_scale.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/brand_chip.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/section_visibility_animator.dart';
import 'package:material_ui/material_ui.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                  key: ValueKey('selected_${vm.brand.name}_${vm.brand.ticker}'),
                  brand: vm.brand,
                  backgroundColor: backgroundColor,
                  foregroundColor: foregroundColor,
                  iconData: Icons.close,
                  onTap: () => BrandToggleHelper.toggle(context, vm.brand),
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
      ),
    );
  }
}
