import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

class BizzieFoundCompaniesPage extends StatelessWidget {
  const BizzieFoundCompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final companies = state.onboardingData.detectedCompanies;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeader(
                  title: state.foundCompaniesTitle,
                  subtitle: state.foundCompaniesSubtitle,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        const _FoundCompaniesMascot(),
                        const SizedBox(height: 32),
                        if (state.isSingleCompanyView) ...[
                          _SingleCompanyCard(company: companies.first),
                          const Spacer(),
                        ] else
                          _MultipleCompaniesList(companies: companies),
                      ],
                    ),
                  ),
                ),
                const _ContinueButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FoundCompaniesMascot extends StatelessWidget {
  const _FoundCompaniesMascot();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.onboardingBizzieMascotFoundCompanies,
        height: 238,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OnboardingFooter(
      primaryButton: ElevatedButton(
        onPressed: () {
          context.push(AppRoutes.onboardingAddingWatchlist);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          'Continue',
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SingleCompanyCard extends StatelessWidget {
  final Company company;

  const _SingleCompanyCard({required this.company});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.brandChipSelectedBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                AppAssets.arrowUpIcon,
                width: 24,
                height: 24,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  company.ticker,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MultipleCompaniesList extends StatelessWidget {
  final List<Company> companies;

  const _MultipleCompaniesList({required this.companies});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: companies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _SingleCompanyCard(company: companies[index]);
        },
      ),
    );
  }
}
