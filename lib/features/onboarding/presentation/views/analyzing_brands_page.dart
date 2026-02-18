import 'package:bizzie/app/themes/app_assets.dart';

import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/core/analytics/onboarding_tracker.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class AnalyzingBrandsPage extends StatefulWidget {
  const AnalyzingBrandsPage({super.key});

  @override
  State<AnalyzingBrandsPage> createState() => _AnalyzingBrandsPageState();
}

class _AnalyzingBrandsPageState extends State<AnalyzingBrandsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(const OnboardingEvent.startAnalysis());
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.analyzingSelectedBrands),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final isDone = state.analysisStep >= 3;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 144),
                        _AnalysisTitle(title: state.analysisTitle),
                        const SizedBox(height: 48),
                        _AnalysisStepsList(state: state),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                _ShowStocksButton(isDone: isDone),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AnalysisTitle extends StatelessWidget {
  final String title;

  const _AnalysisTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 77,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: theme.textTheme.displayLarge),
      ),
    );
  }
}

class _AnalysisStepsList extends StatelessWidget {
  final OnboardingState state;

  const _AnalysisStepsList({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingStatusCard(
          title: 'Analyzing your brands',
          icon: Image.asset(
            AppAssets.searchIcon,
            width: 24,
            height: 24,
            color: state.stepAnalysisStatus.iconColor,
          ),
          status: state.stepAnalysisStatus,
        ),
        const SizedBox(height: 16),
        OnboardingStatusCard(
          title: 'Identifying public companies',
          icon: Image.asset(
            AppAssets.arrowUpIcon,
            width: 24,
            height: 24,
            color: state.stepPublicCompaniesStatus.iconColor,
          ),
          status: state.stepPublicCompaniesStatus,
        ),
        const SizedBox(height: 16),
        OnboardingStatusCard(
          title: 'Building your watchlist',
          icon: Image.asset(
            AppAssets.circledCheckIcon,
            width: 24,
            height: 24,
            color: state.stepWatchlistStatus.iconColor,
          ),
          status: state.stepWatchlistStatus,
        ),
      ],
    );
  }
}

class _ShowStocksButton extends StatelessWidget {
  final bool isDone;

  const _ShowStocksButton({required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDone,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: OnboardingFooter(
        primaryButton: BizziePrimaryButton(
          onPressed: () {
            context.push(AppRoutes.onboardingFoundCompanies);
          },
          title: 'Show Me the Stocks',
        ),
      ),
    );
  }
}
