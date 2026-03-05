import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/global_brands_section.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/sector_brands_section.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/widgets/selected_brands_section.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class SelectYourFavoriteBrandsPage extends StatefulWidget {
  const SelectYourFavoriteBrandsPage({super.key});

  @override
  State<SelectYourFavoriteBrandsPage> createState() =>
      _SelectYourFavoriteBrandsPageState();
}

class _SelectYourFavoriteBrandsPageState
    extends State<SelectYourFavoriteBrandsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.brandsSelection),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final onboardingBloc = context.read<OnboardingBloc>();
        final useCase = getIt<GetDailyBrandsUseCase>();
        return SelectBrandsBloc(onboardingBloc, useCase)
          ..add(const SelectBrandsEvent.started());
      },
      child: const _SelectYourFavoriteBrandsView(),
    );
  }
}

class _SelectYourFavoriteBrandsView extends StatelessWidget {
  const _SelectYourFavoriteBrandsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OnboardingHeader(
              title: 'Select your favorite brands & products',
              subtitle: 'Select up to 5. You can search for more later',
            ),
            const Expanded(child: _BrandsListContent()),
            const _StickyFooter(),
          ],
        ),
      ),
    );
  }
}

class _BrandsListContent extends StatelessWidget {
  const _BrandsListContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<SelectBrandsBloc, SelectBrandsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const SizedBox.shrink(),
            error: (errorState) => BizzieError(
              message: 'Error loading brands',
              onRetry: () {
                context.read<SelectBrandsBloc>().add(
                  const SelectBrandsEvent.started(),
                );
              },
            ),
            loaded: (loadedState) => _LoadedBrandsList(
              selectedBrands: loadedState.selectedBrands,
              sectorBrands: loadedState.sectorBrands,
              globalBrands: loadedState.globalBrands,
              isMaxBrandsReached: state.isMaxReached,
              sectorName: loadedState.sectorName,
            ),
          );
        },
      ),
    );
  }
}

class _LoadedBrandsList extends StatelessWidget {
  final List<SelectBrandsViewModel> selectedBrands;
  final List<SelectBrandsViewModel> sectorBrands;
  final List<SelectBrandsViewModel> globalBrands;
  final bool isMaxBrandsReached;
  final String sectorName;

  const _LoadedBrandsList({
    required this.selectedBrands,
    required this.sectorBrands,
    required this.globalBrands,
    required this.isMaxBrandsReached,
    required this.sectorName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConstants.onboardSectionSpacing,
        SelectedBrandsSection(brands: selectedBrands),
        if (sectorName != 'Your Sector')
          SectorBrandsSection(
            sectorName: sectorName,
            brands: sectorBrands,
            isMaxReached: isMaxBrandsReached,
          ),
        AppConstants.onboardSectionSpacing,
        GlobalBrandsSection(
          brands: globalBrands,
          isMaxReached: isMaxBrandsReached,
        ),
        AppConstants.onboardSectionSpacing,
      ],
    );
  }
}

class _StickyFooter extends StatelessWidget {
  const _StickyFooter();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SelectBrandsBloc,
      SelectBrandsState,
      ({int count, bool isEnabled})
    >(
      selector: (state) {
        return state.map(
          initial: (_) => (count: 0, isEnabled: false),
          error: (_) => (count: 0, isEnabled: false),
          loaded: (loaded) => (
            count: loaded.selectedBrands.length,
            isEnabled: loaded.selectedBrands.isNotEmpty,
          ),
        );
      },
      builder: (context, data) {
        return OnboardingFooter(
          primaryButton: SizedBox(
            width: double.infinity,
            child: BizziePrimaryButton(
              onPressed: data.isEnabled
                  ? () {
                      context.push(AppRoutes.onboardingAnalyzing);
                    }
                  : null,
              title: data.count == 0 ? 'Continue' : 'Continue (${data.count})',
            ),
          ),
        );
      },
    );
  }
}
