import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class BizzieFoundCompaniesPage extends StatefulWidget {
  const BizzieFoundCompaniesPage({super.key});

  @override
  State<BizzieFoundCompaniesPage> createState() =>
      _BizzieFoundCompaniesPageState();
}

class _BizzieFoundCompaniesPageState extends State<BizzieFoundCompaniesPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.companiesFound),
    );
  }

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
                        const SizedBox(height: 24),
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
        height: 179,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return OnboardingFooter(
      primaryButton: BizziePrimaryButton(
        onPressed: () {
          context.push(AppRoutes.onboardingAddingWatchlist);
        },
        title: 'Continue',
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
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: badgeTheme?.neutralBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.businessIcon,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.tertiary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(company.ticker, style: theme.textTheme.bodyMedium),
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
