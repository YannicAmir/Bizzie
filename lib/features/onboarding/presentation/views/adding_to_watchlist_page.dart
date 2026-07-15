import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_status_card.dart';
import '../widgets/onboarding_header.dart';

import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class AddingToWatchlistPage extends StatefulWidget {
  const AddingToWatchlistPage({super.key});

  @override
  State<AddingToWatchlistPage> createState() => _AddingToWatchlistPageState();
}

class _AddingToWatchlistPageState extends State<AddingToWatchlistPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingBloc>().add(
        const OnboardingEvent.watchlistAdditionStarted(),
      );
      context.read<OnboardingBloc>().add(
        const OnboardingEvent.stepViewed(OnboardingStep.addingToWatchlist),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                const OnboardingHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
                        _WatchlistStatusIcon(
                          isWatchlistComplete: state.isWatchlistComplete,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          state.watchlistTitle,
                          style: theme.textTheme.displayLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.watchlistSubtitle,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Expanded(child: _WatchlistCompaniesList(state: state)),
                        const SizedBox(height: 24),
                        if (state.isWatchlistComplete)
                          BizziePrimaryButton(
                            onPressed: () {
                              context.go(AppRoutes.onboardingNotifications);
                            },
                            title: 'Continue',
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WatchlistCompaniesList extends StatelessWidget {
  final OnboardingState state;

  const _WatchlistCompaniesList({required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: state.onboardingData.detectedCompanies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final company = state.onboardingData.detectedCompanies[index];
        final itemStatus = state.getWatchlistItemStatus(index);

        return OnboardingStatusCard(
          title: company.name,
          subtitle: _getSubtitle(itemStatus),
          status: itemStatus,
          icon: Icon(
            _getIconData(itemStatus),
            color: itemStatus.iconColor,
            size: 24,
          ),
        );
      },
    );
  }

  String _getSubtitle(AnalysisStepStatus status) {
    switch (status) {
      case AnalysisStepStatus.completed:
        return 'Added to watchlist';
      case AnalysisStepStatus.active:
        return 'Adding to watchlist...';
      case AnalysisStepStatus.pending:
        return 'Pending';
    }
  }

  IconData _getIconData(AnalysisStepStatus status) {
    switch (status) {
      case AnalysisStepStatus.completed:
        return Icons.check;
      case AnalysisStepStatus.active:
      case AnalysisStepStatus.pending:
        return Icons.add;
    }
  }
}

class _WatchlistStatusIcon extends StatelessWidget {
  final bool isWatchlistComplete;

  const _WatchlistStatusIcon({required this.isWatchlistComplete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.blueGradientStart, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: isWatchlistComplete
              ? Image.asset(
                  AppAssets.onboardingLargeCheckIcon,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  color: Colors.white,
                  filterQuality: FilterQuality.high,
                )
              : Image.asset(
                  AppAssets.onboardingLargePlusIcon,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  color: Colors.white,
                  filterQuality: FilterQuality.high,
                ),
        ),
      ),
    );
  }
}
