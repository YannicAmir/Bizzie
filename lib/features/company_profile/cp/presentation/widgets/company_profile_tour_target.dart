import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/extensions/company_profile_tour_state_extensions.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_scope.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_skip_button.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_tooltip.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

const _overlayOpacity = 0.7;
const _companionTargetPadding = EdgeInsets.symmetric(vertical: 4);
const _revenueTabTargetPadding = EdgeInsets.symmetric(
  horizontal: 20,
  vertical: 4,
);
const _sectionTargetPadding = EdgeInsets.all(8);
const _targetBorderRadius = BorderRadius.all(
  Radius.circular(AppConstants.cardBorderRadius),
);
const _autoScrollSteps = {
  CompanyProfileTourStep.revenueTab,
  CompanyProfileTourStep.revenueGrowth,
};

EdgeInsets _targetPaddingFor(CompanyProfileTourStep step) => switch (step) {
  CompanyProfileTourStep.companyOverview ||
  CompanyProfileTourStep.tabs => EdgeInsets.zero,
  CompanyProfileTourStep.revenueTab => _revenueTabTargetPadding,
  CompanyProfileTourStep.revenueGrowth ||
  CompanyProfileTourStep.stayUpdated => _sectionTargetPadding,
};

class CompanyProfileTourTarget extends StatelessWidget {
  final CompanyProfileTourStep step;
  final VoidCallback? onTargetTap;
  final Widget child;

  const CompanyProfileTourTarget({
    super.key,
    required this.step,
    this.onTargetTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isTourActive = context.select<CompanyProfileTourBloc, bool>(
      (bloc) => bloc.state.isTourActive,
    );
    if (!isTourActive) return child;

    final description = context.select<CompanyProfileTourBloc, String?>(
      (bloc) => bloc.state.descriptionFor(step),
    );

    final canGoBack = context.select<CompanyProfileTourBloc, bool>(
      (bloc) => bloc.state.canGoBackFrom(step),
    );
    final mascotAsset = context.select<UserBloc, String>(
      (bloc) => bloc.state.mascotAsset,
    );
    final tourBloc = context.read<CompanyProfileTourBloc>();
    final onTargetTap = this.onTargetTap;
    final screenMargin = AppConstants.pagePadding.right;
    final safeAreaBottom = MediaQueryData.fromView(
      View.of(context),
    ).viewPadding.bottom;
    final isLastStep = step.next == null;
    final advanceTour = onTargetTap == null
        ? () => CompanyProfileTourScope.showcaseView.next()
        : null;

    return Showcase.withWidget(
      key: CompanyProfileTourScope.targetKey(step),
      scope: CompanyProfileTourScope.scopeName,
      container: _TourStepTooltip(
        description: description,
        mascotAsset: mascotAsset,
        width: MediaQuery.sizeOf(context).width - screenMargin * 2,
        onNext: advanceTour,
        onPrevious: canGoBack
            ? () => tourBloc.add(
                const CompanyProfileTourEvent.previousRequested(),
              )
            : null,
      ),
      toolTipMargin: screenMargin,
      targetPadding: _targetPaddingFor(step),
      targetBorderRadius: _targetBorderRadius,
      overlayColor: AppColors.slate900,
      overlayOpacity: _overlayOpacity,
      enableAutoScroll: _autoScrollSteps.contains(step),
      disableBarrierInteraction: onTargetTap != null,
      onTargetClick: onTargetTap,
      disposeOnTap: onTargetTap == null ? null : false,
      floatingActionWidget: isLastStep
          ? null
          : FloatingActionWidget(
              right: screenMargin,
              bottom: safeAreaBottom + screenMargin,
              child: CompanyProfileTourSkipButton(
                onPressed: () =>
                    tourBloc.add(const CompanyProfileTourEvent.skipRequested()),
              ),
            ),
      child: child,
    );
  }
}

class CompanyProfileTourCompanionTarget extends StatelessWidget {
  final CompanyProfileTourStep step;
  final Widget child;

  const CompanyProfileTourCompanionTarget({
    super.key,
    required this.step,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      key: CompanyProfileTourScope.targetKey(step),
      scope: CompanyProfileTourScope.scopeName,
      container: const SizedBox.shrink(),
      targetPadding: _companionTargetPadding,
      targetBorderRadius: _targetBorderRadius,
      overlayColor: AppColors.slate900,
      overlayOpacity: _overlayOpacity,
      child: child,
    );
  }
}

class _TourStepTooltip extends StatelessWidget {
  final String? description;
  final String mascotAsset;
  final double width;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const _TourStepTooltip({
    required this.description,
    required this.mascotAsset,
    required this.width,
    this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final description = this.description;
    if (description == null) return const SizedBox.shrink();

    return CompanyProfileTourTooltip(
      description: description,
      mascotAsset: mascotAsset,
      width: width,
      onTooltipTap: onNext,
      onNext: onNext,
      onPrevious: onPrevious,
    );
  }
}
